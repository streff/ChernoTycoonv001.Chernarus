//initiate tycoon
//create cash/bank balances for each player on login, global variable, broadcast.
//Player setup - Client script
if (!isDedicated) then {

//ensure database has loaded
waitUntil{!isNil "TOT_playerData"};
sleep 2; // allow time for table manipulation


	_playerName = name player;
	player setVariable["_employer", name player];

	//test for pre-created dynamic global variable with the players name in it for cash balance - returning or new player?


if (isNil (format["TOT_%1_cashBalance", _playerName])) then	{		//if no entry exists for player, create one
		player globalchat "Welcome New Player - 60k cash on hand";
		call compile format["TOT_%1_cashBalance = 200000;", _playerName];
		call compile format["publicVariable 'TOT_%1_cashBalance';", _playerName];

		call compile format["TOT_%1_bankBalance = 0;", _playerName];
		call compile format["publicVariable 'TOT_%1_bankBalance';", _playerName];

		//create Osmo trigger for repairs payment - dont bother storing anything in db for this
		call compile format["TOT_%1_payOsmo = 0;", _playerName];

		//get dir and pos, set tracker on both
		_dir = getDir player;
		_pos = getPos player;
		
		//make labels for dynamic vars - read back ones you just created in the same format as pos and dir
		_cash = 0;
		_bank = 0;
		call compile format["_cash = TOT_%1_cashBalance;", _playerName];
		call compile format["_bank = TOT_%1_bankBalance;", _playerName];
		
		_cashlbl = format["TOT_%1_cashBalance", _playerName];
		_banklbl = format["TOT_%1_bankBalance", _playerName];
		_poslbl = format["TOT_%1_lastPos", _playerName];
		_dirlbl = format["TOT_%1_lastDir", _playerName];
		
		missionNamespace setVariable[_cashlbl, _cash];
		missionNamespace setVariable[_banklbl, _bank];
		missionNamespace setVariable[_poslbl, _pos];
		missionNamespace setVariable[_dirlbl, _dir];
		
		//add player details to global player db table and publish new version to all
		call compile format["[TOT_playerData, [%1, [%2, %3, %4, %5]]] call BIS_fnc_arrayPush;", str _playerName, _cashlbl, _banklbl, _poslbl, _dirlbl];
		publicVariable "TOT_playerData";
		
		//pass the labels to the tracker so you dont have to create them again, and start tracking position
		[player, _cashlbl, _banklbl, _poslbl, _dirlbl] execVM "scripts\tot\playerPos.sqf";
		
} else {	// Or if entry exists read it
		
		//define labels
		_cashlbl = format["TOT_%1_cashBalance", _playerName];
		_banklbl = format["TOT_%1_bankBalance", _playerName];
		_poslbl = format["TOT_%1_lastPos", _playerName];
		_dirlbl = format["TOT_%1_lastDir", _playerName];
		
		//define cash as 0 to allow it to be overwritten outside of the call command
		_cash = 0;
		_dir = 0;
		_pos = 0;
		call compile format["_cash = TOT_%1_cashBalance;", _playerName];
		hint format["Welcome Returning Player - Your Cash balance is %1", _cash];

		//create Osmo trigger for repairs payment - dont bother storing anything in db for this
		call compile format["TOT_%1_payOsmo = 0;", _playerName];

		
		//read global player db values and set player to location etc
		call compile format["_pos = TOT_%1_lastPos;", _playerName];
		call compile format["_dir = TOT_%1_lastDir;", _playerName];
		
		player setDir _dir;
		player setPos _pos;
		
		//pass the labels to the tracker so you dont have to create them again, and start tracking position
		[player, _cashlbl, _banklbl, _poslbl, _dirlbl] execVM "scripts\tot\playerPos.sqf";		
		
};

	
	//setup menu for ai orders and cash/bank balance check
player setRank "CAPTAIN";	

sleep 2;
If (isNil "BIS_MENU_GroupCommunication") then {
	BIS_MENU_GroupCommunication = [
		[localize "STR_SOM_COMMUNICATIONS", false]
	];
};

waituntil {!isnil "BIS_MENU_GroupCommunication"};
CUSTOM_menu = [
	["Menu",false],
	["Land",[2],"",-5,[["expression","[] execVM 'scripts\tot\ai\AiLand.sqf'"]],"1","1"],
	["Drop Off",[3],"",-5,[["expression","[] execVM 'scripts\tot\ai\AiLandDrop.sqf'"]],"1","1"],
	["Pickup",[4],"",-5,[["expression","[] execVM 'scripts\tot\ai\AiLandPick.sqf'"]],"1","1"],
	["Request Flare",[10],"",-5,[["expression","[] execVM 'scripts\tot\industries\industryFlare.sqf'"]],"1","1"],
	["Show Bank Balance",[11],"",-5,[["expression","[] execVM 'scripts\tot\industries\showBank.sqf'"]],"1","1"]
	
];

_count = count BIS_MENU_GroupCommunication;
BIS_MENU_GroupCommunication set [_count, ["Commands",[11],"#USER:CUSTOM_menu",-5,[["expression",""]],"1","1"]];


};  // end 'is not dedicated'