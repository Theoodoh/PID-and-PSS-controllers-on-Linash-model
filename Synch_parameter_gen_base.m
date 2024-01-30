%Synch_parameter_gen_base.m
 machine_numb=mac_con(:,1);
 machine_base_mva=mac_con(:,2);
 s_xls = mac_con(:,3); %Armature leakage reactance
 s_Rs = mac_con(:,4); %ARMATURE RESISTANCE
 % d_axis
 s_xd = mac_con(:,5);%d axis synchronous reactance 
 s_xdd = mac_con(:,6);%d axis transient reactance 
 s_xddd = mac_con(:,7);%d axis sub-transient reactance 
 s_Tdod = mac_con(:,8);%d axis open circuit transient TIME constant
 s_Tdodd= mac_con(:,9);%d axis open circuit sub_transient TIME constant
 % q_axis
 s_xq = mac_con(:,10);%q axis synchronous reactance 
 s_xqd = mac_con(:,11);%q axis transient reactance 
 s_xqdd =mac_con(:,12);%q axis sub-transient reactance 
 s_Tqod =mac_con(:,13);%q axis open circuit transient TIME constant
 s_Tqodd =mac_con(:,14);%q axis open circuit sub_transient TIME constant
 s_H = mac_con(:,15);%INERTIA CONSTANT
 s_D =mac_con(:,16); %Self damping
 s_Rgov =  s_Rgov;
 ExpandSmachs=zeros(Nbus,NSmachs);
 for counter=1:NSmachs;
 ExpandSmachs(Smachs(counter),counter)=1;
 end
 SelectSmachs=zeros(NSmachs,Nbus);
 for counter=1:NSmachs;
 SelectSmachs(counter,Smachs(counter))=1;
 end
 s_Pg= bus_sol(Smachs,4).*system_base_mva./machine_base_mva; %generator real power in machine base
 s_Qg= bus_sol(Smachs,5).*system_base_mva./machine_base_mva; %generator reaactive power in machine base
 