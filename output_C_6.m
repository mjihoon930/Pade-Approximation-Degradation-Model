function C = output_C_6(in)

persistent   p6 C_avg_n

t=in(1);

if t==0

    p6 = evalin('base','p6');
    C_avg_n = evalin('base','C_avg_n');
end


x = in(2:13); %state vector 
x_dot = in(14:19); %differential state vector 

C(1) = p6.a0_p*x(1) + p6.a1_p*x(2) + p6.a2_p*x(3) + p6.a3_p*x(4) + p6.a4_p*x(5) + p6.a5_p*x(6); %positive sufrace concentration
C(2) = p6.a0_n*x(7) + p6.a1_n*x(8) + p6.a2_n*x(9) + p6.a3_n*x(10) + p6.a4_n*x(11) + p6.a5_n*x(12) + p6.a6_n*x_dot(6) + C_avg_n; %negative sufrace concentration

end