%% trial 

%% Test simple interaction task
%%Addpath 
include_namespace_dq;

%% Desired trajectory

cdt = 0.01; %sampling time (10ms)
[xd,dxd,ddxd,rot] = gen_traj(z0,or_in',time); %minimum jerk trajectory (desired)

%% Connect to VREP

disp('Program started');
sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
sim.simxFinish(-1); % just in case, close all opened connections

clientID=sim.simxStart('127.0.0.1',19997,true,true,5000,5);

i=1;
vi = DQ_VrepInterface;

%% Initialize VREP Robots
fep_vreprobot = FEpVrepRobot('Franka',vi);

%% Load DQ Robotics kinematics

if (clientID>-1)
    disp('Connected to remote API server');
    
    handles = get_joint_handles(sim,clientID);
    joint_handles = handles.armJoints;
    fep  = fep_vreprobot.kinematics(); 
    
    
    for j=1:7
        [res,q(j)] = sim.simxGetJointPosition(clientID,joint_handles(j),sim.simx_opmode_buffer);
        [res,qdot(j)] = sim.simxGetObjectFloatParameter(clientID,joint_handles(j),2012,sim.simx_opmode_buffer);
    end
   
    
    %% Setting to synchronous mode
    %---------------------------------------
    sim.simxSynchronous(clientID,true)   
    sim.simxSynchronousTrigger(clientID)
    sim.simxSetFloatingParameter(clientID, sim.sim_floatparam_simulation_time_step, cdt, sim.simx_opmode_oneshot)
    %start simulation
    sim.simxStartSimulation(clientID, sim.simx_opmode_blocking);
    %---------------------------------------
    
    %% Get joint positions
    %---------------------------------------
    for j=1:7
        [~,tauOrig(j)] = sim.simxGetJointForce(clientID,joint_handles(j),sim.simx_opmode_blocking);
        [~,qmread(j)]  = sim.simxGetJointPosition(clientID,joint_handles(j),sim.simx_opmode_blocking);
    end      
    qm = double([qmread])';
    
    % Saving data to analyze later
    sres.xd = [];  sres.xd_dot = [];  sres.xd_ddot = [];
    sres.x = []; sres.xref = []; sres.f_ext = []; sres.eul = []; 
    %---------------------------------------    
    % time
    inittime = sim.simxGetLastCmdTime(clientID);
    
%% Control loop   
    while sim.simxGetConnectionId(clientID)~=-1
        
        if i>size(time,2)
            break
        end
        
        % Getting joint-position
        %---------------------------------------    
        for j=1:7
            [~,tauOrig(j)] = sim.simxGetJointForce(clientID,joint_handles(j),sim.simx_opmode_blocking);
            [~,qmread(j)]  = sim.simxGetJointPosition(clientID,joint_handles(j),sim.simx_opmode_blocking);
        end      
        qmOld = qm;

        % Current joint configuration 
        qm = double([qmread])';
        
        % Current EE configuration
        [p,R1] = DirectKinematic(DH,[qm;0],Conv);
        x = p; % current ee position

        phi = atan2(R1(2,1),R1(1,1));
        teta = atan2(-R1(3,1),sqrt(R1(3,2)^2 + R1(3,3)^2)); 
        psi = atan2(R1(3,2),R1(3,3));
        r = [phi teta psi]'; % current orientation

        % Analytical Jacobian
        Jp = get_Ja(qm); 
        Jpose = fep.pose_jacobian(qm); %DQ pose jacobian (for null-space controller)
        
        % Current joint derivative (Euler 1st order derivative)
        qm_dot = (qm-qmOld)/cdt; %computed as vrep function 
        
        %Current 1st-time derivative of EE pose
        dx = Jp(1:3,1:7)*qm_dot;
       
        % Pose Jacobian first-time derivative 
        Jp_dot = get_Ja_dot(qm,qm_dot);

        %---------------------------------------    

        % Desired trajectory position,velocity acceleration
        xd_des = xd(i,:)';
        dxd_des = dxd(i,:)';
        ddxd_des = ddxd(i,:)'; 

        % Printing the time step of the simulation and the error
        % -----------------------
       
        disp(['it: ',num2str(i),' time(',num2str(i*cdt),') - error:',num2str(norm(xd_des-x))])
      
        
        % Saving data to analyze later
        % -----------------------
        
        sres.xd(:,i) = xd_des;  sres.xd_dot(:,i) = dxd_des;  sres.xd_ddot(:,i) = ddxd_des;
        sres.x(:,i) = x; 
        sres.eul(:,i) = r; 
      
        % -----------------------        
        
        % Using the dynamic model
        g = get_GravityVector(qm);
        c = get_CoriolisVector(qm,qm_dot);
        M = get_MassMatrix(qm); 
        tauf = get_FrictionTorque(qm_dot);                

    %%  Task-space inverse dynamics with fb linearization
         kp = 100;
         kd = 10;
         
         %% Define error (task-space)
         e = x - xd_des; %position error
         or_e = r - rot(i,:)'; %rotation error
         err = [e;or_e];
         de =  dx - dxd_des; %linear velocity error
         de_or = Jp(4:6,1:7)*qm_dot;
         derr = [de;de_or]; %fixed desired orientation
         a_des = [ddxd_des;0;0;0]; %desired acceleration

         %task-space inverse dynamics + fb linearization
         y = pinv(Jp)*(a_des - Jp_dot*qm_dot  - kp*eye(6)*err - kd*eye(6)*derr);
         tau = M*y + c + g; 
         
         N = haminus8(DQ(xd_des))*DQ.C8*Jpose;
         robustpseudoinverse = N'*pinv(N*N' + 0.1*eye(8));
         
         %%%%%%%% null space control %%%%%%%%%
         P = eye(7) - pinv(N)*N;
         D_joints = eye(7)*2;
         tau_null = P*(-D_joints*qm_dot);
         tau = tau + tau_null;
         
         %Sent torque commands
         tau_send = tau;
         sres.tau_send(:,i) = tau_send;
         
        %---------------------------------------
             
        %% Send torques to vrep
        for j=1:7
            if tau(j)<0
                set_vel = -99999;
            else
                set_vel = 99999;
            end
            % blocking mode
            %---------------------------------         
            sim.simxSetJointTargetVelocity(clientID,joint_handles(j),set_vel,sim.simx_opmode_blocking);            
            sim.simxSetJointForce(clientID,joint_handles(j),abs(tau(j)),sim.simx_opmode_blocking);
            [~,tau_read] = sim.simxGetJointForce(clientID,joint_handles(j),sim.simx_opmode_blocking);
            tau_read_data(:,j) = tau_read;   
        end
        
        sres.tau_read(i,:) = tau_read_data';
        %---------------------------------
        sim.simxSynchronousTrigger(clientID);
        %---------------------------------
        i = i+1;        
    end
    
    % Now close the connection to V-REP:
    sim.simxStopSimulation(clientID,sim.simx_opmode_blocking);
    sim.simxFinish(clientID);
else
    disp('Failed connecting to remote API server');
end
sim.delete(); % call the destructor!

%% PLOTS if wanted

figure(); 
plot(tt,sres.tau_read(:,1),'m--','LineWidth',3); 
hold on, grid on
plot(tt,sres.tau_send(1,:),'m','LineWidth',2);
hold on, grid on
plot(tt,sres.tau_send(2,:),'b--','LineWidth',3); 
hold on, grid on
plot(tt,sres.tau_read(:,2),'b','LineWidth',2);
hold on, grid on
plot(tt,sres.tau_send(3,:),'g--','LineWidth',3); 
hold on, grid on
plot(tt,sres.tau_read(:,3),'g','LineWidth',2);
hold on, grid on
plot(tt,sres.tau_send(4,:),'k--','LineWidth',3); 
hold on, grid on
plot(tt,sres.tau_read(:,4),'k','LineWidth',2);
hold on, grid on
plot(tt,sres.tau_send(5,:),'r--','LineWidth',3); 
hold on, grid on
plot(tt,sres.tau_read(:,5),'r','LineWidth',2);
hold on, grid on
plot(tt,sres.tau_send(6,:),'c--','LineWidth',3); 
hold on, grid on
plot(tt,sres.tau_read(:,6),'c','LineWidth',2);
hold on, grid on
plot(tt,sres.tau_send(7,:),'y--','LineWidth',3); 
hold on, grid on
plot(tt,sres.tau_read(:,7),'y','LineWidth',2);
legend('tsend','tread'); 

%%Plot ee-position
figure();
plot(tt,sres.xd(1,:),'r--','LineWidth',3); 
hold on, grid on
plot(tt,sres.x(1,:),'c','LineWidth',2);
hold on, grid on
plot(tt,sres.xref(1,:),'b','LineWidth',2)
legend('xc','x','xd')
figure();
plot(tt,sres.xd(2,:),'r--','LineWidth',3); 
hold on, grid on
plot(tt,sres.x(2,:),'c','LineWidth',2);
hold on,grid on
plot(tt,sres.xref(2,:),'b','LineWidth',2)
legend('yc','y','yd')
figure()
plot(tt,sres.xd(3,:),'r--','LineWidth',3); 
hold on, grid on
plot(tt,sres.x(3,:),'c','LineWidth',2);
hold on,grid on
plot(tt,sres.xref(3,:),'b','LineWidth',2)
legend('zc','z','zd')

%%Plot euler angles 

%%Plot ext force
figure()
plot(tt,sres.fext(1,:),'LineWidth',2);
hold on, grid on
plot(tt,sres.fext(2,:),'LineWidth',2);
hold on,grid on
plot(tt,sres.fext(3,:),'LineWidth',2);
