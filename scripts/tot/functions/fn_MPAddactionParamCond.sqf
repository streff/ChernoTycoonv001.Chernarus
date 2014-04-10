//addaction function with parameters

TOT_fnc_MPAddactionParamCond = 
{
	private ["_unit", "_script", "_label", "_params", "_cond"];
	_unit = _this select 0;
	_script = _this select 1;
	_label = _this select 2;
	_params = _this select 3;
	_cond = _this select 4;
	_unit addAction [_label, _script, _params, 6, true, true, "", _cond, "", 10];
};
