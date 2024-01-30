function J = pss_objf(x,FunIndex,Dim)

load('sys_IO','f11')
As = f11.a;
Bs = f11.b;
Cs = f11.c;
Ds = f11.d;


Kp = x(1);
Ki = x(2);
Kd = x(3);

b = [Kd Kp Ki];
a = [0 1 0];


[A,B,C,D]= tf2ss(b,a);

Af = (A);
Bf = (B);
Cf = (C);
Df = (D);

Asys_1 = As + Bs*Df*Cs;
Asys_2 = Bs*Cf;
Asys_3 = Bf*Cs;
Asys_4 = Af + Bf*Ds*Cf;
Asys = [Asys_1 Asys_2;
    Asys_3 Asys_4];

egs = eig(Asys);

[z_val z_idx]=sort(abs(egs),'descend');
egs_new=egs;
egs_new(z_idx(end-1:end))=[];

%% unstable modes
ss_idx = find(real(egs_new)>0);
uss = egs_new(ss_idx);

%% EM modes
% Damp=-real(egs)./sqrt(real(egs).^2+imag(egs).^2)
freq = abs(imag(egs_new))/(2*pi);
em_idx = find(freq>0 & freq<3);

objf = max(real(egs_new(em_idx)))+sum(egs_new(ss_idx));

if isempty(objf)
    objf = max(real(egs_new));
end
J = objf;