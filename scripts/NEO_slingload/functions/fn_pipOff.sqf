private ["_chopper", "_pip"];
_chopper = _this select 0;
_pip = _this select 1;

private ["_render_target", "_render_target_ignored", "_var_name", "_var_name_secondary"];
_render_target = "";
_render_target_ignored = "";
_var_name = "";
_var_name_secondary = "";

if (_pip == 0) then
{
	_render_target = if (_chopper isKindOf "Heli_Medium01_Base_H") then { "rendertarget1" } else { "rendertarget0" };
	_render_target_ignored = if (_chopper isKindOf "Heli_Medium01_Base_H") then { "rendertarget0" } else { "rendertarget1" };
	_var_name = "NEO_chopper_pip";
	_var_name_secondary = "NEO_chopper_pip_secondary";
}
else
{
	_render_target = if (_chopper isKindOf "Heli_Medium01_Base_H") then { "rendertarget0" } else { "rendertarget1" };
	_render_target_ignored = if (_chopper isKindOf "Heli_Medium01_Base_H") then { "rendertarget1" } else { "rendertarget0" };
	_var_name = "NEO_chopper_pip_secondary";
	_var_name_secondary = "NEO_chopper_pip";
};

private ["_cam", "_cam_ignored"];
_cam = _chopper getVariable _var_name;
_cam_ignored = _chopper getVariable _var_name_secondary;

detach _cam;
_cam cameraEffect ["terminate", "back"];
camDestroy _cam;
_chopper setVariable [_var_name, nil];
[_render_target] call BIS_fnc_pip;

if (!isNil { _cam_ignored }) then
{
	_cam_ignored cameraEffect ["internal", "back", _render_target_ignored];
};
