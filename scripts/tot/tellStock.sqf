_producer = _this select 0;

 //Re-read all the industryVars to get current situation

	//_industryVars = _producer getVariable "_industryVars";
	_industryVars = missionNamespace getVariable "TOT_" + str(_producer) + "_industryVars";
_prodRate = _industryVars select 0; //multiples of production - number
_priceOut = _industryVars  select 1; //unit price prices set in setup script
_priceIn = _industryVars  select 2;    //unit price of prices set in setup script
_produceType = _industryVars  select 3;  // name of goods - array
_available = _industryVars  select 4;  // number of goods available -  scarcity affects price
_maxAvailable = _industryVars  select 5;  // max number of goods available -  vendor storage space
_materials = _industryVars select 6; // mats available to produce from
_state = _industryVars select 7; //initial state
_loadbay = _industryVars select 8; //loadbay - goods outbound
_deliverbay = _industryVars select 9; //delivery bay - goods inbound

_producer globalchat format["%1 %2 available, %3 Max", _available, _produceType, _maxAvailable];
_producer globalchat format["%1 mats for use", _materials];