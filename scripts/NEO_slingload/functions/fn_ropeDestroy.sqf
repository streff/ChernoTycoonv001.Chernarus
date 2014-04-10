private ["_chopper", "_rope"];
_chopper = _this;
_rope = _chopper getVariable "NEO_rope";

ropeDestroy _rope;
_chopper setVariable ["NEO_rope", nil];
