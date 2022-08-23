function [out] = state_eqns_combined_6_n(in)
persistent p6 d n C_avg_n a_n c
t=in(1);

if t==0
    p6 = evalin('base','p6');
    d = evalin('base','d');
    n = evalin('base','n');
    c = evalin('base','c');
    a_n = evalin('base','a_n');
    C_avg_n = evalin('base','C_avg_n');
end

u = in(2);
x = in(3:8); %state vector

%input of the state space model
U = (1/(n.D_n*a_n*c.F))*((u/(n.A_n*n.L_n)) - d.J_bar - d.alpha*C_avg_n + d.alpha*d.c_bar - d.beta*u + d.beta*d.u_bar);

%state equations of the negative electrode
out(1) = x(2);
out(2) = x(3);
out(3) = x(4);
out(4) = x(5);
out(5) = x(6);
out(6) = (-1/p6.b7_n)*x(1) + (-p6.b2_n/p6.b7_n)*x(2) + (-p6.b3_n/p6.b7_n)*x(3) + (-p6.b4_n/p6.b7_n)*x(4) + (-p6.b5_n/p6.b7_n)*x(5) + (-p6.b6_n/p6.b7_n)*x(6) + (1/p6.b7_n)*U;

end