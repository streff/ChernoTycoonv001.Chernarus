private ["_chopper", "_pip"];
_chopper = _this select 0;
_pip = _this select 1;

private ["_render_target", "_var_name", "_attach_pos", "_vector"];
_render_target = "";
_var_name = "";
_attach_pos = [];
_vector = [];

if (_pip == 0) then
{
	_render_target = if (_chopper isKindOf "Heli_Medium01_Base_H") then { "rendertarget1" } else { "rendertarget0" };
	_var_name = "NEO_chopper_pip";
	_attach_pos = _chopper selectionPosition "slingload0";
	_attach_pos set [0, (_attach_pos select 0) + 0.1];
	_vector = [0.0001,0.1,0.01];
}
else
{
	_render_target = if (_chopper isKindOf "Heli_Medium01_Base_H") then { "rendertarget0" } else { "rendertarget1" };
	_var_name = "NEO_chopper_pip_secondary";
	_attach_pos = if (_chopper isKindOf "Heli_Heavy_Base_H") then { [2.45,1.68,-0.7] } else { [1.32,1.44,-0.72] };
	_attach_pos set [1, (_attach_pos select 1) - 0.5];
	_vector = [0.0001,0.1,0.01];
};

private ["_cam"];
_cam = "camera" camCreate position _chopper;
_cam cameraEffect ["internal", "back", _render_target];
_cam attachTo [_chopper, _attach_pos];
_cam setVectorUp _vector;
[_render_target, _cam] call BIS_fnc_pip;
_chopper setVariable [_var_name, _cam];
