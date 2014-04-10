_caller = player;
_selectedUnits = groupSelectedUnits _caller;
dropMark = [];

_timeOut = time + 12;

hint "Select Units";

waitUntil{sleep 0.5; _selectedUnits = groupSelectedUnits _caller; count _selectedUnits > 0 || time > _timeOut};
_pilot = _selectedUnits select 0;
_heli = vehicle _pilot;
showCommandingMenu "";
{ 
    _caller groupSelectUnit [_x, false];
} forEach (groupSelectedUnits _caller);

_pilot move getPosATL _heli;
_pilot flyInHeight 25;