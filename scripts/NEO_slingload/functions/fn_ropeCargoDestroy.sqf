private ["_chopper", "_rope", "_cargo"];
_chopper = _this select 0;
_rope = objNull;
_cargo = objNull;

private ["_properties", "_hasRopeHook", "_hasCargoHook", "_hasWinchRope", "_hasPipMain", "_hasPipSecondary"];
_properties = _chopper getVariable "NEO_chopperProperties";
_hasRopeHook = (_properties select 0) select 0;
_hasCargoHook = count ((_properties select 0) select 1) > 0;
_hasWinchRope = _properties select 1;
_hasPipMain = (_properties select 2) select 0;
_hasPipSecondary = (_properties select 2) select 1;

//Chopper has Cargo in rope?
if (_hasCargoHook) then
{
	[[_chopper, (_properties select 0) select 1], "NEO_fnc_ropeDetach"] call BIS_fnc_mp;
};

//Chopper has rope?
if (_hasRopeHook) then
{
	[_chopper, "NEO_fnc_ropeDestroy"] call BIS_fnc_mp;
};
