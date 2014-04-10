//drop cargo - select location from map
hint "Select Map Location";

_firstWPCount = count _wPosArray;
_secondWPCount = count _wPosArray;



_done = false;

onMapSingleClick {	_wp2 = group player addWaypoint [_pos, 0];
					index = _wp2 select 1;
					_wp2 setWaypointType "DETACH SLINGLOAD";
					_wp2 setWaypointSpeed "FULL";
					_wp2 setWaypointBehaviour "CARELESS";
					_wp2 setWaypointCompletionRadius 20;
					[player, _index, 3, [90, 10]] spawn BIS_fnc_wpSlingLoadDetach;
					//_wp2 setWaypointStatements ["true", "_pilot globalChat 'Unloaded Goods.'; _done = true;"];
					_wPosArray = waypoints group player;
					_secondWPCount = count _wPosArray;
					onMapSingleClick "";
										};


_timeOut = time + 6;
waitUntil {sleep 1; time > _timeOut};
if (_secondWPCount == _firstWPCount) exitWith {hint "No WP created";};

_timeOut2 = time + 10;

//check complete, delete waypoint

/*
_wPosArray = waypoints group player;
_origWPCount1 = count _wPosArray;
player globalChat format["%1", _origWPCount1];-

//DO A WAIT UNTIL SOMETHING TO DO WITH THE setWaypointsStatements THING ABOVE
waitUntil {sleep 5; _done == true};
_wPosArray = waypoints group player;
_finalWPcount = count _wPosArray;
while {_finalWPcount > 1} do
deleteWaypoint [group player, 0];
_finalWPcount = _finalWPcount - 1;
player globalChat format["WPs: %1", _finalWPcount];
*/