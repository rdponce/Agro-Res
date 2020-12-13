*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
$ontext
   Basin Integrated Model

   Name      :   Res_Demand.gms
   Purpose   :   Residential demand model
   Author    :   R Ponce
   Date      :   08.04.15
   Since     :   March 2015
   CalledBy  :   load_baseData.gms


$offtext
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*                         RESIDENTIAL DEMAND MODULE                            *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*MODEL
*RW = C + T*B_t + R*B_r + In*B_In + P*B_p + I * B_I



Parameters
* Regression parameters
const    'constant value water equation'
temp_par 'temperature parameter'
room_par   'room number parameter'
inha_par   'inhabitant number parameter'
price_par   'price parameter'
income_par  'income parameter'

*sample mean values
income      'income mean value (* 100.000)'
RW_price0     'Marginal price value (*100)'

Water_cons   'water consumption value'
Inhab         'inhabitants mean value'
rooms        'rooms number mean value'
temp          'mean value temperature'
temp_cc       'mean value temperature cc'
households    'number of household by commune (*1000)'
householdsCh  'increase in households by commune %)'


*aggregated parameters

comagg        'aggregate from household to commune in residential water demand'
p_hdr          'delivery efficiency in drinking water network'
w0_r         "water delivery (2007) in Mm3 commune level for the residential sector"

*cosumer surplus parameters
RW0            'household water use commune m3/yr'
RW0_cc            'household water use commune m3/yr with cc'
RW0_agg        'residential water use commune Mm3/yr'
RW_price_max0  'residential water maximun price'
RW_price_max0_cc 'residential water maximun price with cc'
RW_Alpha0       'Alpha evaulated in the mean values'
cs0             'consumer surplus  (MM$)'
cs0_cc           'consumer surplus  (MM$) with cc'
RW_Alpha0_cc    'Alpha evaulated in the mean values with cc'



$call "gdxxrw.exe basedata\Demand_Data.xlsx o=basedata\demand_data.gdx se=2 index=indexDat!A3"

$gdxin basedata\demand_data.gdx
$load  const
$gdxin

$gdxin basedata\demand_data.gdx
$load  temp_par
$gdxin

$gdxin basedata\demand_data.gdx
$load  room_par
$gdxin

$gdxin basedata\demand_data.gdx
$load  inha_par
$gdxin

$gdxin basedata\demand_data.gdx
$load  price_par
$gdxin

$gdxin basedata\demand_data.gdx
$load  income_par
$gdxin

$gdxin basedata\demand_data.gdx
$load  income
$gdxin

$gdxin basedata\demand_data.gdx
$load  RW_price0
$gdxin

$gdxin basedata\demand_data.gdx
$load  Water_cons
$gdxin

$gdxin basedata\demand_data.gdx
$load  Inhab
$gdxin

$gdxin basedata\demand_data.gdx
$load  rooms
$gdxin

$gdxin basedata\demand_data.gdx
$load  temp
$gdxin

$gdxin basedata\demand_data.gdx
$load  temp_cc
$gdxin

$gdxin basedata\demand_data.gdx
$load  households
$gdxin








