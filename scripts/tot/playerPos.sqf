//track player position for live db write

//get passed variables

_target = _this select 0;
_cashlbl = _this select 1;
_banklbl = _this select 2;
_poslbl = _this select 3;
_dirlbl = _this select 4;
_playerName = name _target;

// start tracking loop
while {alive _target} do {

//dont choke the server
sleep 10;

//get the goods
_pos = getPos _target;
_dir = getDir _target;

//set the vars and make public to server
missionNamespace setVariable[_poslbl, _pos];
publicVariableServer _poslbl;
missionNamespace setVariable[_dirlbl, _dir];
publicVariableServer _dirlbl;

}; // end tracking loop
