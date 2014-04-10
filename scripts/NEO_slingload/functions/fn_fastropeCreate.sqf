private ["_chopper"];
_chopper = _this;

private ["_winch"];
_winch = if (_chopper isKindOf "Heli_Heavy_Base_H") then { [2.45,1.68,-0.7] } else { [1.32,1.44,-0.72] };

private ["_fastrope"];
_fastrope = ropeCreate [_chopper, _winch, 15, 15, true];
ropeSetCargoMass [_fastrope, objNull, 1];

_chopper setVariable ["NEO_fastrope", _fastrope];
