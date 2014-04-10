// designate site for heli passenger drop

//define variables for player, pilot, done switch and destination array
_caller = player;
_selectedUnits = groupSelectedUnits _caller;
_pilot = _selectedUnits select 0;
_done = false;


//give 6 sec to pick a unit using f keys - count of selected units will go above zero
_timeOut = time + 6;
hint "Select Units";
waitUntil{sleep 0.5; _selectedUnits = groupSelectedUnits _caller; count _selectedUnits > 0 || time > _timeOut};


hint format["%1, %2 ", _caller, _pilot];
if (count _selectedUnits < 1) exitWith {player globalChat "No Units Selected."};
{//after leaving menu deselect all units (command menu is not opened -> no selection)
    player groupSelectUnit [_x, false];
} forEach (groupSelectedUnits player);


hint "Select Dropoff Location on Map";


onMapSingleClick {	_dest = _pos; 

				onMapSingleClick ''; 

				true;
				};
										
_timeOut = time + 10;
waitUntil{(time > _timeOut) || (count _dest > 0)};
onMapSingleClick '';

if (count _dest < 1) exitWith {hint "No Drop Location";};

//orders begin

hint format["%1", _dest];

_pilot doMove _dest;
waitUntil{unitReady _pilot};
vehicle _pilot land "GET OUT";
waitUntil{unitReady _pilot};
hint "Drop Complete";