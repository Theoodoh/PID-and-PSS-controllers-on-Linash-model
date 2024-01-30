%single machine infinite bus data 
%power flow 
% bus_numb voltage angle Pg Qg Pl Ql G1 B1 Bus_type 
bus=[...
    1 1 0 7 1.85 0 0 0 0 3;
    2 1 0 0 0 0 0 0 0 1;];
 % from_bus to__bus R L C tap ratio
 line=[1 2 0.0025 0.0417 0 1 0];
 %obtain load flow solution 
 [Y]= form_Ymatrix(bus,line);
 %calculation pre_fault power flow solution
 [bus_sol, line_flow]= power_flow(Y,bus, line);