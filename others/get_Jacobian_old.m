function J = get_Jacobian(q)

q1 = q(1);
q2 = q(2);
q3 = q(3);
q4 = q(4);
q5 = q(5);
q6 = q(6);
q7 = q(7);

J1 = [sin(q1)*(cos(q2)*(cos(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - (33*cos(q3))/400 + sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) + sin(q2)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) + 79/250)) - cos(q1)*((33*sin(q3))/400 - sin(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) + cos(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)), cos(q1)*(sin(q2)*(cos(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - (33*cos(q3))/400 + sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q2)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) + 79/250)), sin(q1)*(cos(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - (33*cos(q3))/400 + sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q1)*cos(q2)*((33*sin(q3))/400 - sin(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) + cos(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)), cos(q1)*(sin(q2)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q2)*cos(q3)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000))) + sin(q1)*sin(q3)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000)), - sin(q1)*(cos(q3)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000) - cos(q4)*sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q1)*(cos(q2)*(cos(q5)*sin(q3)*((11*cos(q6))/125 + (107*sin(q6))/1000) + cos(q3)*cos(q4)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - sin(q2)*sin(q4)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)), sin(q1)*(sin(q3)*(sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) - cos(q4)*cos(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) - cos(q3)*sin(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) - cos(q1)*(cos(q2)*(cos(q3)*(sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) - cos(q4)*cos(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) + sin(q3)*sin(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) + sin(q2)*(cos(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) + cos(q5)*sin(q4)*((107*cos(q6))/1000 - (11*sin(q6))/125))), 0];
J2 = [- sin(q1)*((33*sin(q3))/400 - sin(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) + cos(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q1)*(cos(q2)*(cos(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - (33*cos(q3))/400 + sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) + sin(q2)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) + 79/250)), sin(q1)*(sin(q2)*(cos(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - (33*cos(q3))/400 + sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q2)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) + 79/250)), - cos(q1)*(cos(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - (33*cos(q3))/400 + sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q2)*sin(q1)*((33*sin(q3))/400 - sin(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) + cos(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)), sin(q1)*(sin(q2)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q2)*cos(q3)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000))) - cos(q1)*sin(q3)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000)), cos(q1)*(cos(q3)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000) - cos(q4)*sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - sin(q1)*(cos(q2)*(cos(q5)*sin(q3)*((11*cos(q6))/125 + (107*sin(q6))/1000) + cos(q3)*cos(q4)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - sin(q2)*sin(q4)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)), - cos(q1)*(sin(q3)*(sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) - cos(q4)*cos(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) - cos(q3)*sin(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) - sin(q1)*(cos(q2)*(cos(q3)*(sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) - cos(q4)*cos(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) + sin(q3)*sin(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) + sin(q2)*(cos(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) + cos(q5)*sin(q4)*((107*cos(q6))/1000 - (11*sin(q6))/125))), 0];
J3 = [0, - cos(q2)*(cos(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - (33*cos(q3))/400 + sin(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - sin(q2)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) + 79/250), -sin(q2)*((33*sin(q3))/400 - sin(q3)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) + cos(q3)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)), - cos(q2)*((33*cos(q4))/400 + sin(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - cos(q4)*cos(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q3)*sin(q2)*(cos(q4)*((11*sin(q6))/125 - (107*cos(q6))/1000 + 48/125) - (33*sin(q4))/400 + cos(q5)*sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000)), - sin(q2)*(cos(q5)*sin(q3)*((11*cos(q6))/125 + (107*sin(q6))/1000) + cos(q3)*cos(q4)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000)) - cos(q2)*sin(q4)*sin(q5)*((11*cos(q6))/125 + (107*sin(q6))/1000), cos(q2)*(cos(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) + cos(q5)*sin(q4)*((107*cos(q6))/1000 - (11*sin(q6))/125)) - sin(q2)*(cos(q3)*(sin(q4)*((11*cos(q6))/125 + (107*sin(q6))/1000) - cos(q4)*cos(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)) + sin(q3)*sin(q5)*((107*cos(q6))/1000 - (11*sin(q6))/125)), 0];

J = [J1; J2; J3];


end
