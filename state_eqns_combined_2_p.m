function [out] = state_eqns_combined_2_p(in)
persistent p2
t=in(1);

if t==0
    p2 = evalin('base','p2');
end

u = in(2);
x = in(3:4); %state vector

%state equations of the positive electrode
out(1) = x(2);
out(2) = (-1/p2.b2_p)*x(2) + (1/p2.b2_p)*u;


end