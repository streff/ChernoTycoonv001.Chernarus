private ["_chopper"];
_chopper = _this;

private ["_rope"];
_rope = ropeCreate [_chopper, "slingload0", 15, 15, true];
ropeSetCargoMass [_rope, objNull, 1];

_chopper setVariable ["NEO_rope", _rope];
