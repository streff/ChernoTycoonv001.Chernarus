_caller = player;
_selectedUnits = groupSelectedUnits _caller;


_timeOut = time + 6;

hint "Select Units";

waitUntil{sleep 0.5; _selectedUnits = groupSelectedUnits _caller; count _selectedUnits > 0 || time > _timeOut};

_pilot = _selectedUnits select 0;
_heli = vehicle _pilot;

hint format["pilot: %1 heli: %2", _pilot, _heli];

_heli land "LAND";