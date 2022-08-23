function C = output_C_5(in)

persistent   p5 C_avg_n

t=in(1);

if t==0

    p5 = evalin('base','p5');
    C_avg_n = evalin('base','C_avg_n');
end


x = in(2:11); %state vector 
x_dot = in(12:16); %differential state vector 

C(1) = p5.a0_p*x(1) + p5.a1_p*x(2) + p5.a2_p*x(3) + p5.a3_p*x(4) + p5.a4_p*x(5); %positive sufrace concentration
C(2) = p5.a0_n*x(6) + p5.a1_n*x(7) + p5.a2_n*x(8) + p5.a3_n*x(9) + p5.a4_n*x(10) + p5.a5_n*x_dot(5) + C_avg_n; %negative sufrace concentration

end