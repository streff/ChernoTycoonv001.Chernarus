private ["_chopper", "_fastrope"];
_chopper = _this;
_fastrope = _chopper getVariable "NEO_fastrope";

ropeDestroy _fastrope;
_chopper setVariable ["NEO_fastrope", nil];
