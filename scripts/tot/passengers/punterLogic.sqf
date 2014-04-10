//punterLogic(tm)

private ["_remaining","_punter","_startTown","_startPos","_destTown","_desc","_destPos","_timeOut1","_timeOut2","_timestamp","_timeTaken","_timeMinutes","_timeHours","_dist","_distKm","_standardTimeSec","_standardTime","_performance","_perkm","_perfBonus","_payout"];

_punter = _this select 0;
_startTown = _this select 1;
_startPos = getPos _startTown;
_destTown = _this select 2;
_desc = _this select 3;
_cond = "";
_shtct = "Watch";


//add event handler for punter death - make sure it decreases the _fares count for start town
_punter addEventHandler ["killed", {_this execVM "scripts\tot\passengers\punterKilled.sqf";}];


_destPos = getPos _destTown;
//single player version
//_punter addAction["Take Passengers", "scripts\tot\passengers\punterBoard.sqf",[_punter, _startTown, _destTown, _desc],5, true, true,"watch","","", 20];
//mp version
[[_punter, "scripts\tot\passengers\punterBoard.sqf", "Take Passengers", [_punter, _startTown, _destTown, _desc], _cond], "TOT_fnc_MPAddactionParamCond", nil, true, true] spawn BIS_fnc_MP;


//_punter globalchat format["start punterlogic Towns: %1 %2", _startTown, _destTown];
//_punter globalchat format["start punterlogic Positions: %1 %2", _startPos, _destPos];

//wait until pickup
_timeOut1 = time + 1800; //pickup time
waitUntil{sleep 1; vehicle _punter != _punter || _timeOut1 < time};

//wait ended - either journey start or exit



if (time > _timeOut1) then {   //if wait longer than 30 min
	_punter move ((nearestBuilding _punter) buildingPos 0);		//walk away
	sleep 10;   // let them walk
	deleteVehicle _punter;  // kill ai
	_faresLabel = format ["TOT_" + str _startTown + "_Fares"];
	_fares = missionNamespace getVariable _faresLabel;
	_fares = _fares - 1;
	missionNamespace setVariable [_faresLabel, _fares];
	publicVariable _faresLabel;
	exit;
};

