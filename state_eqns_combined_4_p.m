function [out] = state_eqns_combined_4_p(in)
persistent p4
t=in(1);

if t==0
    p4 = evalin('base','p4');
end

u = in(2);
x = in(3:6); %state vector

%state equations of the positive electrode
out(1) = x(2);
out(2) = x(3);
out(3) = x(4);
out(4) = (-1/p4.b4_p)*x(2) + (-p4.b2_p/p4.b4_p)*x(3) + (-p4.b3_p/p4.b4_p)*x(4) + (1/p4.b4_p)*u;

end