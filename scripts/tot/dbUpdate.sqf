//loop to capture updates to player global variables in db array
//will gather individual player variables (cash/bank balance, 
//todo: make all this into function calls for performance and ease of conversion to proper db in future

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

//get vehicles---------------------------------------------------------------------------------------------------------------
//todo: check if vehicle is still alive and remove from the db
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

//get goods data - cargo ------------------------------------------------------------------------------------
//todo: check if goods have been traded in/deleted and remove from db
{
_goodsName = _x select 0;
_goodsData = _x select 1;

//get current position direction goodsinfo
_pos = getPos _goodsName;
_dir = getDir _goodsName;
_goodsInfo = _goodsName getVariable "_goodsInfo";

//write current value to liveDB array
_goodsData set[1, _pos];
_goodsData set[2, _dir];
_goodsData set[3, _goodsInfo];

} forEach TOT_goodsData;

//get object data - bought object ------------------------------------------------------------------------------------

{

_objName = _x select 0;
_objData = _x select 1;

//get current position direction contents
_pos = getPos _objName;
_dir = getDir _objName;
_objets_charges = "";

if (!isNil{_objName getVariable "R3F_LOG_objets_charges"}) then {
_objets_charges = _objName getVariable "R3F_LOG_objets_charges";
};

//write current value to liveDB array
_objData set[2, _pos];
_objData set[3, _dir];
_objData set[4, _objets_charges];


} forEach TOT_objectData;

//get industry data - current stock levels of all industries in game------------------------------------------


//arrange 4 tables into main table and write to db
_tot_db = [TOT_playerData, TOT_vehicleData, TOT_goodsData, TOT_objectData, TOT_industryData];

//copy the live db before sanitising and writing to file - object and vehicle names need turned to strings
_tot_write_db = +_tot_db;

//sanitise goods and object names
{
_x set[0, str (_x select 0)];
} forEach (_tot_write_db select 2);

{
_x set[0, str (_x select 0)];
} forEach (_tot_write_db select 3);

//write to file
diag_log "++TOT DB OUTPUT START++";
diag_log _tot_write_db;
diag_log "++TOT DB OUTPUT END++";


//sleep timer
sleep 60;
}; //end loop