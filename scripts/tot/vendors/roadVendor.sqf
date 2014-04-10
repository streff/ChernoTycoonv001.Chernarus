// vehicle vendor

//define variables from kickoff script

_vendor = _this select 0;
_stockList = _this select 1;
_stock = [];
_selection = [];
_spawnloc = format["%1_spawn", _vendor];

//  available stock lists
			
switch (_stockList) do
{
    case 1:
    {
	
        _stock = [
		["Old_moto_TK_Civ_EP1",		800],
		["hilux1_civil_1_open",		8000],
		["Skoda",					2000],
		["VWGolf", 					4500]

		];	
    };

    case 2:
    {
		_stock = [
		
		["UralCivil",				20000],
		["UralCivil2",				20000],
		["V35_Civ",					25000],
		["ikarus",					12000]
		];

    };
	
	    case 3:
    {
		_stock = [
		
		["UralCivil",				20000],
		["V35_Civ",					25000],
		["ikarus",					12000]
		];

    };
};			

    

{
_selection = _stock select _forEachIndex;
_vehicle = _selection select 0;
_price = _selection select 1;
_vendor addAction [format["Buy %1 - %2", _vehicle, _price],"scripts\tot\vendors\tradeVehicle.sqf", [_vehicle, _price, _spawnloc, ""]];
//[[_vendor, "scripts\tot\vendors\tradeVehicle.sqf", format["Buy %1 - %2", _vehicle, _price], [_vehicle, _price, _spawnloc, ""]], "TOT_fnc_MPAddactionParam", nil, false, true] call BIS_fnc_MP;

} forEach _stock;
