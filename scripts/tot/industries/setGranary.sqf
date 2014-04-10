// set entity as Granary - secondary production unit
// requires grain for  production
// produces Food for transport to Market



// init vars from init.sqf
_producer = _this select 0;
_loadbay = _this select 1;
_deliverbay = _this select 2;

//farm specific fixed values
_boxTypes = ["Fort_Crate_wood", "CargoCont_Net1_H", "Land_Misc_Cargo1E_EP1"];
_priceOut = 360;
_acceptsType = ["Fort_Crate_wood", "CargoCont_Net1_H", "Land_Misc_Cargo1E_EP1"];
_priceIn = 280;
_produceType = ["Food"];
_acceptsGoods = ["Grain"];
_available = 100;
_maxAvailable = 800;
_materials = 0;
_prodRate = 1.6;
_state = 0;

//write the initial values to missionNamespace global variable

_initVars = format ["TOT_" + str _producer + "_industryVars", _industryVars];
_industryVars = [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials, _state, _loadbay, _deliverbay, _acceptsGoods];
missionNamespace setVariable [_initVars, _industryVars];
publicVariable _initVars;


//initialise production loop - sits idle due to state = 0 condition until player interaction
_x = [_producer, _loadbay, _boxTypes] execVM "scripts\tot\startProduction.sqf";