function [out] = state_eqns_combined_3_n(in)
persistent p3 d n C_avg_n a_n c
t=in(1);

if t==0
    p3 = evalin('base','p3');
    d = evalin('base','d');
    n = evalin('base','n');
    c = evalin('base','c');
    a_n = evalin('base','a_n');
    C_avg_n = evalin('base','C_avg_n');
end

u = in(2);
x = in(3:5); %state vector

%input of the state space model
U = (1/(n.D_n*a_n*c.F))*((u/(n.A_n*n.L_n)) - d.J_bar - d.alpha*C_avg_n + d.alpha*d.c_bar - d.beta*u + d.beta*d.u_bar);

%state equations of the negative electrode
out(1) = x(2);
out(2) = x(3);
out(3) = (-1/p3.b4_n)*x(1) + (-p3.b2_n/p3.b4_n)*x(2) + (-p3.b3_n/p3.b4_n)*x(3) + (1/p3.b4_n)*U;

end