function T_dot = output_T(in)

persistent   n p c Q_nom a_p a_n 

t=in(1);

if t==0   
    
    n = evalin('base','n');
    p = evalin('base','p');
    c = evalin('base','c');    
    Q_nom = evalin('base','Q_nom');
    a_p = evalin('base','a_p');
    a_n = evalin('base','a_n');    
   
end

u=in(2);
x = in(3);
c_p = in(4);
c_n = in(5);
T = in(6);

T_dot = (1.7*10^(-3))*(298.15-T)-((u*T)/48.52)*(-3.23*10^(-4)+(5.89*10^(-4))*(x(1)/Q_nom)+(3.03*10^(-3))*((x(1)/Q_nom)^2)-(7.11*10^(-3))*((x(1)/Q_nom)^3)+(3.93*10^(-4))*((x(1)/Q_nom)^4))-((u*T)/48.52)*(((2*c.R_u*T)/c.F)*(asinh(-u/(2*p.A_p*p.L_p*a_p*(c.k_ref_p*exp((c.E_a_p/c.R_u)*((1/T)-(1/c.T_ref))))*(c.c_e*c_p*(p.c_max_p-c_p))^(0.5)))-asinh(-u/(2*n.A_n*n.L_n*a_n*(c.k_ref_n*exp((c.E_a_n/c.R_u)*((1/T)-(1/c.T_ref))))*(c.c_e*c_n*(n.c_max_n-c_n))^(0.5))))) - ((p.R_film_p/(p.A_p*p.L_p*a_p))+(n.R_film_n/(n.A_n*n.L_n*a_n)) + c.R_c)*u;


end