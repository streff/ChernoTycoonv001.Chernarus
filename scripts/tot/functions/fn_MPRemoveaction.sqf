
// Remove all except first actions from the unit
TOT_fnc_MPRemoveaction = 
{
private ["_unit"];
_unit = _this select 0;
_action =_unit addAction["foo", "foo.sqf"];
	while {_action >= 0} do	{
	_unit removeAction _action;
	_action = _action - 1;
	};
};