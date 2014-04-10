private ["_chopper", "_unit"];
_chopper = _this select 0;
_unit = _this select 2;

if (!local _unit) exitWith {};

[_chopper, 0] call NEO_fnc_pipOff;
[_chopper, 1] call NEO_fnc_pipOff;
