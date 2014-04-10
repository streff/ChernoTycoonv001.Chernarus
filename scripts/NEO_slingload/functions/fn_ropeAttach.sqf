private ["_chopper", "_cargo_properties", "_rope"];
_chopper = _this;
_cargo_properties = ((_chopper getVariable "NEO_chopperProperties") select 0) select 1;
_rope = _chopper getVariable "NEO_rope";

//Local Cargo
private ["_cargo"];
_cargo = (_cargo_properties select 0) createVehicleLocal (_cargo_properties select 1);
_cargo setDir (_cargo_properties select 2);
_cargo setPosASL (_cargo_properties select 1);


if (_cargo isKindOf "Man") then
{
	_cargo switchMove "winch_SaviourDown";
};

//Create new rope and attach it to cargo
[_cargo, [0,0,((boundingBox _cargo) select 1) select 2]] ropeAttachTo _rope;
ropeSetCargoMass [_rope, _cargo, 0];
_chopper setVariable ["NEO_rope", _rope];
_chopper setVariable ["NEO_rope_cargo", _cargo];
