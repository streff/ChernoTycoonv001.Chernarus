
private ["_dist","_randomAmmo","_allSources"];
player globalchat "Requesting Flare";

//if(isServer) then { 
_allSources = nearestObjects [player, ["Land_coneLight"], 1000];

if (count _allsources > 0) then {

{
_dist = floor(_x distance player);
player globalchat format["Distance to flare - %1 m", _dist];

private ["_ammo","_randomColour"];
_ammo = ["F_40mm_white","F_40mm_yellow","F_40mm_green","F_40mm_red"];
_randomAmmo = _ammo select (floor (random (count _ammo)));

_randomAmmo createVehicle [(getPos _x select 0),(getPos _x select 1),500];
"SmokeShellGreen" createVehicle [(getPos _x select 0),(getPos _x select 1),0.2];
}forEach _allsources;
};
//};