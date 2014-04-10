//general shop script - inventory items & weapons

// deliver to box in front of vendor



//define variables from kickoff script

_vendor = _this select 0;
_stockList = _this select 2;
_stock = [];
_selection = [];
_spawnloc = _this select 1;

//  available stock lists
			
switch (_stockList) do
{
    case 1:
    {
	
        _stock = [	//start mags
		
		["15Rnd_9x19_M9",            120],
		["8Rnd_9x18_Makarov",		100]
		
		]	//end mags
		
		
		
    };

    case 2:
    {
		_stock = [

		["15Rnd_9x19_M9",            50],
		["15Rnd_9x19_M9SD",         200],
		["30Rnd_556x45_Stanag",     100],
		["5Rnd_762x51_M24",         200]

		
		];	//end stock

    };
};			


		{
		_selection = _stock select _forEachIndex;
		_item = _selection select 0;
		_price = _selection select 1;
		_vendor addAction [format["Buy %1 - %2", _item, _price],"scripts\tot\vendors\tradeMag.sqf", [_item, _price, _spawnloc]];
		//[[_vendor, "scripts\tot\vendors\tradeMag.sqf", format["Buy %1 - %2", _item, _price], [_item, _price, _spawnloc]], "TOT_fnc_MPAddactionParam", nil, false, true] spawn BIS_fnc_MP;
		} forEach _stock;


























