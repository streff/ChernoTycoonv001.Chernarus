//generate passengers for transport to specific towns
//list of potential passengers

private ["_fares","_punter","_punterGroup","_destTown","_desc","_dude","_punters","_towns","_startTown","_remove","_sanTowns"];
_punters = ["Citizen1", "Citizen2", "Citizen3", "Citizen4", "Worker1", "Worker2", "Worker3", "Worker4", "Housewife2", "Housewife3", "Housewife4", "Housewife1", "Madam1", "Madam2", "Madam3"];

//list of available end destinations
_towns = [elektro_office, chernoTaxi, balota_town, balota_airfield, balota_docks, kamyshovo_bus, prigo_farm, komarovo_town];




//where from
_startTown = _this select 0;
_remove = [_startTown];
//sanitise towns to remove this town

_sanTowns = _towns - _remove;



//set repeats & controls
_faresLabel = format ["TOT_" + str _startTown + "_Fares"];
_fares = 0;
missionNamespace setVariable [_faresLabel, _fares];
publicVariable _faresLabel;


//start production loop - check current fares & produce more if required
while {true} do {

//limit to 2 ai at a time
while {_fares < 3} do
{


//generate passengers - 
sleep random 30;
_punter = _punters select (random ((count _punters)-1));

_punterGroup = createGroup civilian;
_punterGroup setGroupId ["Town Passengers"];



//where to
_destTown = _sanTowns select (floor (random ((count _sanTowns) - 1)));
_desc = _destTown getVariable "_desc";
_dude = _punterGroup createUnit [_punter, getPos _startTown, [], 2, "FORM"];
_dude setVariable["_startTown", _startTown];

[_dude, _startTown, _destTown, _desc] execVM 'scripts\tot\passengers\punterLogic.sqf';


_fares = _fares + 1;
missionNamespace setVariable [_faresLabel, _fares];
publicVariable _faresLabel;


}; //end passenger creation

sleep 300;

_fares = missionNamespace getVariable _faresLabel;

}; //end production cycle check loop thing

