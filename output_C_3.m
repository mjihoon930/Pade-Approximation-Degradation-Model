function C = output_C_3(in)

persistent   p3 C_avg_n

t=in(1);

if t==0

    p3 = evalin('base','p3');
    C_avg_n = evalin('base','C_avg_n');
end


x = in(2:7); %state vector 
x_dot = in(8:10); %differential state vector 

C(1) = p3.a0_p*x(1) + p3.a1_p*x(2) + p3.a2_p*x(3); %positive sufrace concentration
C(2) = p3.a0_n*x(4) + p3.a1_n*x(5) + p3.a2_n*x(6) + p3.a3_n*x_dot(3) + C_avg_n; %negative sufrace concentration

end