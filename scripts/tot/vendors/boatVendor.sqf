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
["ContainerShip_blue_empty_H",	120000],
["Smallboat_1",	12000],
["smallboat_2",	12000],
["Fishing_boat",	24000]
		];	
    };

    case 2:
    {
		_stock = [
["ContainerShip_blue_empty_H",	40000]
		];

    };
};			

    

{
_selection = _stock select _forEachIndex;
_vehicle = _selection select 0;
_price = _selection select 1;
_vendor addAction [format["Buy %1 - %2", _vehicle, _price],"scripts\tot\vendors\tradeVehicle.sqf", [_vehicle, _price, _spawnloc, 'this setDir 260; this setPos getPos this;']];
//[[_vendor, "scripts\tot\vendors\tradeVehicle.sqf", format["Buy %1 - %2", _vehicle, _price], [_vehicle, _price, _spawnloc, 'this setDir 260; this setPos getPos this;']], "TOT_fnc_MPAddactionParam", nil, false, true] call BIS_fnc_MP;

} forEach _stock;
