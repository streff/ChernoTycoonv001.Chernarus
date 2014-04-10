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


clicked = false;

onMapSingleClick {	clicked=true;
					dropMark = _pos;
					onMapSingleClick ""};



hint "Select Dropoff Location";
openMap true;
_timeOut2 = time + 6;
waituntil {clicked || (time > _timeOut2)};

openMap false;

hint format["%1", dropMark];
if ((count dropMark) < 1) exitWith {hint "No Mark Placed";};

//tell pilot to move to location
_pilot commandMove dropMark;

waitUntil{sleep 3; _ready = unitReady _pilot; _ready};
hint format["%1 on site", _heli];
_heli land "GET OUT";
waitUntil{sleep 3; _ready = unitReady _pilot; _ready}