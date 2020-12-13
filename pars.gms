*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
$ontext
   Basin Agricultural Model

   Name      :   pars.gms
   Purpose   :   Core model parameters
   Author    :   R Ponce
   Date      :   03.09.14
   Since     :   January 2011
   CalledBy  :   run1_calPMP

   Notes     :   Declaration of core model parameters

$offtext
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*                         PARAMETERS DECLARATION                               *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
parameter
* farmland availability commune level
   iland        "irrigable land (ha) commune"
   tland        "total agricultural land (ha) commune"
   wland        "irrigated land in the reference period (ha) commune"

*   ---- base year data commune------
   yld          "crop yield (ton/h)"

   x0           "crop area (2007) in ha commune level"

   w0_a         "water delivery (2007) in Mm3 commune level for the agricultural sector"

   ps0          "producer price (CLP MM$/t)"
   qs0          "Supply quantity (ton)"

   selas        'supply elasticity'

   DW0           'Gross Water Delivered (River)Mm3/year'
   P_watsup_commQ50    '% Change in river flow percentile 50'
   p_hda           'delivery efficiency in agriculture'
   p_hdr           'delivery efficiency in residential network (65.6% SISS 2017)'
   p_hdra           'composed delivery efficiency parameter 50% each'
*p_hdr source: http://www.siss.gob.cl/586/articles-17553_Recurso_1.pdf*

*   ---- production costs by commune
   vcos         "average variable costs (CLP M$/ha) (labor cost not included)"
   lcos         "labour cost"
   kcos         "capital costs (CLP/ha) (AmEQ+AmPL+AMother)"
   vc           "all variable costs (vcos+lcos+kcos)"
   sgm          "standard gross margin (CLP $M/ha)"
   gm           "gross margin (CLP/ha) (trev-vcos-lcos)"
   nm           "net margin (CLP/ha) (trev-vc)"
   gva          "gros value added (CLP M$/ha) (trev-vcos)"
   nva          "net value added (CLP M$/ha) (trev-vcos-kcos)"
   marg         "crop economic data"
   lab          "labor demand per hectare"


* model data for baseline
   p_cropData(*,*,*,*)         'crop management data commune level'
   p_supplyData(*,*)           'supply data'
   p_marketData(*,*)           'market data'
   p_climChange(*,*,*,*,*)     'yield change at commune level'
   p_watsup_station(*,*)               'water supply data'
   p_watsup_commQ50(*)               'water supply data'

* crop water requirements and irrigation efficiency commune
   nir          "net irrigation requirements"
   fir          "farm-gate (field) irrigation requirements Mm3/ha"
   gir          "gros irrigation requirements Mm3/ha"


* water charges
   wtariff      "area based water tariff (canon + derrama)"

*   ---- cost function parameters commune
   alpha       "marginal cost intercept"
   beta        "marginal cost slope (activity)"
   alpha_ext   "marginal cost intercept considering externality in water use"
   beta_ext    "marginal cost slope (activity) considering externality in water use"
   cpar        "calibration parameters"
   cpar_ext    "calibration parameters considering externality in water use"

*   ---- simulation parameters commune

   y0          "initial yield"
   yCh         "yield change "
   tp          "technological progress"
   DWCh        'Water constraint with CC'




*~~~~~~~~~~~~~~~~~~~~~~~~ CALIBRATION PARAMETERS COMMUNE            ~~~~~~~~~~~~~~~~~~*
Parameter
   eps1       "epsilon (activity)"
   eps2       "epsilon (crop)"
   eps3       "epsilon (total crop area)"
   mu1        "dual values from calibration constraints (activity)"
   mu2        "dual values from calibration constraints (group)"
   mu3        "dual values from calibration constraints (total activity area)"
   cvpar      "cost function parameters"
   LambdaL    "land marginal value";

Parameter
  Margin      'marketing margin';


