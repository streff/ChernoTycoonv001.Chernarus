//general shop script - inventory items & weapons

// deliver to box in front of vendor
//define some prices
#define RIFLE_BASE 5000
#define ACOG 800
#define M203 300
#define AIM 200
#define RIFLE_AMMO_BASE 600
#define SMG_BASE 4000
#define PISTOL_BASE 1500
#define PISTOL_AMMO_BASE 80


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
	
		_stock = [
		

		["Makarov",       				1000],
		["M9",                    PISTOL_BASE]

		
		],	//end weapons
		
    };

    case 2:
    {
		_stock = [
		["M16A2",                 RIFLE_BASE],
		["M16A2GL",               RIFLE_BASE + M203],
		["M16A4_ACG_GL",          RIFLE_BASE + ACOG + M203],
		["M4SPR",                 RIFLE_BASE * 3],
		["M24",                   RIFLE_BASE * 4],
		["M9SD",                  PISTOL_BASE * 2]
		],	//end weapons
	
    };
};			

 		{
		_selection = _stock select _forEachIndex;
		_item = _selection select 0;
		_price = _selection select 1;
	_vendor addAction [format["Buy %1 - %2", _item, _price],"scripts\tot\vendors\tradeWeapon.sqf", [_item, _price, _spawnloc]];
//[[_vendor, "scripts\tot\vendors\tradeWeapon.sqf", format["Buy %1 - %2", _item, _price], [_item, _price, _spawnloc]], "TOT_fnc_MPAddactionParam", nil, false, true] call BIS_fnc_MP;
		} forEach _stock;


















