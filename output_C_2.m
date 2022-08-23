function [C] = output_C_2(in)

persistent   p2 C_avg_n 

t=in(1);

if t==0

    p2 = evalin('base','p2');
    C_avg_n = evalin('base','C_avg_n');
   
end

x = in(2:5); %state vector 
x_dot = in(6:7); %differential state vector

C(1) = p2.a0_p*x(1) + p2.a1_p*x(2); %positive sufrace concentration
C(2) = p2.a0_n*x(3) + p2.a1_n*x(4) + p2.a2_n*x_dot(2) + C_avg_n; %negative sufrace concentration

end