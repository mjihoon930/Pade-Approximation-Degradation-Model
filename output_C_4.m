function C = output_C_4(in)

persistent   p4 C_avg_n

t=in(1);

if t==0

    p4 = evalin('base','p4');
    C_avg_n = evalin('base','C_avg_n');
end


x = in(2:9); %state vector 
x_dot = in(10:13); %differential state vector 

C(1) = p4.a0_p*x(1) + p4.a1_p*x(2) + p4.a2_p*x(3) + p4.a3_p*x(4); %positive sufrace concentration
C(2) = p4.a0_n*x(5) + p4.a1_n*x(6) + p4.a2_n*x(7) + p4.a3_n*x(8) + p4.a4_n*x_dot(4) + C_avg_n; %negative sufrace concentration

end