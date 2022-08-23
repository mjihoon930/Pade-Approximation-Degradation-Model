clear all
close all
clc

% Maps & Parameters
% t = [0 10 7000];
% u = [-1 -1 -1];

%t = [0 100 200 300 310 320 330 340 350 360 370 380 390 400 500 600 700 800 900 910 920 930 940 950 960 970 980 990 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000];
%u = [1 -3 5 -2 3 2 -1 0 2 3 4 2 1 5 1 -1 3 -2 2 -4 -3 5 2 -1 -3 2 1 -4 2 1 2 5 -4 -3 1 2 -3 2 3];

file_name = 'UDDS_current_profile_8340.mat'; 
test_data = load(file_name);
   
t = test_data.time;
u = test_data.UDDS_current_profile;

%%Parameters
%Negative
n.L_n = 3.4*10^(-3);
n.R_n = 3.5*10^(-4);
n.e_n = 0.55;
n.c_max_n = 31.07*10^(-3);
n.theta_0n = 0;
n.theta_100n = 0.8;
n.A_n = 1818;
n.D_n = 5.29*10^-11;
n.R_film_n = 0.001;

%Positive
p.L_p = 7.0*10^(-3);
p.R_p = 3.65*10^(-6);
p.e_p = 0.41;
p.c_max_p = 22.806*10^(-3);
p.theta_0p = 0.76;
p.theta_100p = 0.03;
p.A_p = 1771;
p.D_p = 1.18*10^-14;
p.R_film_p = 0;

c.F = 96487;
c.T_ref = 298.15;
c.T_inf = 298.15;
c.R_c = 0;
c.R_u = 8.314;
c.c_e = 1.2*10^(-3);
c.k_ref_p = 1.0614*10^(-4);
c.k_ref_n = 0.079;
c.E_a_p = 25*10^(3);
c.E_a_n = 40*10^(3);

d.K_p = 0.0575;
d.R_sei = 0.001;
d.M_p = 0.162;
d.rho_p = 1690*10^(-6);
d.i_o_s = 3.9*10^-12; 
d.U_ref_s = 0.4;

%%Parameters
a_p = 3*p.e_p/p.R_p;
a_n = 3*n.e_n/n.R_n;
m_p = -1/(p.A_p*p.L_p*a_p*p.D_p*c.F);
m_n = 1/(n.A_n*n.L_n*a_n*n.D_n*c.F);

n_Li = p.e_p*p.A_p*p.L_p*p.theta_0p*p.c_max_p + n.e_n*n.A_n*n.L_n*n.theta_0n*n.c_max_n;

Q_nom =c.F*p.e_p*p.A_p*p.L_p*(p.theta_0p-p.theta_100p)*p.c_max_p;
x1_initial = 0.9*Q_nom;

C_avg_p = (-1/(c.F*p.e_p*p.A_p*p.L_p))*x1_initial + p.theta_0p*p.c_max_p;
C_avg_n = (1/(n.e_n*n.A_n*n.L_n))*(n_Li-(p.e_p*p.A_p*p.L_p*C_avg_p));


d.alpha = -2.54198414948465;%boosted degradation alpha =  %%%-0.000232317216256834;
d.beta = 0.0181795099723194;%boosted degradation beta =  %%%1.67493939477145e-06;
d.J_bar = -0.0511572054718753;%boosted degradation J_bar =  %%%-4.15003019957989e-06;
d.c_bar = 0.015535;
d.u_bar = 0;

% 1st-order
p2.a0_n = n.D_n*a_n*c.F/d.alpha;
p2.a1_n = n.R_n^2*a_n*c.F/(15*d.alpha);
p2.b2_n = -n.R_n*(5*n.D_n*c.F*a_n - n.R_n*d.alpha)/(15*n.D_n*d.alpha);

% 2nd-order
p2.a0_n = n.D_n*a_n*c.F/d.alpha;
p2.a1_n = c.F*n.R_n^2*a_n/(9*d.alpha);
p2.a2_n = c.F*n.R_n^4*a_n/(945*n.D_n*d.alpha);
p2.b2_n = -n.R_n*(3*n.D_n*c.F*a_n - n.R_n*d.alpha)/(9*n.D_n*d.alpha);
p2.b3_n = -n.R_n^3*(14*n.D_n*c.F*a_n - n.R_n*d.alpha)/(945*d.alpha*n.D_n^2);
p2.a0_p = -3*p.D_p*m_p/p.R_p;
p2.a1_p = -2*m_p*p.R_p/7;
p2.b2_p = p.R_p^2/(35*p.D_p);

Pade_2_n_D = [p2.a0_n, p2.a1_n, p2.a2_n, p2.b2_n, p2.b3_n];
Pade_2_p_D = [p2.a0_p, p2.a1_p, p2.b2_p];

p2.x1p_initial = C_avg_p/p2.a0_p;

% 3rd-order

p3.a0_n = n.D_n*a_n*c.F/d.alpha;
p3.a1_n = (5*a_n*c.F*n.R_n^2)/(39*d.alpha);
p3.a2_n = (2*c.F*n.R_n^4*a_n)/(715*n.D_n*d.alpha);
p3.a3_n = c.F*a_n*n.R_n^6/(135135*n.D_n^2*d.alpha);
p3.b2_n = -n.R_n*(13*n.D_n*c.F*a_n - 5*n.R_n*d.alpha)/(39*n.D_n*d.alpha);
p3.b3_n = -(2*n.R_n^3*(22*n.D_n*c.F*a_n - 3*n.R_n*d.alpha))/(2145*n.D_n^2*d.alpha);
p3.b4_n = -n.R_n^5*(27*n.D_n*c.F*a_n - n.R_n*d.alpha)/(135135*d.alpha*n.D_n^3);

p3.a0_p = -3*p.D_p*m_p/p.R_p;
p3.a1_p = -4*m_p*p.R_p/11;
p3.a2_p = -m_p*p.R_p^3/(165*p.D_p);
p3.b2_p = 3*p.R_p^2/(55*p.D_p);
p3.b3_p = p.R_p^4/(3465*p.D_p^2);

Pade_3_n_D = [p3.a0_n, p3.a1_n, p3.a2_n, p3.a3_n, p3.b2_n, p3.b3_n, p3.b4_n];
Pade_3_p_D = [p3.a0_p, p3.a1_p, p3.a2_p, p3.b2_p, p3.b3_p];

p3.x1p_initial = C_avg_p/p3.a0_p;

% 4th-order

p4.a0_n = n.D_n*a_n*c.F/d.alpha;
p4.a1_n = (7*c.F*n.R_n^2*a_n)/(51*d.alpha); 
p4.a2_n = c.F*a_n*n.R_n^4/(255*n.D_n*d.alpha); 
p4.a3_n = (2*c.F*a_n*n.R_n^6)/(69615*n.D_n^2*d.alpha); 
p4.a4_n = c.F*a_n*n.R_n^8/(34459425*d.alpha*n.D_n^3); 
p4.b2_n = -n.R_n*(17*n.D_n*c.F*a_n - 7*n.R_n*d.alpha)/(51*n.D_n*d.alpha); 
p4.b3_n = -n.R_n^3*(6*n.D_n*c.F*a_n - n.R_n*d.alpha)/(255*n.D_n^2*d.alpha); 
p4.b4_n = -(2*n.R_n^5*(13*n.D_n*c.F*a_n - n.R_n*d.alpha))/(69615*d.alpha*n.D_n^3); 
p4.b5_n = -n.R_n^7*(44*n.D_n*c.F*a_n - n.R_n*d.alpha)/(34459425*d.alpha*n.D_n^4);

p4.a0_p = -3*p.D_p*m_p/p.R_p;
p4.a1_p = -2*m_p*p.R_p/5;
p4.a2_p = -2*m_p*p.R_p^3/(195*p.D_p);
p4.a3_p = -4*m_p*p.R_p^5/(75075*p.D_p^2);
p4.b2_p = p.R_p^2/(15*p.D_p);
p4.b3_p = 2*p.R_p^4/(2275*p.D_p^2);
p4.b4_p = p.R_p^6/(675675*p.D_p^3);

Pade_4_n_D = [p4.a0_n, p4.a1_n, p4.a2_n, p4.a3_n, p4.a4_n, p4.b2_n, p4.b3_n, p4.b4_n, p4.b5_n];
Pade_4_p_D = [p4.a0_p, p4.a1_p, p4.a2_p, p4.a3_p, p4.b2_p, p4.b3_p, p4.b4_p];

p4.x1p_initial = C_avg_p/p4.a0_p;

% 5th-order
p5.a0_n = n.D_n*a_n*c.F/d.alpha;
p5.a1_n = c.F*n.R_n^2*a_n/(7*d.alpha);
p5.a2_n = (4*a_n*c.F*n.R_n^4)/(855*n.D_n*d.alpha);
p5.a3_n = a_n*c.F*n.R_n^6/(20349*d.alpha*n.D_n^2);
p5.a4_n = a_n*c.F*n.R_n^8/(6409935*d.alpha*n.D_n^3);
p5.a5_n = a_n*c.F*n.R_n^10/(13749310575*d.alpha*n.D_n^4);
p5.b2_n = -n.R_n*(7*n.D_n*c.F*a_n - 3*n.R_n*d.alpha)/(21*n.D_n*d.alpha);
p5.b3_n = -(4*n.R_n^3*(38*n.D_n*c.F*a_n - 7*n.R_n*d.alpha))/(5985*d.alpha*n.D_n^2); 
p5.b4_n = -n.R_n^5*(51*n.D_n*c.F*a_n - 5*n.R_n*d.alpha)/(101745*d.alpha*n.D_n^3);
p5.b5_n = -n.R_n^7*(20*n.D_n*c.F*a_n - n.R_n*d.alpha)/(6409935*d.alpha*n.D_n^4);
p5.b6_n = -n.R_n^9*(65*n.D_n*c.F*a_n - n.R_n*d.alpha)/(13749310575*d.alpha*n.D_n^5);

p5.a0_p = 2.03906344360226e-06;
p5.a1_p = 0.00032310939907713533898354730402897;
p5.a2_p = 0.011265843015144487050013802285477;
p5.a3_p = 0.11536891776786833667184616795641;
p5.a4_p = 0.27832145570447124880487157428246;
p5.b2_p = 83.191347011708210573658686422189;
p5.b3_p = 1691.3291562570245888893685836012;
p5.b4_p = 9429.8944065395473260683258339251;
p5.b5_p = 7445.1682015949283210312046573571;

Pade_5_n_D = [p5.a0_n, p5.a1_n, p5.a2_n, p5.a3_n, p5.a4_n, p5.a5_n, p5.b2_n, p5.b3_n, p5.b4_n, p5.b5_n, p5.b6_n];
Pade_5_p_D = [p5.a0_p, p5.a1_p, p5.a2_p, p5.a3_p, p5.a4_p, p5.b2_p, p5.b3_p, p5.b4_p, p5.b5_p];

p5.x1p_initial = C_avg_p/p5.a0_p;

% 6th-order
p6.a0_n = n.D_n*a_n*c.F/d.alpha; 
p6.a1_n = (11*a_n*c.F*n.R_n^2)/(75*d.alpha); 
p6.a2_n = (3*c.F*a_n*n.R_n^4)/(575*n.D_n*d.alpha); 
p6.a3_n = (4*c.F*a_n*n.R_n^6)/(60375*n.D_n^2*d.alpha); 
p6.a4_n = (2*c.F*a_n*n.R_n^8)/(6194475*n.D_n^3*d.alpha); 
p6.a5_n = c.F*n.R_n^10*a_n/(1930611375*n.D_n^4*d.alpha); 
p6.a6_n = c.F*a_n*n.R_n^12/(7905853580625*d.alpha*n.D_n^5); 
p6.b2_n = -n.R_n*(25*n.D_n*c.F*a_n - 11*n.R_n*d.alpha)/(75*n.D_n*d.alpha); 
p6.b3_n = -n.R_n^3*(46*n.D_n*c.F*a_n - 9*n.R_n*d.alpha)/(1725*n.D_n^2*d.alpha); 
p6.b4_n = -(4*n.R_n^5*(9*n.D_n*c.F*a_n - n.R_n*d.alpha))/(60375*n.D_n^3*d.alpha); 
p6.b5_n = -(2*n.R_n^7*(76*n.D_n*c.F*a_n - 5*n.R_n*d.alpha))/(30972375*n.D_n^4*d.alpha); 
p6.b6_n = -n.R_n^9*(85*n.D_n*c.F*a_n - 3*n.R_n*d.alpha)/(5791834125*d.alpha*n.D_n^5); 
p6.b7_n = -n.R_n^11*(90*n.D_n*c.F*a_n - n.R_n*d.alpha)/(7905853580625*d.alpha*n.D_n^6);

p6.a0_p = 2.03906344360226e-06;
p6.a1_p = 0.0002045936995;
p6.a2_p = 0.001935746566;
p6.a3_p = 0.02523061171;
p6.a4_p = 0.06390087646;
p6.a5_p = 0.3125391806;
p6.b2_p = 25.06873195;
p6.b3_p = 276.4473126;
p6.b4_p = 1693.587922;
p6.b5_p = 5838.712016;
p6.b6_p = 9211.326455;

Pade_6_n_D = [p6.a0_n, p6.a1_n, p6.a2_n, p6.a3_n, p6.a4_n, p6.a5_n, p6.a6_n, p6.b2_n, p6.b3_n, p6.b4_n, p6.b5_n, p6.b6_n, p6.b7_n];
Pade_6_p_D = [p6.a0_p, p6.a1_p, p6.a2_p, p6.a3_p, p6.a4_p, p6.a5_p, p6.b2_p, p6.b3_p, p6.b4_p, p6.b5_p, p6.b6_p];

p6.x1p_initial = C_avg_p/p6.a0_p;

%initial state
x1n_initial = 0;
x2p_initial = 0;
x2n_initial = 0;
x3p_initial = 0;
x3n_initial = 0;
x4p_initial = 0;
x4n_initial = 0;
x5p_initial = 0;
x5n_initial = 0;
x6p_initial = 0;
x6n_initial = 0;

%Run model
t_final = 8340;

sim('Combined_Pade_Model_D.slx',t_final)

save Pade_udds.mat