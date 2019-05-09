% function [TDelay] = Delay_BT_UK( Lsd)
rounds=1;
N=20;
Nm=20;
Lsd=ones(20,20); % Uniform low demand matrix


% the random demand matrix between IP/WDM nodes%
% Lsd=[
% 
%  84	463	376	56	123	95	495	173	142	452	242	165	496	152	469	33	131	43	116	363
% 341	242	318	385	284	462	467	127	181	151	52	323	108	25	27	377	23	477	231	73
% 481	442	444	51	258	57	141	460	476	169	75	330	54	469	455	60	139	390	166	383
% 458	404	124	361	22	189	371	157	338	255	500	7	425	304	445	92	292	308	274	469
% 233	81	137	80	7	64	345	179	42	126	448	120	413	390	430	187	482	450	305	159
% 382	352	462	353	247	132	191	152	273	394	129	315	206	483	52	336	92	358	166	470
% 490	484	188	390	495	137	283	147	215	183	225	100	89	343	235	120	489	300	385	314
% 232	201	419	159	254	40	276	167	50	232	481	302	371	439	305	158	183	203	197	88
% 470	146	110	171	383	390	153	297	95	190	113	418	325	41	244	440	316	43	300	478
% 389	205	165	70	33	342	185	451	60	225	237	97	63	402	373	271	19	26	414	63
% 152	269	50	304	302	39	390	47	461	270	7	467	6	451	30	33	25	113	317	433
% 411	327	246	89	449	303	155	151	446	309	35	265	413	227	27	67	94	290	256	498
% 86	400	451	430	336	129	55	395	258	429	82	339	394	370	12	152	168	106	247	291
% 195	158	221	486	406	331	272	50	209	86	12	255	68	55	250	81	56	382	137	337
% 424	51	354	490	201	215	271	158	31	379	105	170	464	398	428	482	389	96	453	148
% 457	409	45	492	73	143	490	209	217	240	399	115	53	476	500	278	42	445	228	20
% 189	368	483	24	149	469	249	177	394	49	23	221	186	252	380	459	32	343	106	375
% 17	180	199	33	454	451	492	343	262	178	127	147	279	265	334	134	303	429	319	293
% 476	371	357	97	195	27	140	234	121	194	62	484	225	15	206	349	366	243	284	146
% 483	173	262	98	61	37	394	122	243	463	283	498	301	483	328	335	134	262	389	258
% ];




d=size(Lsd);

B=40; %wavelength bandwidth
Erp=0.0001; % Delay of router 
Et=0.00001; % Delay of transponders
Ee=0.00005; % DELAY of EDFA

W=32; % number of wavelengths in one fiber
S=80; % distance between two EDFAs
%%%%%%%%%%%% creating Que R from the demand matrix Lsd
%initialize the Rue R
for i = 1:d(1)*d(2)
        
        R(i).source=0;
        R(i).dest=0;
        R(i).demand=0;
end

index=0;
for i = 1:d(1)
    for j = 1:d(2)
        index=index+1;
        R(index).source=i;
        R(index).dest=j;
        R(index).demand=Lsd(i,j);
    end
end

%%%%%%%%%%%%% sorting the Que R from high demand to low demand
index = 1;
for x = 1:d(1)*d(2)
    max_R=R(index);
    for i = index:d(1)*d(2)
        if (R(i).demand>=max_R.demand)
            max_R=R(i);
            k=i;
        end;
    end
R(k)=R(index);
R(index)=max_R;
index=index+1;
end


%%%%%%%%%% routing the demands over the virtual link topology G
% creating G
for i = 1:d(1)
    for j = 1:d(2)
        G.VL(i,j) = 0; % =1 if there is a VL between i=j, 0 otherwise
        G.C(i,j) = 0; %C=Cij = number of wavelengths in the VL i-j
        G.D(i,j) = 0; % accumilated demand portions passing through VL i-j
        G.BW(i,j)=0; % available BW in the VL i-j
    end        
end
Lsd_ij(:,:,:,:)=0;
% this is needed for  graphing of G
G.VL=sparse(G.VL);
%G.C=sparse(G.C);
G.D=sparse(G.D);
G.BW=sparse(G.BW);

% demands routing on virtual link topology started
 for  i = 1:d(1)*d(2)
    if (R(i).demand ~= 0) % we only route valid demands > 0
        G.VL(R(i).source,R(i).dest) = 1; % creat virtual link between ends of demand
        [Route(R(i).source,R(i).dest).cost,Route(R(i).source,R(i).dest).path] = graphshortestpath(G.VL,R(i).source,R(i).dest); %get demand pairs from the R que and try to route them over G
       
       %updating the virtual topology
       Lsd_ij(:,:,:,:)=0;
       node=1;
       Path_size=size(Route(R(i).source,R(i).dest).path);
       while(node<Path_size(2))
       G.C(Route(R(i).source,R(i).dest).path(node),Route(R(i).source,R(i).dest).path(node+1))=(G.C(Route(R(i).source,R(i).dest).path(node),Route(R(i).source,R(i).dest).path(node+1)) +(R(i).demand/B)); %update number of wavelengths
       G.D(Route(R(i).source,R(i).dest).path(node),Route(R(i).source,R(i).dest).path(node+1))=G.D(Route(R(i).source,R(i).dest).path(node),Route(R(i).source,R(i).dest).path(node+1))+R(i).demand; %update the demands passing throut the VL i-j
       Lsd_ij(R(i).source,R(i).dest,Route(R(i).source,R(i).dest).path(node),Route(R(i).source,R(i).dest).path(node+1))=R(i).demand; %demand portion between IP/WDM nodes s,d that pass through the virtual link i-j
       G.BW(Route(R(i).source,R(i).dest).path(node),Route(R(i).source,R(i).dest).path(node+1))=(G.C(Route(R(i).source,R(i).dest).path(node),Route(R(i).source,R(i).dest).path(node+1)))*B - G.D(Route(R(i).source,R(i).dest).path(node),Route(R(i).source,R(i).dest).path(node+1)); % ceil,,,,,update the available BW in the virtual link i-j
       node=node+1;
       end
    end;
 end
 

G.C=(G.C); % ceil,,,,calculating number of wavelenghts on VL i-j



%Now route the virtual link topology on the physical link topology
Phy_G.L=[ % defining the physical topology
0	1	1	1	1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	1
1	0	1	1	1	1	1	1	1	1	1	1	1	0	0	0	0	0	0	0
1	1	0	1	1	1	1	1	0	0	1	1	0	1	1	0	0	0	0	1
1	1	1	0	1	1	1	1	0	0	0	0	0	0	0	1	1	0	0	0
1	1	1	1	0	1	1	1	0	0	0	0	0	0	1	1	1	1	0	0
1	1	1	1	1	0	1	1	0	0	0	0	0	0	0	0	1	1	1	0
1	1	1	1	1	1	0	1	0	0	0	0	0	0	1	0	1	0	1	1
1	1	1	1	1	1	1	0	0	0	0	1	1	1	0	0	0	1	1	1
1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0
1	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0
1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
1	1	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0
1	1	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0
1	0	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0
0	0	1	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0
0	0	0	1	1	1	1	0	0	0	0	0	0	0	0	1	0	0	0	0
0	0	0	0	1	1	0	1	0	0	0	0	0	0	0	0	0	0	1	0
0	0	0	0	0	1	1	1	0	0	0	0	0	0	0	0	0	1	0	0
1	0	1	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0
];
Phy_G.L=sparse(Phy_G.L); % needed for graphing
Phy_G.Dmn=[ %distance between IP/WDM nodes BT UK NETWORK
 0	72	245	369	351	355	350	155	344	350	234	53	61	100	0	0	0	0	0	137
72	0	237	325	316	331	315	191	355	360	163	109	56	0	0	0	0	0	0	0
245	237	0	109	89	90	85	113	0	0	368	279	0	132	85	0	0	0	0	133
369	325	109	0	8.5	7.5	13.1	221	0	0	0	0	0	0	0	72	42	0	0	0
351	316	89	8.5	0	2.6	7	204	0	0	0	0	0	0	133	53	40	192	0	0
355	331	90	7.5	2.6	0	5	188	0	0	0	0	0	0	0	0	42	192	245	0
350	315	85	13.1	7	5	0	200	0	0	0	0	0	0	135	0	38	0	242	206
155	191	113	221	204	188	200	0	0	0	0	173	139	67	0	0	0	145	175	28
344	355	0	0	0	0	0	0	0	74	0	0	0	0	0	0	0	0	0	0
350	360	0	0	0	0	0	0	74	0	0	0	0	0	0	0	0	0	0	0
234	163	368	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
53	109	279	0	0	0	0	173	0	0	0	0	0	0	0	0	0	0	0	0
61	56	0	0	0	0	0	139	0	0	0	0	0	0	0	0	0	0	0	0
100	0	132	0	0	0	0	67	0	0	0	0	0	0	0	0	0	0	0	0
0	0	85	0	133	0	135	0	0	0	0	0	0	0	0	0	0	0	0	0
0	0	0	72	53	0	0	0	0	0	0	0	0	0	0	0	41	0	0	0
0	0	0	42	40	42	38	0	0	0	0	0	0	0	0	41	0	0	0	0
0	0	0	0	192	192	0	145	0	0	0	0	0	0	0	0	0	0	71	0
0	0	0	0	0	245	242	175	0	0	0	0	0	0	0	0	0	71	0	0
137	0	133	0	0	0	206	28	0	0	0	0	0	0	0	0	0	0	0	0    ];
 
    
  % calculate prop. delay 
  for i = 1:d(1)
    for j = 1:d(2)
        propDelay(i,j)=Phy_G.Dmn(i,j)/299792.458;
        Phy_G.C(i,j) = 0; % number of wavelenghs in Physical Topology
        %Phy_G.D(i,j) = 0; 
        
    end        
  end
  
  
  %route the VL topology over the physical link topology
  index=0;
 for i = 1:d(1)
     for j = 1:d(2)
         %if(G.D(i,j)~=0)
             index=index+1;
  [Phy_Route(i,j).cost,Phy_Route(i,j).path]=graphshortestpath(Phy_G.L,i,j) ;

        % end;
     end
 end


    




%calculate number of wavelenghs between WDM node


Wij_mn(:,:,:,:)=0;
for i=1:d(1)
     for j=1:d(2)
         if(Phy_Route(i,j).cost~=0)
             path_size=size(Phy_Route(i,j).path);
             node=1;
             while(node<path_size(2))
                 Phy_G.C(Phy_Route(i,j).path(node),Phy_Route(i,j).path(node+1))= Phy_G.C(Phy_Route(i,j).path(node),Phy_Route(i,j).path(node+1)) + G.C(i,j);
                 Wij_mn(i,j,Phy_Route(i,j).path(node),Phy_Route(i,j).path(node+1))=G.C(i,j); %number of wavelenghs in the VL i-j that pass throught the physcial link m-n
                 node=node+1;
             end
         end
     end
 end


% calculate number of fibers between WDM nodes
for i=1:d(1)
    for j=1:d(2)
        %if(Phy_G.C(i,j)~=0)
        Phy_G.Fmn(i,j)=(Phy_G.C(i,j)/W); %ceil
      %  end;
    end
end




%calculate number of aggregation ports of each router >> Aggrp(i)
for i= 1:d(1)
  Aggrp(i)=0;
end
for i= 1:d(1)
    for j=1:d(2)
        Aggrp(i)=Aggrp(i)+Lsd(i,j);
    end
   Aggrp(i)=Aggrp(i)/B;
   
end

%calculate number of light ports for each router >>CT(i) 
for i= 1:d(1)
  CT(i)=0;
end
for i=1:d(1)
    for j=1:d(2)
        CT(i)=CT(i)+Phy_G.C(i,j);
        %CT(i)=CT(i)+G.C(i,j);%for bypass
    end
    aggD(i)=ceil((Aggrp(i)+CT(i))/2240);%switching capacity of single router is 2.24 Tbps
end

%calculate router delay

for i=1:d(1)
    
Router_Delay(i)=Erp*aggD(i);
end

%calculate switch delay
for i=1:d(1)
    for j=1:d(2)
        if (i~=j)
    Es(i,j)=0.06;end;
    end
end


%calculate transponders delay 
Trans_Delay=zeros(N,Nm);
for i=1:d(1)
    for j=1:d(2)
    Trans_Delay(i,j)=Et*(ceil(Phy_G.C(i,j)));
    end
end


%calculate number of EDFAs between each two IP/WDM nodes >> Phy_G.Amn
for i=1:d(1)
    for j=1:d(2)
Phy_G.Amn(i,j)=((Phy_G.Dmn(i,j)/S)-1)+2;
if (Phy_G.Amn(i,j)==1)  Phy_G.Amn(i,j)=0; end;
    end
end
%calculate EDFA delay>> EDFA_Delay
EDFA_Delay=zeros(N,Nm);
for i=1:d(1)
    for j=1:d(2)
        EDFA_Delay(i,j)=(Ee*Phy_G.Amn(i,j)*ceil(Phy_G.Fmn(i,j)));
    end
end
%%%%%% calculate delay =Router_Delay+Trans_Delay+EDFA_Delay+prop. delay
  for i=1:d(1)
    for j=1:d(2)
        if(i~=j)
        Delay(i,j)=EDFA_Delay(i,j)+Trans_Delay(i,j)+Es(i,j)+propDelay(i,j)+Router_Delay(i);end;
    end
  end  
TDelay=zeros(d(1),d(2));
 for i=1:d(1)
    for j=1:d(2)
        if(i~=j)
        path_size=size(Phy_Route(i,j).path);
             node=1;
             if (Lsd(i,j)>0)
             while(node<path_size(2))
                 % calculate total delay between node i and j
        TDelay(i,j)=TDelay(i,j)+Delay(Phy_Route(i,j).path(node),Phy_Route(i,j).path(node+1));
        
        node=node+1;
             end
             end
        end
    end
end       
% end

% 14/03/19
% Al Dabashi code below; need TDelay for OMNeT++ simulation.

% Need to print "CityName1.gate++ <--> TDelay(x,y) <--> CityName2.gate++;"
% for 63 connections (node connected directly to other node)

% Loop through Phy_G.L to find 1.
% If Phy_G.L(n1,n2) returns 1, means node n1 connected directly to n2
% find TDelay(n1,n2)
% Get n1 and n2's city names CityName1 & CityName2
% Display the following
% X = ['CityName1.gate++ <--> TDelay(n1,n2) <--> CityName2.gate++;\n'];
% Repeat for other node connections

cityName = [
    "Manchester",
    "Leeds",
    "MiltonKeynes",
    "Docklands",
    "SouthBank",
    "London",
    "LondonNorthWest",
    "Birmingham",
    "Glasgow",
    "ClydeValley",
    "Newcastle",
    "Preston",
    "Sheffield",
    "Derby",
    "Peterborough",
    "Guildford",
    "Slough",
    "Bristol",
    "Cardiff",
    "Wolverhampton",
    ];

% Symmetrical matrix, hence do not need to interate through whole matrix in
% the for loop below:

for n1 = 2:20
    for n2 = 1:n1-1
        if Phy_G.L(n1,n2) == 1;
            code = [cityName{n1},'.gate++ <--> { delay = ',num2str(TDelay(n1,n2)),'s; } <--> ', cityName{n2},'.gate++;'];
            disp(code)
        end
    end
end

