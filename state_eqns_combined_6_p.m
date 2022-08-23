function [out] = state_eqns_combined_6_p(in)
persistent p6
t=in(1);

if t==0
    p6 = evalin('base','p6');
end

u = in(2);
x = in(3:8); %state vector

%state equations of the positive electrode
out(1) = x(2);
out(2) = x(3);
out(3) = x(4);
out(4) = x(5);
out(5) = x(6);
out(6) = (-1/p6.b6_p)*x(2) + (-p6.b2_p/p6.b6_p)*x(3) + (-p6.b3_p/p6.b6_p)*x(4) + (-p6.b4_p/p6.b6_p)*x(5) + (-p6.b5_p/p6.b6_p)*x(6) + (1/p6.b6_p)*u;

end