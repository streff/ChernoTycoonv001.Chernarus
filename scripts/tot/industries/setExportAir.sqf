// set entity as Exporter - Tertiary /quad production unit
// requires goods for production
//Goods Sink - exports goods



// init vars from init.sqf
_producer = _this select 0;
_loadbay = _this select 1;
_deliverbay = _this select 2;

//farm specific fixed values
_boxTypes = ["Fort_Crate_wood", "CargoCont_Net1_H", "Land_Misc_Cargo1E_EP1"];
_priceOut = 700;
_acceptsType = ["Land_Misc_Cargo1E_EP1", "CargoCont_Net1_H", "Fort_Crate_wood"];
_priceIn = 580;
_produceType = ["Tools"];
_acceptsGoods = ["Goods"];
_available = 1500;
_maxAvailable = 3000;
_materials = 0;
_prodRate = 0.8;
_state = 1;

//write the initial values to missionNamespace global variable

_initVars = format ["TOT_" + str _producer + "_industryVars", _industryVars];
_industryVars = [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials, _state, _loadbay, _deliverbay, _acceptsGoods];
missionNamespace setVariable [_initVars, _industryVars];
publicVariable _initVars;


//initialise production loop - sits idle due to state = 0 condition until player interaction
_x = [_producer, _loadbay, _boxTypes] execVM "scripts\tot\startProduction.sqf";
