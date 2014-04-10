// get location of player
//_currentLocation = position player;
//_nBuilding = nearestBuilding player;

//player globalchat format["Loc: %1", _currentLocation];
//player globalchat format["Building: %1", _nBuilding];

//_knows = vehicle cursorTarget;
//player globalChat format["%1", _knows];
//_knows2 = cursorTarget getVariable "_desc";
//player globalChat format["%1", _knows2];

//player globalChat format["vehicle player: %1", vehicle player];
//player globalChat format["vehicle target: %1", vehicle cursorTarget];



//_index = count waypoints group player;
//player globalChat format["count wp: %1", _index];


_industryVars = missionNamespace getVariable "TOT_" + str cursorTarget + "_industryVars";
player globalChat format["IV: %1", _industryVars];