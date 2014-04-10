// vehicle vendor
//define variables from init

_vendor = _this select 0;
_stockList = _this select 1;
_stock = [];
_selection = [];
_spawnloc = format["%1_spawn", _vendor];

//  available stock lists
			
switch (_stockList) do
{
    case 1:				//light basic
    {
	
        _stock = [
		["Heli_Light01_H",				35000],
		["Heli_Light01_shadow_H",		35000],
		["Heli_Light01_cougar_H",		35000]
		];	
    };

	case 2:						//light, fancy paintjobs
    {
		_stock = [
        ["Heli_Light01_wasp_H",			35000],
        ["Heli_Light01_digital_H",		35000],
        ["Heli_Light_H_DLC2",			35000],
        ["Heli_Light01_vrana_H",		35000]
		];

    };
	
	case 3:					//heavy/medium
    {
		_stock = [
        ["Heli_Medium01_H",				55000],
		["Heli_Medium01_Shark_H",		55000],
		["Heli_Heavy01_H",				80000],
		["Heli_Heavy01_Vrana_H",		80000]
		];

    };
	
	case 4:						//armed
    {
		_stock = [
        ["IND_Heli_Light01_Military_H",		50000],
        ["IND_Heli_Medium01_Military_H",		60000],
        ["IND_Heli_Heavy01_Military_H",		85000]
        		];

    };
};			

{
_selection = _stock select _forEachIndex;
_vehicle = _selection select 0;
_price = _selection select 1;

_vendor addAction [format["Buy %1 - %2", _vehicle, _price],"scripts\tot\vendors\tradeVehicle.sqf", [_vehicle, _price, _spawnloc, "[this] execVM 'scripts\NEO_slingload\sl_init.sqf'; this execVM 'scripts\OSMO_interaction\OSMO_interaction_init.sqf'; "]];

//_vendor addAction [format["Buy %1 - %2", _vehicle, _price],"scripts\tot\vendors\tradeVehicle.sqf", [_vehicle, _price, _spawnloc, "this execVM 'scripts\OSMO_interaction\OSMO_interaction_init.sqf';"]];
//[[_vendor, "scripts\tot\vendors\tradeVehicle.sqf", format["Buy %1 - %2", _vehicle, _price], [_vehicle, _price, _spawnloc, "this execVM 'scripts\OSMO_interaction\OSMO_interaction_init.sqf'; (allMissionObjects 'Air') execVM 'scripts\NEO_slingload\sl_init.sqf';"]], "TOT_fnc_MPAddactionParam", nil, false, true] spawn BIS_fnc_MP;

} forEach _stock;
