
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
	["Gunrack1",				50],
	["MASH",					250],
	["Camp_EP1",					250],
	["SatPhone",				500],
	["Land_Fire_barrel",		200],
	["FoldTable",			20]
	
		];	
    };

    case 2:
    {
		_stock = [
	
	["Fort_RazorWire",			100],
	["Misc_cargo_cont_small",			600],
	["Misc_cargo_cont_small2",			600],
	["Misc_cargo_cont_tiny",			550],
	["Hedgehog",			100]
		];

    };
	
	    case 3:
    {
		_stock = [
		["USBasicAmmunitionBox",			50],
		["LocalBasicAmmunitionBox",			50],
		["Misc_cargo_cont_small_EP1",			500],
		["Gunrack1",			50]
		
		];

    };
};			

    

{
_selection = _stock select _forEachIndex;
_vehicle = _selection select 0;
_price = _selection select 1;
_vendor addAction [format["Buy %1 - %2", _vehicle, _price],"scripts\tot\vendors\tradeItems.sqf", [_vehicle, _price, _spawnloc]];
} forEach _stock;