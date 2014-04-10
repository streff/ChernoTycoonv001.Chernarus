// designate cargo for heli pickup
/*
_caller = player;
_cargo = _this select 0;
_selectedUnits = groupSelectedUnits _caller;
_pilot = _selectedUnits select 0;
_done = false;



_wPosArray = waypoints group player;
_origWPCount = count _wPosArray;
player globalChat format["wp: %1", _origWPCount];

//set waypoint for slingload attach at cargo 

_cargoPos = getPos _cargo;
// bis function attempt - [object,target,completionRadius,<arguments>] spawn <functionName>;   attach time can be boolean 'true', failcode can be blank, weight can be blank default
player globalChat format["%1 %2 %3", _caller, _cargo, _origWPCount];
_wp1 = group player addWaypoint [_cargo,0];
_index = _wp1 select 1;
_wp1 setWaypointSpeed "FULL";
_wp1 setWaypointBehaviour "CARELESS";
_wp1 setWaypointType "ATTACH SLINGLOAD";
_wp1 setWaypointCompletionRadius 20;
[group player, _index, _cargo] spawn BIS_fnc_wpSlingLoadAttach;
_wPosArray = waypoints group player;
_firstUpdateWPCount = count _wPosArray;
player globalChat format["wp: %1", _firstUpdateWPCount];

*/
hint "disabled";


