// set vehicle params for road vehicles

_vehicle = _this;
_owner = _vehicle getVariable "_owner";

[_vehicle addAction["Lock Vehicle", "scripts\tot\vehicles\lock.sqf",[],2,false,true,"","(locked _target == 0 || locked _target == 1) && (_target getVariable '_owner' == name _this)"]] spawn BIS_fnc_MP;
[_vehicle addAction["Unlock Vehicle", "scripts\tot\vehicles\unlock.sqf",[],2,false,true,"","(locked _target == 2) && (_target getVariable '_owner' == name _this)"]] spawn BIS_fnc_MP;
