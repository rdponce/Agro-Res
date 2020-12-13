*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
$ontext
   Basin Integrated Model

   Name      :   load_baseData.gms
   Purpose   :   Base model data definition
   Author    :   R Ponce
   Date      :   03.09.14
   Since     :   January 2011
   CalledBy  :   run1_calPMP

   Notes     :   load gdx data + parameters definition

$offtext
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*                         SETS AND PARAMETERS                                  *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*~~~~~~~~  sets and parameters declaration   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
$include sets\sets_general.gms
$include basedata\pars.gms
$include basedata\Res_Demand.gms
;


*~~~~~~~~  original data (comming from data folder) ~~~~~~~~~~~~~~~~~~~~~~~~~~~*

execute_load "..\results\chile_db.gdx" p_cropData,p_supplyData,p_marketData,p_climChange;


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*                         DEFINE MODEL DATA                                    *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*   ---- crop area (ha) (only activities with gmar >0) commune level-----
x0(c,a,s)$(p_cropData(c,a,s,'gmar') gt 0)= p_cropData(c,a,s,'area');
x0(c,a,'tot')= x0(c,a,'dry')+ x0(c,a,'irr');

*   ---- farmland availability (ha) commune level
tland(c) = sum(a,X0(c,a,'tot'));
iland(c) = sum(a,X0(c,a,'irr'));

*   ---- crop data commune
yld(c,a,s) =  p_cropData(c,a,s,'yld');
lab(c,a,s) = p_cropData(c,a,s,'Labor');

*   ---- market data
selas(a) = p_supplyData(a,'selast');

*   ---- supply data
*---- Prices in mill CLP, Qtty in ton
ps0(a) = (1/1000000)*p_supplyData(a,'sPre');
qs0(a) = sum((c,s),yld(c,a,s)*x0(c,a,s));

*   ---- water data
*  agricultural water requirements commune
fir(c,a,'irr') = p_cropData(c,a,'irr','cir');

$call "gdxxrw.exe basedata\HD.xlsx o=basedata\HD.gdx se=2 index=indexDat!A3"

$gdxin basedata\HD.gdx
$load  p_hda
$gdxin

$gdxin basedata\HD.gdx
$load  p_hdr
$gdxin

$gdxin basedata\HD.gdx
$load  p_hdra
$gdxin

gir(c,a,'irr') = fir(c,a,'irr')/p_hda(c);

$ontext
*********** PARAMETERS VALUES FOR RESIDENTIAL DEAMAND- Lineal Form**************
const(c) = 3.530;
temp_par(c) = 0.04398 ;
room_par(c) = 0.1823;
inha_par(c) = 0.058;
price_par(c) = -0.001;
income_par(c) = 0.000003;


}$ontext ********** PARAMETERS VALUES FOR RESIDENTIAL DEAMAND- Log-Log - demanda residencial chile.docx**************
const(c) = 1.782;
temp_par(c) = 0.041 ;
room_par(c) = 0.445;
inha_par(c) = 1.4;
price_par(c) = -1.791;
income_par(c) = 1.718;

*******testing values******


*    VER UNIDADES PARS Y PASAR A LOG

*$ontext ******** Parametros flor
*A CONSUMO APLICAR LOG
const(c)=1.987  ;
*PRECIPITACIONES NO ESTAN, LAS BUSCO Y AGREGO DE FUENTES EXTERNAS?
*PP(c)=0.072*** :
temp_par(c) =0.027  ;
*A PRECIO APLICAR LOG
price_par(c)= -0.121 ;
*A INGRESO APLICAR LOG
*Ingreso
income_par(c)=0.137      ;
*NUMERO DE HABITANTES EN EL HOGAR SI, DE CIUDAD NO
*N° habitantes
inha_par(c)=0.085     ;
*NUMERO DE BANHOS NO DISPONIBLE, QUE HACEMOS
room_par(c)=-0.041   ;
*N° baños=-0.041***   ;

$offtext





householdsCh (c) = 1.13043*households(c);

RW0(c) = exp(const(c)+ temp_par(c)*temp(c)+room_par(c)*rooms(c)+inha_par(c)*inhab(c)+
               price_par(c)*log(RW_price0(c))+income_par(c)*log(income(c)));


RW0_agg(c) = RW0(c)*12*households(c);

RW_Alpha0(c) =  const(c)+ temp_par(c)*temp(c)+room_par(c)*rooms(c)+inha_par(c)*inhab(c) + income_par(c)*log(income(c))     ;

*RW_price0(c) = (RW0(c)-exp(RW_Alpha0(c)))/(price_par(c)) ;

RW_price_max0(c) = (-RW_Alpha0(c))/(price_par(c))      ;

cs0(c) = ([RW_price0(c)*RW0(c)]/[price_par(c)+1]*12*households(c))/10;


RW0_cc(c) = exp(const(c)+ temp_par(c)*temp_cc(c)+room_par(c)*rooms(c)+inha_par(c)*householdsCh(c)+
               price_par(c)*log(RW_price0(c))+income_par(c)*log(income(c)));


*RW_Alpha0_cc(c) =    const(c)+ temp_par(c)*temp_cc(c)+room_par(c)*rooms(c)+inha_par(c)*inhab(c) + income_par(c)*log(income(c))     ;

*RW_price_max0_cc(c) = (-RW_Alpha0_cc(c))/(price_par(c))      ;

*cs0_cc(c) = ((RW_price_max0_cc(c)- RW_price0(c))*RW0(c)/2)*((12*households(c))/10000);



* => water delivery

w0_a(c) = sum(a, gir(c,a,'irr')*x0(c,a,'irr'));
w0_r(c) = (RW0(c)*12*households(c))/p_hdr(c) ;
DW0(c) = W0_a(c) + W0_r(c);

*water restriction with spatial differentiation by commune

$call "gdxxrw.exe basedata\SWAT_Vergara_Comm.xls o=basedata\watsup_comm.gdx se=2 index=indexDat!A3"

$gdxin basedata\watsup_comm.gdx
$load  p_watsup_commQ50
$gdxin

DWCh(c) = DW0(c)* p_watsup_commQ50(c);

*   ---- production costs commune
*---- Costs in MM CLP
vcos(c,a,s)$x0(c,a,s) = (1/1000000)*p_cropData(c,a,s,'vcost');

sgm(c,a,s)$x0(c,a,s)= yld(c,a,s)*ps0(a) - vcos(c,a,s);

*   ---- climchange scenario commune

y0(c,a,s) = yld(c,a,s);
yCh(c,a,CCSce,s) = p_climChange(c,a,CCSce,s,'CCyld');
tp(a,'dry')    = 0.1;
tp(a,'irr')    = 0.05;
tp(a,s) = 0 ;


Parameters yields ;

yields(c,a,s,'baseline') = yld(c,a,s);
yields(c,a,s,'CC240')=  yCh(c,a,'A240',s);
yields(c,a,s,'CCB40')=  yCh(c,a,'B240',s);

option decimals=8;



Display RW0_agg, w0_a, w0_r, DW0, DWCh, cs0,RW_price0,RW0, RW_Alpha0;










