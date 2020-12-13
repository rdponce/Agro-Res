*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
$ontext
   Basin Agricultural Model

   Name      :   sets_general.gms
   Purpose   :   general sets and mappings
   Author    :   R Ponce
   Date      :   03.09.14
   Since     :   January 2011
   CalledBy  :

   Notes     :

$offtext
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
$onmulti

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  COMMON SETS AND MAPPINGS                                                    *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
set
   reg       'regions and regional aggregates'
   yrs       'years'                 /1995*2012/
   sys       'production system'     /dry,irr,tot/
   var       'variables'             /area,yld,prd,vcost,srev,gmar,cir,selast,spre,CCyld,CCcir,labor,watsup/

   comm               'communes'
   act                'activities'
   agg                'crop aggregates'
   sys                'production system'
   CCSce              'Climate Change Scenarios'
   map_agg            'mapping aggregates-activities'
   map_reg_comm       'mapping regions-prov-communes'
   map_comm_station   'mapping communes-stations'
   station            'hydrologic station'
  ;

*   ---- activity groups and families


*   ---- current activities
set
  map_cas   'mapping communes-activities-systems'

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*  SETS DEFINITION                                                             *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

$GDXIN ..\data\sets\sets.gdx
$LOAD reg act agg map_agg comm CCSce map_reg_comm station map_comm_station
$GDXIN

*   ---- subsets
set
*---Basin
r(reg)    'regions and regional aggregates'     /R_Biobio, Araucania/
c(comm)   'communes and regional aggregates' /curacautin, traiguen, los_sauces, angol, ercilla, collipulli, mulchen, renaico, negrete, nacimiento/


s(sys)    'production system'     /dry,irr/

crp(act)   'crop activities' /Oat,Common_Bean,Potato,Wheat,Rice,Maize,alfalfa,Sugar_beet/
frt(act)   'fruits activities' /Cherry,Plum,Peach,Apple,Orange,Walnut,Olive,Avocado,Pear,Grapes,Vineyard /
fed(act)   'feed activities' /alfalfa,Fallow_Land,Mngd_Grassland,Nat_Grassland/

a(act)     'activities to be modeled'     ;

a(act)= crp(act)+ frt(act)  ;

*   ---- sets including aggregates
set Rtot 'regions including totals'  /set.reg,Chile/


;


