*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
$ontext
   Basin Agricultural Model

   Name      :   CoreModelBasin.gms
   Purpose   :   Core model definition
   Author    :   R Ponce
   Date      :   15.09.14
   Since     :   January 2011
   CalledBy  :   run2_baseline run3_sim

   Notes     :   This file includes
                 + definition of main model equations
                 + definition of core model
$offtext
$onmulti ;
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*                         CORE MODEL DEFINITION                                *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
variables
*---Commune-----
   TS         'total surplus (households + farmers)basline'
   Z           "total net income "
   Zc          "net income per Commune"

;


positive variables
*---Commune------
   TCS         "Total consumer surplus baseline"
   RW          'Residential water demand m3/yr per household'
   RW_cc       'Residential water demand for CC simulations m3/yr per household'
   RWP_MAX     Residential water maximum price"
   RW_ALPHA    "Constant terms of RW demand (constant, inhabitants, temperature, income, rooms. Linear form"
   RW_price    "Residential water price"
   PV          "Virtual residential water price for CC simulations"
   CS          "consumer surplus baseline MM $"
   X           "crop activity level (ha)"
   FW2         "water  constraint in each commune (th m3)"
   FW3         'residential water constraint in each commune (th m3)'
   FW4         'ag water constraint in each commune (th m3)'
   WNU2_agr    'Agr Water not used in each commune'
   WNU2_res    'Res Water not used in each commune'
   IL          "irrigated land"
   TC          "total variable cost"
   AC          "average variable cost"
   PS          "producer price"
   QS          "Total supply"
   TTlC        "total cost"
   LabDem      "Labor Demand"

;




equations
*---Commune------
   e_ts            "objective value function baseline"
   e_totIncome     "Total agricultural income"
   e_income        "agricultural income per commune"
   e_totCs         "total consumer surplus baseline"
   e_CS            "consumer surplus baseline MM$ year"
   e_CS_cc          "consumer surplus CC MM$ year"
   e_RW            "residential water demand (m3/year)"
   e_RW_cc         "residential water demand for CC simulations (m3/year)"
   e_RWAlpha       "constant part of residential water demand"
   e_PMAX          "maximum price of the RW demand eq"
   e_RWP           "Residential water price"
   e_PV            "Virtual Residential water price for CC simulations"
   e_cost_LP       "cost accounting LP"
   e_cost_NLP      "cost accounting NLP"
   e_tLND          "total land constraint"
   e_iLAND         "irrigable land constraint"
   e_RWUse         "residential water use in each commune"
   e_AWUse         "agricultural water use in each commune"
   e_TWUse         "Total water use in each commune"
   e_water2        "water constraint Curacautin"
   e_water3        "water constraint Traiguen"
   e_water4        "water constraint Los Sauces"
   e_water5        "water constraint Ercilla"
   e_water6        "water constraint Collipulli"
   e_water7        "water constraint Mulchen"
   e_water8        "water constraint Angol"
   e_water9        "water constraint Renaico"
   e_water10       "water constraint Negrete"
   e_water11       "water constraint Nacimiento"
   e_water22       "Total Water constraint in commune c"
   e_watNU2_agr    'Agriculture Water not used in Curacautin'
   e_watNU2_res    'Residential Water not used in Curacautin'
   e_watNU3_agr    'Agriculture Water not used in Traiguen'
   e_watNU3_res    'Residential Water not used in Traiguen'
   e_watNU4_agr    'Agriculture Water not used in Los Sauces'
   e_watNU4_res    'Residential Water not used in Los Sauces'
   e_watNU5_agr    'Agriculture Water not used in Ercilla'
   e_watNU5_res    'Residential Water not used in Ercilla'
   e_watNU6_agr    'Agriculture Water not used in Collipulli'
   e_watNU6_res    'Residential Water not used in Collipulli'
   e_watNU7_agr    'Agriculture Water not used in Mulchen'
   e_watNU7_res    'Residential Water not used in Mulchen'
   e_watNU8_agr    'Agriculture Water not used in Angol'
   e_watNU8_res    'Residential Water not used in Angol'
   e_watNU9_agr    'Agriculture Water not used in Renaico'
   e_watNU9_res    'Residential Water not used in Renaico'
   e_watNU10_agr   'Agriculture Water not used in Negrete'
   e_watNU10_res   'Residential Water not used in Negrete'
   e_watNU11_agr   'Agriculture Water not used in Nacimiento'
   e_watNU11_res   'Residential Water not used in Nacimiento'
   e_TCost         "total cost"
   e_QS            "total production"
   e_lab           "Labor demand (total Working days per year)"
   e_reswat        "variation of RW"

;
*------All values in million CLP------

*-------Commune level------
*Total surplus
e_TS..          sum(c,Zc(c)) + sum(c,CS(c)) =e= TS ;

*Total consumer surplus
e_totCs..       sum(c,cs(c)) =e= TCS  ;

*Total agriculture income
e_totIncome..   sum(c,Zc(c)) =e= Z ;

*Agricultural Income by commune
e_income(c)..   (sum(map_cas(c,a,s), yld(c,a,s)*ps(a)*X(c,a,s))
                - sum(map_cas(c,a,s), AC(c,a,s)*X(c,a,s)))
                =e= Zc(c);

*CONSUMER'S SURPLUS

*e_CS(c)..           CS(c) =e=  [[(RWP_MAX(c)-RW_price(c))*RW(c)/2]-[(PV(c)-RW_price(c))*(RW(c)-RW_cc(c))/2]]*[(12*households(c))/10000];
e_CS(c)..           CS(c) =e=  [[RW_price(c)*RW(c)/(price_par(c)+1)]-[(PV(c)-RW_price(c))*(RW(c)-RW_cc(c))/2]]*[(12*households(c))/10];

*CAMBIAR PV, RW, RW_CC, RW_ALPHA, RW_PRICE

*Residential Water demand
*e_RW(c)..           RW(c) =e= RW_ALPHA(c) + price_par(c)*RW_price(c)     ;
e_RW(c)..            RW(c) =e= exp(RW_ALPHA(c) + price_par(c)*log(RW_price(c)))     ;

*Residential Water demand for CC Simulations
e_RW_cc(c)..         RW_cc(c) =e= exp(RW_ALPHA(c) + price_par(c)*log(PV(c)));

*Constant terms of RW demand equation
*e_RWAlpha(c)..      RW_ALPHA(c) =e=  const(c)+ temp_par(c)*temp(c)+room_par(c)*rooms(c)+inha_par(c)*inhab(c) + income_par(c)*income(c);
e_RWAlpha(c)..      RW_ALPHA(c) =e=  const(c)+ temp_par(c)*temp(c)+room_par(c)*rooms(c)+inha_par(c)*inhab(c) + income_par(c)*log(income(c));


* maximun price of the RW demand equation
e_PMAX(c)..          RWP_MAX(c) =e= (-RW_ALPHA(c)/(price_par(c)))      ;

*Residential water price
*e_RWP(c)..          RW_price(c) =e= (RW(c)-RW_Alpha(c))/(price_par(c)) ;
e_RWP(c)..          RW_price(c) =e= exp[(log(RW(c))-RW_Alpha(c))/price_par(c)];;


* Virtual Residential Water Price for CC Simulations
*e_PV(c)..          PV(c) =e= (RW_cc(c)-RW_Alpha(c))/(price_par(c)) ;
e_PV(c)..          PV(c) =e= exp[(log(RW_cc(c))-RW_Alpha(c))/price_par(c)];

e_cost_LP(c,a,s)..  vcos(c,a,s)   =e= AC(c,a,s);

e_cost_NLP(c,a,s).. alpha(c,a,s)*X(c,a,s)**beta(c,a,s)     =e= AC(c,a,s);

e_tLND(c)..  sum((a,s)$map_cas(c,a,s), X(c,a,s)) =L= tland(c);
e_iLAND(c)..  sum(a$map_cas(c,a,'irr'), X(c,a,'irr')) =L= IL(c);

*Water restriction by commune including externalities in water consumption, according to the following est-to-west order:
*Curacautin, Traiguen, Los_Sauces, Angol(+Collipulli, +Ercilla), Reanaico(+Collipulli, +Mulchen), Negrete, Nacimiento.
*It assumes that 50% of residual water from Collipulli goes to Angol, and the other 50% to Renaico.

e_RWUse(c)..    RW_CC(c)*12*households(c) =e= FW3(c);

e_AWUse(c)..    sum(a$map_cas(c,a,'irr'), fir(c,a,'irr')*X(c,a,'irr'))  =e= FW4(c);

e_TWUse(c)..    FW4(c) + FW3(c)   =e= FW2(c)   ;

e_water2('Curacautin')..  FW2('Curacautin')  =L= W0_a('Curacautin')*p_hda('Curacautin')+ W0_r('Curacautin')*p_hdr('Curacautin');
e_water3('Traiguen')..  FW2('Traiguen') =L= W0_a('Traiguen')*p_hda('Traiguen')+ W0_r('Traiguen')*p_hdr('Traiguen')+ WNU2_agr('Curacautin')*p_hda('Traiguen') + WNU2_res('Curacautin')*p_hdr('Traiguen');
e_water4('Los_Sauces')..  FW2('Los_Sauces') =L= W0_a('Los_Sauces')*p_hda('Los_Sauces')+ W0_r('Los_Sauces')*p_hdr('Los_Sauces')+ WNU2_agr('Traiguen')* p_hda('Los_Sauces') + WNU2_res('Traiguen')* p_hdr('Los_Sauces');
e_water5('Ercilla')..  FW2('Ercilla') =L= W0_a('Ercilla')*p_hda('Ercilla')+ W0_r('Ercilla')*p_hdr('Ercilla') ;
e_water6('Collipulli')..  FW2('Collipulli') =L= W0_a('Collipulli')*p_hda('Collipulli')+ W0_r('Collipulli')*p_hdr('Collipulli') ;
e_water7('Mulchen')..  FW2('Mulchen') =L= W0_a('Mulchen')*p_hda('Mulchen')+ W0_r('Mulchen')*p_hdr('Mulchen') ;
e_water8('Angol')..  FW2('Angol') =L= W0_a('Angol')*p_hda('Angol')+ W0_r('Angol')*p_hdr('Angol') + (WNU2_agr('Los_Sauces')+ WNU2_agr('Ercilla')+ 0.5*WNU2_agr('Collipulli'))*p_hda('Angol')
                                                                                                 + (WNU2_res('Los_Sauces')+ WNU2_res('Ercilla')+ 0.5*WNU2_res('Collipulli'))*p_hdr('Angol');

e_water9('Renaico')..  FW2('Renaico') =L= W0_a('Renaico')*p_hda('Renaico')+ W0_r('Renaico')*p_hdr('Renaico') + (0.5*WNU2_agr('Collipulli')+WNU2_agr('Mulchen')+WNU2_agr('Angol'))*p_hda('Renaico')
                                                                                                             + (0.5*WNU2_res('Collipulli')+WNU2_res('Mulchen')+WNU2_res('Angol'))*p_hdr('Renaico');

e_water10('Negrete')..  FW2('Negrete') =L= W0_a('Negrete')*p_hda('Negrete')+ W0_r('Negrete')*p_hdr('Negrete');

e_water11('Nacimiento')..  FW2('Nacimiento') =L= W0_a('Nacimiento')*p_hda('Nacimiento')+ W0_r('Nacimiento')*p_hdr('Nacimiento');


e_watNU2_agr('Curacautin')..      WNU2_agr('Curacautin')$(p_hda('Curacautin') gt 0) =E= W0_a('Curacautin') - (FW4('Curacautin')/p_hda('Curacautin'));
e_watNU2_res('Curacautin')..      WNU2_res('Curacautin')$(p_hdr('Curacautin') gt 0) =E= W0_r('Curacautin') - (FW3('Curacautin')/p_hdr('Curacautin'));

e_watNU3_agr('Traiguen')..      WNU2_agr('Traiguen')$(p_hda('Traiguen') gt 0) =E= W0_a('Traiguen') - (FW4('Traiguen')/p_hda('Traiguen')) + WNU2_agr('Curacautin') + WNU2_res('Curacautin');
e_watNU3_res('Traiguen')..      WNU2_res('Traiguen')$(p_hdr('Traiguen') gt 0) =E= W0_r('Traiguen') - (FW3('Traiguen')/p_hdr('Traiguen')) + WNU2_res('Curacautin') + WNU2_agr('Curacautin');

e_watNU4_agr('Los_Sauces')..      WNU2_agr('Los_Sauces')$(p_hda('Los_Sauces') gt 0) =E= W0_a('Los_Sauces') - (FW4('Los_Sauces')/p_hda('Los_Sauces'))+ WNU2_agr('Traiguen') + WNU2_res('Traiguen');
e_watNU4_res('Los_Sauces')..      WNU2_res('Los_Sauces')$(p_hdr('Los_Sauces') gt 0) =E= W0_r('Los_Sauces') - (FW3('Los_Sauces')/p_hdr('Los_Sauces'))+ WNU2_res('Traiguen') + WNU2_agr('Traiguen');

e_watNU5_agr('Ercilla')..      WNU2_agr('Ercilla')$(p_hda('Ercilla') gt 0) =E= W0_a('Ercilla') - (FW4('Ercilla')/p_hda('Ercilla'));
e_watNU5_res('Ercilla')..      WNU2_res('Ercilla')$(p_hdr('Ercilla') gt 0) =E= W0_r('Ercilla') - (FW3('Ercilla')/p_hdr('Ercilla'));

e_watNU6_agr('Collipulli')..      WNU2_agr('Collipulli')$(p_hda('Collipulli') gt 0) =E= W0_a('Collipulli') - (FW4('Collipulli')/p_hda('Collipulli'));
e_watNU6_res('Collipulli')..      WNU2_res('Collipulli')$(p_hdr('Collipulli') gt 0) =E= W0_r('Collipulli') - (FW3('Collipulli')/p_hdr('Collipulli'));

e_watNU7_agr('Mulchen')..      WNU2_agr('Mulchen')$(p_hda('Mulchen') gt 0) =E= W0_a('Mulchen') - (FW4('Mulchen')/p_hda('Mulchen'));
e_watNU7_res('Mulchen')..      WNU2_res('Mulchen')$(p_hdr('Mulchen') gt 0) =E= W0_r('Mulchen') - (FW3('Mulchen')/p_hdr('Mulchen'));

e_watNU8_agr('Angol')..      WNU2_agr('Angol')$(p_hda('Angol') gt 0) =E= W0_a('Angol') - (FW4('Angol')/p_hda('Angol'))+ WNU2_agr('Ercilla')+ WNU2_agr('Los_Sauces')+ 0.5*WNU2_agr('Collipulli') + WNU2_res('Ercilla')+ WNU2_res('Los_Sauces')+ 0.5*WNU2_res('Collipulli');
e_watNU8_res('Angol')..      WNU2_res('Angol')$(p_hdr('Angol') gt 0) =E= W0_r('Angol') - (FW3('Angol')/p_hdr('Angol'))+ WNU2_res('Ercilla')+ WNU2_res('Los_Sauces')+ 0.5*WNU2_res('Collipulli') + WNU2_agr('Ercilla')+ WNU2_agr('Los_Sauces')+ 0.5*WNU2_agr('Collipulli');

e_watNU9_agr('Renaico')..      WNU2_agr('Renaico')$(p_hda('Renaico') gt 0) =E= W0_a('Renaico') - (FW4('Renaico')/p_hda('Renaico'))+ 0.5*WNU2_agr('Collipulli')+ WNU2_agr('Mulchen')+ WNU2_agr('Angol')+ 0.5*WNU2_res('Collipulli')+ WNU2_res('Mulchen')+ WNU2_res('Angol');
e_watNU9_res('Renaico')..      WNU2_res('Renaico')$(p_hdr('Renaico') gt 0) =E= W0_r('Renaico') - (FW3('Renaico')/p_hdr('Renaico'))+ 0.5*WNU2_res('Collipulli')+ WNU2_res('Mulchen')+ WNU2_res('Angol')+ 0.5*WNU2_agr('Collipulli')+ WNU2_agr('Mulchen')+ WNU2_agr('Angol');

e_watNU10_agr('Negrete')..      WNU2_agr('Negrete')$(p_hda('Negrete') gt 0) =E= W0_a('Negrete') - (FW4('Negrete')/p_hda('Negrete'))+ WNU2_agr('Renaico')+ WNU2_res('Renaico');
e_watNU10_res('Negrete')..      WNU2_res('Negrete')$(p_hdr('Negrete') gt 0) =E= W0_r('Negrete') - (FW3('Negrete')/p_hdr('Negrete'))+ WNU2_res('Renaico')+ WNU2_agr('Renaico');

e_watNU11_agr('Nacimiento')..      WNU2_agr('Nacimiento')$(p_hda('Nacimiento') gt 0) =E= W0_a('Nacimiento') - (FW4('Nacimiento')/p_hda('Nacimiento'))+ WNU2_agr('Negrete')+ WNU2_res('Negrete');
e_watNU11_res('Nacimiento')..      WNU2_res('Nacimiento')$(p_hdr('Nacimiento') gt 0) =E= W0_r('Nacimiento') - (FW3('Nacimiento')/p_hdr('Nacimiento'))+ WNU2_res('Negrete')+ WNU2_agr('Negrete');

e_lab(c,a,s)..     LabDem(c,a,s) =e= X(c,a,s)*lab(c,a,s);

e_TCost..       sum((c,a,s),AC(c,a,s)*X(c,a,s)) =e= TTlC;
e_QS(a)..       QS(a)=l= sum((c,s),yld(c,a,s)*X(c,a,s))  ;

IL.up(c) = 1.25*iland(c);


*-----Baseline Model------
model CoreModel core equations /
   e_totIncome
   e_income
   e_tLND
   e_iLAND
   e_RWUse
   e_AWUse
   e_TWUSE

   e_water2
   e_water3
   e_water4
   e_water5
   e_water6
   e_water7
   e_water8
   e_water9
   e_water10
   e_water11

   e_watNU2_agr
   e_watNU2_res

   e_watNU3_agr
   e_watNU3_res

   e_watNU4_agr
   e_watNU4_res

   e_watNU5_agr
   e_watNU5_res

   e_watNU6_agr
   e_watNU6_res

   e_watNU7_agr
   e_watNU7_res

   e_watNU8_agr
   e_watNU8_res

   e_watNU9_agr
   e_watNU9_res

   e_watNU10_agr
   e_watNU10_res

   e_watNU11_agr
   e_watNU11_res

   e_lab
/;


