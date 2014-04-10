private ["_chopper", "_unit"];
_chopper = _this select 0;
_unit = _this select 2;

if (!local _unit) exitWith {};

private ["_properties", "_hasPipMain", "_hasPipSecondary"];
_properties = _chopper getVariable "NEO_chopperProperties";
_hasPipMain = (_properties select 2) select 0;
_hasPipSecondary = (_properties select 2) select 1;

if (_hasPipMain) then
{
	[_chopper, 0] call NEO_fnc_pipOn;
};

if (_hasPipSecondary) then
{
	[_chopper, 1] call NEO_fnc_pipOn;
};
