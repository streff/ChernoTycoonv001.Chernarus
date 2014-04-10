//add addaction with no extra parameters

TOT_fnc_MPAddactionNoParam = 
{
	private ["_unit", "_script", "_label"];
	_unit = _this select 0;
	_script = _this select 1;
	_label = _this select 2;
	_unit addAction [_label, _script];

};