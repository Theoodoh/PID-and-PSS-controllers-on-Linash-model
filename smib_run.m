%smib_run
clear all 
system_base_mva = 100;
s_f=60; %system frequency in Hz
s_wb=2*pi*s_f;% base value radial frequency in rad/sec
s_ws=1; %pu value of synchronous speed

%busNO , voltage, angle, Pg, Qg, Pl, Ql, Gl, Bl, bus type
bus=[...
    1 1 0 7 1.85 0 0 0 0 3;
    2 1 0 0 0 0 0 0 0 1;];
 % from_bus to__bus R L C tap ratio
 line=[1 2 0.0025 0.0417 0.0 1.0 0.0];
 
 %machine data starts
 mac_con =[1 900 0.2 0.0025 1.8 0.3 0.25 8 0.03 1.7 0.55 0.25 0.4 0.05 6.5 0];
 %machine data ends 
 %excitation system data 
 s_Ka=200;%static excitation gain p.328
 s_Ta=0.02;%static excitation time constant padiar p.328
 %governor control system data 
 s_Tg=0.2;%kundur p 598
 s_Rgov=0.05;%kundur p 598
 %OBTAIN LOAD FLOW SOLUTION 
 [Y]= form_Ymatrix(bus,line);
 %calculation pre_fault power flow solution
 [bus_sol, line_flow]= power_flow(Y,bus, line);
 %synchronous machine initialisation
 Smachs=[1]; %buses with synchronous machine 
 Nbus = size(bus,1); %number of buses
 NSmachs=size(Smachs,1);%number of synchronous machine 
 
 %program to initialise the synchronous machine
 Synch_parameter_gen_base  %or_sys_base, depending on the base system we decide to work in
 generic_Sync_Init
 %calculates the vector of apparent power S injected by the generators for
 %each system bus
 PQ= bus_sol(:,4)+1i*bus_sol(:,5);
 %Calculates the complex voltage value for all buses
 vol= bus_sol(:,2).*exp(1i*bus_sol(:,3)*pi/180)
 %calculates the complex value of the current injected by the generators at
 %each system bus 
 Icalc= conj(PQ./vol);
 %PL and QL are the real and reactive power drawn by load at all system
 %buses
 PL= bus_sol(:,6);
 QL= bus_sol(:,7);
 %V is the voltage magnitude at all system buses
 V=bus_sol(:,2);
 %bus voltage infinite bus 
 Vinfvec= ones (Nbus,1);
  Vinf=Vinfvec.*(bus_sol(2,2)*exp(1i*bus_sol(2,3)*pi/180));
  %line impedance
  Zline= line(3)+1i*line(4);
 %Synch_parameter_gen_base.m
 
 