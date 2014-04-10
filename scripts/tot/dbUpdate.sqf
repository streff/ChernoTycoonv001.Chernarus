//loop to capture updates to player global variables in db array
//will gather individual player variables (cash/bank balance, 

while {true} do {

{
_playerName = _x select 0;
_playerData = _x select 1;

//work out who your player is
_cashlbl = format["TOT_%1_cashBalance", _playerName];
_banklbl = format["TOT_%1_bankBalance", _playerName];
_poslbl = format["TOT_%1_lastPos", _playerName];
_dirlbl = format["TOT_%1_lastDir", _playerName];

//get their details from global variables - current values
_cash = missionNamespace getVariable _cashlbl;
_bank = missionNamespace getVariable _banklbl;
_pos = missionNamespace getVariable _poslbl;
_dir = missionNamespace getVariable _dirlbl;

//write current values to live db array
_x select 1 set[0, _cash];
_x select 1 set[1, _bank];
_x select 1 set[2, _pos];
_x select 1 set[3, _dir];

}forEach TOT_playerData;

//get vehicles
{
_veh = _x select 0;
_vehName = "";
call compile format["_vehName = %1", _veh];
_vehData = _x select 1;

//get current fuel level position direction lock status and owner
_fuel = fuel _vehName;
_pos = getPos _vehName;
_dir = getDir _vehName;
_locked = locked _vehname;
_owner = _vehName getVariable "_owner";

//write current value to liveDB array
_vehData set[2, _fuel];
_vehData set[3, _pos];
_vehData set[4, _dir];
_vehData set[5, _locked];
_vehData set[6, _owner];


} forEach TOT_vehicleData;

//get object data - bought items and cargo

//get industry data - current stock levels of all industries in game

_tot_db = [TOT_playerData, TOT_vehicleData, TOT_objectData, TOT_industryData];

//write to file
diag_log "++TOT DB OUTPUT START++";
diag_log _tot_db;
diag_log "++TOT DB OUTPUT END++";

//sleep timer
sleep 60;
}; //end loop