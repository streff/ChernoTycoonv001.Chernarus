//addaction function with parameters

TOT_fnc_MPAddactionParam = 
{
	private ["_unit", "_script", "_label", "_params"];
	_unit = _this select 0;
	_script = _this select 1;
	_label = _this select 2;
	_params = _this select 3;
	_unit addAction [_label, _script, _params];
};
