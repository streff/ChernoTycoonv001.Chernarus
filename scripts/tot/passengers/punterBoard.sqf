//punter logic call to board vehicle


private ["_action","_punter","_driver","_destTown","_desc","_timelimit","_timeOut","_timestamp"];

_driver = _this select 1;
_employer = name leader _driver;
_punter = _this select 3 select 0;
_startTown = _this select 3 select 1;
_destTown = _this select 3 select 2;
_destPos = getPos _destTown;
_desc = _this select 3 select 3;
_startPos = getPos _startTown;
_timelimit = 20;

_id = _this select 2;

// Remove all addActions from the unit
[[_punter], "TOT_fnc_MPRemoveaction", nil, false, true] call BIS_fnc_MP; 

//follow driver to car/whatever - doesnt seem to work - need to join group? dont really want to
_punter doFollow _driver;
//wait until the driver is in a car - their 'driver' will return themselves until they get in
waitUntil{vehicle _driver != _driver};

_punter assignAsCargo vehicle _driver;
[_punter] orderGetIn true;

 _timeOut = time + _timelimit; 
waitUntil{sleep 1; vehicle _punter == vehicle _driver || time > _timeOut};
	
	
	_punter action ["getInCargo", vehicle _driver];
	//_punter globalChat format["driver: %1", _driver];
	

_timestamp = time;
_punter setVariable["_timestamp", _timestamp];
["AmbienceHeliportGreeting","BIS_fnc_genericSentence"] call BIS_fnc_MP;
_punter globalChat format["Hi, take me to %1 please.", _desc];




_remaining = _punter distance _destPos;
//driving
_timeOut2 = time + 1200; //journey time

//normal version - no chat
waitUntil {sleep 10; _remaining = _punter distance _destPos; (_remaining < 1000) || (time > _timeOut2) };

//1 km out - say something 
//["AmbienceFlightApproach"] spawn BIS_fnc_genericSentence;
["AmbienceFlightApproach","BIS_fnc_genericSentence"] call BIS_fnc_MP;

//normal version - no chat
waitUntil {sleep 1; _remaining = _punter distance _destPos; (_remaining < 30) || (time > _timeOut2)};

if (time > _timeOut2) then {   //if journey longer than 20min
	_punter globalchat "This is taking too long.";
	unassignVehicle _punter;	//ditch ai
	_punter move (nearestBuilding _punter buildingPos 0);		//walk away
	sleep 20; // let them walk
	
	_faresLabel = format ["TOT_" + str _startTown + "_Fares"];
	_fares = missionNamespace getVariable _faresLabel;
	_fares = _fares - 1;
	missionNamespace setVariable [_faresLabel, _fares];
	publicVariable _faresLabel;
	deleteVehicle _punter;  // kill ai
	exit;
};


//in range
if (_remaining < 30) then {
	//get timestamp
	_timestamp = _punter getVariable "_timestamp";
	_punter globalchat "Anywhere around here will do fine.";

//calculate time taken
	_timeTaken = time - _timestamp;
	_timeMinutes = round (((_timeTaken / 60) * (10 ^ 2)) / (10 ^ 2));
	_timeHours = _timeMinutes / 60;
	_dist = _startPos distance _destPos;
	_distKm = _dist / 1000;

// time to beat (bonus is .3 of perkm payout for this time target)
	_standardTimeSec = _dist / 10;
	_standardTime = round (((_standardTimeSec / 60) * (10 ^ 2)) / (10 ^ 2));
	_performance = _standardTime / _timeMinutes;


_perkm = 3 * (_dist / 100);
_perfBonus = floor(_performance * (_perkm * 0.3));
//_punter globalchat format["minutes: %1  _standardTime: %2 _performance: %3 _perkm: %4 _perfBonus: %5", _timeMinutes, _standardTime, _performance, _perkm, _perfBonus];
_punter globalchat format["Time Taken: %1  Bonus: %2", _timeMinutes, _perfBonus];

_payout = floor(_perkm + _perfBonus);

if (_performance > 1) then {
["FeedbackGeneralGood","BIS_fnc_genericSentence"] call BIS_fnc_MP;
} else{
["FeedbackGeneralBad","BIS_fnc_genericSentence"] call BIS_fnc_MP;
};



call compile format["TOT_%1_cashBalance = TOT_%1_cashBalance + _payout", _employer];
call compile format["publicVariable 'TOT_%1_cashBalance';", _employer];
hint format["Recieved $%1", _payout];
_punter globalchat format["That comes to $%1.", _payout];



	_faresLabel = format ["TOT_" + str _startTown + "_Fares"];
	_fares = missionNamespace getVariable _faresLabel;
	_fares = _fares - 1;
	missionNamespace setVariable [_faresLabel, _fares];
	publicVariable _faresLabel;
	
//LOCALITY CHANGE
unassignVehicle _punter;
_punter move ((nearestBuilding _punter) buildingPos 0);		//walk away
sleep 20;   // let them walk
deleteVehicle _punter;  // kill ai
};
