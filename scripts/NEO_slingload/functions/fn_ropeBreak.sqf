private ["_chopper", "_rope"];
_chopper = _this select 0;
_rope = _this select 1;
if (!local _chopper) exitWith {};

private ["_properties", "_hasRopeHook", "_hasCargoHook", "_hasWinchRope", "_hasPipMain", "_hasPipSecondary"];
_properties = _chopper getVariable "NEO_chopperProperties";
_hasRopeHook = (_properties select 0) select 0;
_hasCargoHook = count ((_properties select 0) select 1) > 0;
_hasWinchRope = _properties select 1;
_hasPipMain = (_properties select 2) select 0;
_hasPipSecondary = (_properties select 2) select 1;

[[_chopper, (_properties select 0) select 1], "NEO_fnc_ropeDetach"] call BIS_fnc_mp;
_chopper setVariable ["NEO_chopperProperties", [[true, []], _hasWinchRope, [_hasPipMain, _hasPipSecondary]], true];
hint "Cargo lost, rope did not hold...";
