%% this m-file perfrmes small-signal analysis

smib_run
% x is an example for a Lead-Lag PSS parameters.
x = [0.00100000000000000,0.00100000000000000,1];

Kp = x(1);
Ki = x(2);
Kd = x(3);


%% Linearize Power System
% f11=linmod('smib_IO');
f11=linmod('smib_PID');

% dx/dt = A.x + B.u
% y = C.x + D.u

Asys = f11.a ;
Bsys = f11.b ;
Csys = f11.c ;
Dsys = f11.d ;

%% Calculate Eigenvalues
egs = eig(Asys)
Ns = length(egs);

Damp = -real(egs)./sqrt(real(egs).^2+imag(egs).^2)
freq = abs(imag(egs))/(2*pi)

%% calculae Participation Factors
[Vs,D_eig] = eig(Asys);
Ws=inv(Vs);
for i=1:Ns
    for k=1:Ns
        Pfact1(k,i)=abs(Vs(k,i))*abs(Ws(i,k));
    end
end

for i=1:Ns
     Pfact(i,:)=Pfact1(i,:)/sum(Pfact1(i,:));
end

for i=1:Ns
    [s_val s_idx] = sort(Pfact(:,i),'descend');
    mod_idx(i,:) = s_idx(1:4)';
    pf_fact(i,:) = s_val(1:4)';
end
mod_idx;
pf_fact;
