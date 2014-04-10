// if on, turn off. if off, turn on. simples.

_producer = _this select 3 select 0;
_owner = _this select 1;
_id = _this select 2;


_state = _producer getVariable "_state";

if (_state == 0 ) then {
_producer setVariable ["_state", 1];  //turn on production
_producer setVariable ["_owner", _owner];  //set who's contract it is

// remove old action
_producer removeAction _id;

//add interaction with farmer to start/stop loop command variable string thing.. 0 for off 1 for on - script toggles
_y = _producer addAction["stop Production", "scripts\tot\toggleProduction.sqf", [_producer]];

} else {

player globalchat "detected state on, turning off";
_producer setVariable ["_state", 0];  //turn off production
//remove old action  stop
_producer removeAction _id;
//replace with new action  start
_producer addAction["start Production", "scripts\tot\toggleProduction.sqf", [_producer]];

};