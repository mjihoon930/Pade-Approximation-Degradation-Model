function [out] = state_eqns_combined_3_p(in)
persistent p3
t=in(1);

if t==0
    p3 = evalin('base','p3');
end

u = in(2);
x = in(3:5); %state vector

%state equations of the positive electrode
out(1) = x(2);
out(2) = x(3);
out(3) = (-1/p3.b3_p)*x(2) + (-p3.b2_p/p3.b3_p)*x(3) + (1/p3.b3_p)*u;

end