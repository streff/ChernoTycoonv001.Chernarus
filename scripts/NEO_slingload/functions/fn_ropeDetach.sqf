private ["_chopper", "_rope", "_cargo"];
_chopper = _this select 0;
_rope = _chopper getVariable "NEO_rope";
_cargo = _chopper getVariable "NEO_rope_cargo";

private ["_isMan"];
_isMan = _cargo isKindOf "Man";

private ["_new_cargo_properties"];
_new_cargo_properties = _this select 1;
_new_cargo_properties set [1, getPosASL _cargo];
_new_cargo_properties set [2, getDir _cargo];

//Detach Rope
_chopper ropeDetach _rope;
ropeSetCargoMass [_rope, objNull, 1];
_chopper setVariable ["NEO_rope", _rope];

//Delete local cargo
deleteVehicle _cargo;
_chopper setVariable ["NEO_rope_cargo", nil];

//Create cargo on server only
if (local _chopper) then
{
	//Cargo Properties
	private ["_cargo", "_cargo_properties"];
	_cargo = objNull;
	_cargo_properties = _this select 1;
	
	if (_isMan) then
	{
		_cargo = (createGroup (_cargo_properties select 3)) createUnit [_cargo_properties select 0, _new_cargo_properties select 1, [], 0, "NONE"];
	}
	else
	{
		//_cargo = createVehicle [_cargo_properties select 0, _new_cargo_properties select 1, [], 0, "CAN_COLLIDE"];
		//_cargo setVariable ["_goodsInfo", _cargo_properties select 4, true];
		//add addaction for player to be able to read box tags
		//[_cargo addAction["Read Shipping Label", "scripts\tot\readBoxes.sqf"]] spawn BIS_fnc_MP;
		//add addaction designate pickup
		//[_cargo addAction["Designate for Pickup", "scripts\tot\ai\designatePickup.sqf"]] spawn BIS_fnc_MP;
		
		//move cargo back from debug-plains
		_cargo = _cargo_properties select 4;
		_cargo setPos (_new_cargo_properties select 1);
		_cargo setDir (_new_cargo_properties select 2);
		
	};
	
	_cargo setDir (_new_cargo_properties select 2);
	_cargo setPosASL (_new_cargo_properties select 1);
};
