function [out] = state_eqns_combined_2_n(in)
persistent p2 d n C_avg_n a_n c
t=in(1);

if t==0
    p2 = evalin('base','p2');
    d = evalin('base','d');
    n = evalin('base','n');
    c = evalin('base','c');
    a_n = evalin('base','a_n');
    C_avg_n = evalin('base','C_avg_n');
end

u = in(2);
x = in(3:4); %state vector

%input of the state space model
U = (1/(n.D_n*a_n*c.F))*((u/(n.A_n*n.L_n)) - d.J_bar - d.alpha*C_avg_n + d.alpha*d.c_bar - d.beta*u + d.beta*d.u_bar);

%state equations of the negative electrode
out(1) = x(2);
out(2) = (-1/p2.b3_n)*x(1) + (-p2.b2_n/p2.b3_n)*x(2) + (1/p2.b3_n)*U;

end