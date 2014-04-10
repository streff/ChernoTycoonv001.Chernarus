// set entity as Fishery - primary production unit
// requires 
// produces Food for transport to Market



// init vars from init.sqf
_producer = _this select 0;
_loadbay = _this select 1;
_deliverbay = _this select 2;

//producer specific values
_boxTypes = ["Fort_Crate_wood", "CargoCont_Net1_H", "Land_Misc_Cargo1E_EP1"];
_priceOut = 330;
_acceptsType = ["Fort_Crate_wood", "CargoCont_Net1_H", "Land_Misc_Cargo1E_EP1"];
_priceIn = 0;
_produceType = ["Food"];
_acceptsGoods = ["Empty"];
_available = 1000;
_maxAvailable = 2400;
_materials = 0;
_state = 1;
_prodRate = 1.5;
_state = 1;

//write the initial values to missionNamespace global variable

_initVars = format ["TOT_" + str _producer + "_industryVars", _industryVars];
_industryVars = [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials, _state, _loadbay, _deliverbay, _acceptsGoods];
missionNamespace setVariable [_initVars, _industryVars];
publicVariable _initVars;


//initialise production loop - sits idle due to state = 0 condition until player interaction
_x = [_producer, _loadbay, _boxTypes] execVM "scripts\tot\startProduction.sqf";
