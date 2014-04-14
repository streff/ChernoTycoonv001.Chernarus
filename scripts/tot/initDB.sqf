//read values from db and create global tables
//tables: TOT_playerData, TOT_vehicleData, TOT_objectData, TOT_industryData

//set to run on SERVER only
if (isDedicated || isServer) then {

//load file
_tot_dbString = loadFile "\db\tot_db.txt";
//process file into an array from a string
_tot_db = call compile format["%1", _tot_dbString];


//split out the main tables from the db array
TOT_playerData = _tot_db select 0;
publicVariable "TOT_playerData";

TOT_vehicleData = _tot_db select 1;
publicVariable "TOT_vehicleData";

TOT_goodsData = _tot_db select 2;
publicVariable "TOT_goodsData";

TOT_objectData = _tot_db select 3;
publicVariable "TOT_objectData";

TOT_R3FstoredData = _tot_db select 4;
publicVariable "TOT_R3FstoredData";

TOT_industryData = _tot_db select 5;
publicVariable "TOT_industryData";




//set up individual players
{
private ["_name", "_cash", "_pos", "_dir"];
//get player info for each player entry - player info is a 2 entry array - formatted [name, [array of data - 0 cash 1 position 2 direction]]
_playerName = _x select 0;
_playerData = _x select 1;
_cash = _playerData select 0;
_bank = _playerData select 1;
_pos = _playerData select 2;
_dir = _playerData select 3;

//create cash and bank balances
call compile format["TOT_%1_cashBalance = %2;", _playerName, _cash];
call compile format["publicVariable 'TOT_%1_cashBalance';", _playerName];

call compile format["TOT_%1_bankBalance = %2;", _playerName, _bank];
call compile format["publicVariable 'TOT_%1_bankBalance';", _playerName];

//player direction and position set on login by initTycoon script - need to make them available to that script here
call compile format["TOT_%1_lastPos = %2;", _playerName, _pos];
call compile format["publicVariable 'TOT_%1_lastPos';", _playerName];
call compile format["TOT_%1_lastDir = %2;", _playerName, _dir];
call compile format["publicVariable 'TOT_%1_lastDir';", _playerName];
}forEach TOT_playerData;

//set up vehicles
{
//read name of object, and get its data
_veh = _x select 0;
_vehData = _x select 1;

//parse the data
_vehicle = _vehData select 0;
_passedInit = _vehData select 1;
_fuel = _vehData select 2;
_pos = _vehData select 3;
_dir = _vehData select 4;
_locked = _vehData select 5;
_owner = _vehData select 6;

//possible init lines
_stockInit = format["this setVariable['_owner','%1']; this execVM 'scripts\tot\vehicles\vehicleLock.sqf';", _owner];
_heliInit = format ["[this] execVM 'scripts\NEO_slingload\sl_init.sqf'; this execVM 'scripts\OSMO_interaction\OSMO_interaction_init.sqf';", _owner];


//create vehicles with init, position, direction and fuel level
_xveh = _vehicle createVehicle _pos;
_xveh setDir _dir;
_xveh setFuel _fuel;
_xveh lock _locked;


//rename the vehicle to the db entry
_vehNumber = _forEachIndex;
_varName = format["Vehicle_%1", _vehNumber];
_xveh setVehicleVarName _varName;
_xveh Call Compile Format ["%1=_this ; PublicVariable ""%1""", _varName];

//ifHeli hack - if heli set heli init, if not set stock and passed init
_isHeli = _xveh isKindOf "Helicopter";
_fullInit = "";
if (_isHeli) then {
_fullInit = format["%1 %2", _stockInit, _heliInit];
} else {
_fullInit = format["%1 %2", _stockInit, _passedInit];
};
_xveh setVehicleInit _fullInit;
processInitCommands;

} forEach TOT_vehicleData;

//set up goods
{
_goods = _x select 0;
_goodsData = _x select 1;

_useType = _goodsData select 0;
_pos = _goodsData select 1;
_dir = _goodsData select 2;
_goodsInfo = _goodsData select 3;

_xgoods = createVehicle[_useType, _pos,[], 0,"NONE"];
_xgoods setDir _dir;
_xgoods setVariable ["_goodsInfo", _goodsInfo, true];

//add addaction for player to be able to read box tags
_xgoods addAction["Read Shipping Label", "scripts\tot\readBoxes.sqf"];
						
						
//add addaction designate pickup
_xgoods addAction["Designate for Pickup", "scripts\tot\ai\designatePickup.sqf"];



//rename the R3F table data entry name, if applicable -- cycle through each entry in the storedData table and replace any instance of itself with its new name
_findString = _goods;
	{
	_contentPath = [TOT_R3FstoredData, _findString] call BIS_fnc_findNestedElement;
	if (count _contentPath > 0) then {
										[TOT_R3FstoredData, _contentPath, _xgoods] call BIS_fnc_setNestedElement;
								};
	} forEach TOT_R3FstoredData;
	
	
//rename the old entry in the db to the new goods name
_x set[0, _xgoods];
} forEach TOT_goodsData;


//set up objects
{
_obj = _x select 0;
_objData = _x select 1;

_useType = _objData select 0;
_pos = _objData select 1;
_dir = _objData select 2;

_xobj = createVehicle[_useType, _pos,[], 0,"NONE"];
_xobj setDir _dir;


//rename the R3F table data entry name, if applicable -- cycle through each entry in the storedData table and replace any instance of itself with its new name
_findString = _obj;
	{
	_contentPath = [TOT_R3FstoredData, _findString] call BIS_fnc_findNestedElement;
	if (count _contentPath > 0) then {
										[TOT_R3FstoredData, _contentPath, _xobj] call BIS_fnc_setNestedElement;
								};
	} forEach TOT_R3FstoredData;

//rename the old entry in the db to the new goods name
_x set[0, _xobj];
	
} forEach TOT_objectData;

//set up R3F contents

{
_obj = _x select 0;
_objData = _x select 1;

//write R3F_LOG_objets_charges entry to object, to be read on player access - should now contain non sanitised versions of both container and contents as written by previous loops
_obj setVariable["R3F_LOG_objets_charges", _objData];

} forEach TOT_R3FstoredData;

//set up industries
/*
{
_producer = _x select 0;
_industryVars = _x select 1;

_initVars = format ["TOT_" + str _producer + "_industryVars", _industryVars];
missionNamespace setVariable [_initVars, _industryVars];
publicVariable _initVars;

} forEach TOT_industryData;
*/
//initiate db update capture script
execVM "scripts\tot\dbUpdate.sqf";


}; // end ifdedicated/ifserver statement


