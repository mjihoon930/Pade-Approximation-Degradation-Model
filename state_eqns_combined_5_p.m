function [out] = state_eqns_combined_5_p(in)
persistent p5
t=in(1);

if t==0
    p5 = evalin('base','p5');
end

u = in(2);
x = in(3:7); %state vector

%state equations of the positive electrode
out(1) = x(2);
out(2) = x(3);
out(3) = x(4);
out(4) = x(5);
out(5) = (-1/p5.b5_p)*x(2) + (-p5.b2_p/p5.b5_p)*x(3) + (-p5.b3_p/p5.b5_p)*x(4) + (-p5.b4_p/p5.b5_p)*x(5) + (1/p5.b5_p)*u;

end