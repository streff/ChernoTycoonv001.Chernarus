private ["_chopper", "_unit", "_fastrope"];
_chopper = _this select 0;
_unit = _this select 1;
_fastrope = _this select 2;

private ["_ropeEnd", "_ropeEndHeight"];

[[[_unit, _chopper, _fastrope], { (_this select 0) setDir ([getPosASL (_this select 2), (_this select 1)] call BIS_fnc_dirTo); (_this select 0) setPosASL getPosASL (_this select 2); }], "NEO_fnc_callCode"] call BIS_fnc_mp;
[[_unit, { _this switchMove "rope_slidingloop" }], "NEO_fnc_callCode"] call BIS_fnc_mp;

private ["_chopper_start_pos", "_chopper_moved_far"];
_chopper_start_pos = getPosASL _chopper;
_chopper_moved_far = false;

waitUntil 
{
	private ["_vel", "_target", "_dir", "_vertical_speed", "_horizontal_speed"];
	_vel = velocity _unit;
	_target = if (abs((getPosASL _unit select 2) - (getPosASL _fastrope select 2)) < 9) then { getPosASL _fastrope } else { ropeEndPosition _fastrope };
	_dir = [_unit, ropeEndPosition _fastrope] call BIS_fnc_dirTo;
	_vertical_speed = -2;
	_horizontal_speed = 0.08;
	
	_unit setDir _dir;
	_unit setFormDir _dir;
	_unit setVelocity [(_vel select 0)+(sin _dir*_horizontal_speed),(_vel select 1)+ (cos _dir*_horizontal_speed), _vertical_speed];
	
	_ropeEnd = ropeEndPosition _fastrope;
	_ropeEndHeight = _ropeEnd select 2;
	
	if (getPosASL _chopper distance _chopper_start_pos > 4) then
	{
		_chopper_moved_far = true;
	};
	
	sleep 0.01;
	
	_chopper_moved_far
	||
	getPosASL _unit select 2 <= _ropeEndHeight
	||
	getPosASL _unit select 2 < 2
	||
	getPosATL _unit select 2 < 2
	||
	velocity _unit select 2 > -0.1
	||
	!alive _chopper
	||
	!alive _unit
};

if (_chopper_moved_far || ((getPosASL _unit select 2) > 3 && (getPosATL _unit select 2) > 3)) then
{
	[[_unit, { _this switchMove "rope_freefallstart" }], "NEO_fnc_callCode"] call BIS_fnc_mp;
	waitUntil { velocity _unit select 2 > -0.1 || !alive _unit };
	[[_unit, { _this switchMove "aidlpercmstpsnonwnondnon_player_idlesteady03" }], "NEO_fnc_callCode"] call BIS_fnc_mp;
}
else
{
	[[_unit, { _this switchMove "aidlpercmstpsnonwnondnon_player_idlesteady03" }], "NEO_fnc_callCode"] call BIS_fnc_mp;
	_unit setVelocity [0,0,0];
};
