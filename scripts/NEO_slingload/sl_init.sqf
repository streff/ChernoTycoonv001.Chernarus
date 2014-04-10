//Functions
#include "functions\fn_init.sqf"

if (isServer) then
{
	private ["_choppers"];
	_choppers = _this;
	
	//Chopper rope and cargo properties
	{
		private ["_chopper"];
		_chopper = _x;
		
		//Chopper Stuff
		_chopper setVariable ["NEO_chopperProperties", [[false, []], false, [false, false]], true];
		
	} forEach _choppers;
	
	//Broadcast chopper list to everyone
	//NEO_choppers = NEO_choppers + _choppers;
	NEO_choppers = (allMissionObjects "Air");
	publicVariable "NEO_choppers";
};

if (!isDedicated) then
{
	waitUntil { !isNil { player } };
	waitUntil { !isNull player };
	waitUntil { !(player != player) };
	waitUntil { !isNil { NEO_choppers } };
	
	{
		private ["_chopper"];
		_chopper = _x;
		
		
		if ((alive _chopper) && isNil{_chopper getVariable "hasActions"}) then
		{
			//Actions
			//_chopper addAction ["Deploy Hook Rope", "scripts\NEO_slingload\sl_action.sqf", "create", 99, false, true, "getOver", "isNil { _target getVariable 'NEO_rope' } && (_target animationPhase 'AddCargoHook' == 1)", "", 3, -1, 1 + 4, 1 + 2];
			_chopper addAction ["Deploy Hook Rope", "scripts\NEO_slingload\sl_action.sqf", "create", 99, false, true, "getOver", "isNil { _target getVariable 'NEO_rope' }", "", 3, -1, 1 + 4, 1 + 2];
			//_chopper addAction ["Pull Hook Rope", "scripts\NEO_slingload\sl_action.sqf", "destroy", 99, false, true, "getOver", "!isNil { _target getVariable 'NEO_rope' } && isNil { _target getVariable 'NEO_rope_cargo' } && (_target animationPhase 'AddCargoHook' == 1)", "", 3, -1, 1 + 4, 1 + 2];
			_chopper addAction ["Pull Hook Rope", "scripts\NEO_slingload\sl_action.sqf", "destroy", 99, false, true, "getOver", "!isNil { _target getVariable 'NEO_rope' } && isNil { _target getVariable 'NEO_rope_cargo' }", "", 3, -1, 1 + 4, 1 + 2];
			_chopper addAction ["Attach Cargo", "scripts\NEO_slingload\sl_action.sqf", "attach", 98, false, true, "binocular", "!isNil { _target getVariable 'NEO_rope' } && isNil { _target getVariable 'NEO_rope_cargo' }", "", 3, -1, 1 + 4, 1 + 2];
			_chopper addAction ["Detach Cargo", "scripts\NEO_slingload\sl_action.sqf", "detach", 98, false, true, "binocular", "!isNil { _target getVariable 'NEO_rope' } && !isNil { _target getVariable 'NEO_rope_cargo' }", "", 3, -1, 1 + 4, 1 + 2];
			_chopper addAction ["Rope Camera On", "scripts\NEO_slingload\sl_action.sqf", "pipOn", 95, true, true, "", "isPiPEnabled && isNil { _target getVariable 'NEO_chopper_pip' } && (_target animationPhase 'AddScreen1' == 1 || !(_target isKindOf 'Heli_Light01_Base_H'))", "action_screen1", 3, 0.08, 1 + 2 + 4 + 16, 1 + 2, "<img image='HSim\UI_H\data\igui\ico_on_ca' size='2' shadow='true' />", "<br /><t size='0.8'>" + "Turn On" + "</t>"];
			_chopper addAction ["Rope Camera Off", "scripts\NEO_slingload\sl_action.sqf", "pipOff", 95, true, true, "", "isPiPEnabled && !isNil { _target getVariable 'NEO_chopper_pip' } && (_target animationPhase 'AddScreen1' == 1 || !(_target isKindOf 'Heli_Light01_Base_H'))", "action_screen1", 3, 0.08, 1 + 2 + 4 + 16, 1 + 2, "<img image='HSim\UI_H\data\igui\ico_off_ca' size='2' shadow='true' />", "<br /><t size='0.8'>" + "Turn Off" + "</t>"];
			if !(_chopper isKindOf "Heli_Light01_Base_H") then { _chopper addAction ["Deploy Winch Rope", "scripts\NEO_slingload\sl_action.sqf", "create_fastrope", 97, false, true, "", "isNil { _target getVariable 'NEO_fastrope' } && _target animationPhase 'AddWinch' == 1 && !((_target getVariable 'NEO_chopperProperties') select 1)", "", 3, -1, 1 + 4, 1 + 2] };
			if !(_chopper isKindOf "Heli_Light01_Base_H") then { _chopper addAction ["Pull Winch Rope", "scripts\NEO_slingload\sl_action.sqf", "destroy_fastrope", 97, false, true, "", "!isNil { _target getVariable 'NEO_fastrope' } && _target animationPhase 'AddWinch' == 1 && ((_target getVariable 'NEO_chopperProperties') select 1)", "", 3, -1, 1 + 4, 1 + 2] };
			if !(_chopper isKindOf "Heli_Light01_Base_H") then { _chopper addAction ["Fast-Rope", "scripts\NEO_slingload\sl_action.sqf", "fastrope", 96, false, true, "", "!isNil { _target getVariable 'NEO_fastrope' } && (getPosASL _target select 2 > 5 && getPosATL _target select 2 > 5) && _this in assignedCargo _target", "", 3, -1, 4, 2] };
			if !(_chopper isKindOf "Heli_Light01_Base_H") then { _chopper addAction ["Fastrope Camera On", "scripts\NEO_slingload\sl_action.sqf", "pipOnSecondary", 94, false, true, "", "isPiPEnabled && isNil { _target getVariable 'NEO_chopper_pip_secondary' }", "action_screen1", 3, 0.08, 1 + 2 + 4 + 16, 1 + 2, "<img image='HSim\UI_H\data\igui\ico_on_ca' size='2' shadow='true' />", "<br /><t size='0.8'>" + "Turn On" + "</t>"] };
			if !(_chopper isKindOf "Heli_Light01_Base_H") then { _chopper addAction ["Fastrope Camera Off", "scripts\NEO_slingload\sl_action.sqf", "pipOffSecondary", 94, false, true, "", "isPiPEnabled && !isNil { _target getVariable 'NEO_chopper_pip_secondary' }", "action_screen1", 3, 0.08, 1 + 2 + 4 + 16, 1 + 2, "<img image='HSim\UI_H\data\igui\ico_off_ca' size='2' shadow='true' />", "<br /><t size='0.8'>" + "Turn Off" + "</t>"] };
			_chopper setVariable["hasActions", 1, true];
			
			private ["_properties", "_hasRopeHook", "_hasCargoHook", "_hasWinchRope", "_hasPipMain", "_hasPipSecondary"];
			_properties = _chopper getVariable "NEO_chopperProperties";
			_hasRopeHook = (_properties select 0) select 0;
			_hasCargoHook = count ((_properties select 0) select 1) > 0;
			_hasWinchRope = _properties select 1;
			_hasPipMain = (_properties select 2) select 0;
			_hasPipSecondary = (_properties select 2) select 1;
			
			private ["_rope", "_cargo"];
			_rope = objNull;
			_cargo = objNull;
			
			private ["_rope", "_killed", "_getin", "_getout"];
			_rope = _chopper addEventHandler ["RopeBreak", { _this call NEO_fnc_ropeBreak }];
			_killed = _chopper addEventHandler ["Killed", { _this call NEO_fnc_ropeCargoDestroy }];
			_getin = _chopper addEventHandler ["GetIn", { _this call NEO_fnc_pipGetIn }];
			_getout = _chopper addEventHandler ["GetOut", { _this call NEO_fnc_pipGetOut }];
			
			//Chopper has rope?
			if (_hasRopeHook) then
			{
				_rope = ropeCreate [_chopper, "slingload0", 15, 15, false];
				_chopper setVariable ["NEO_rope", _rope];
			};
			
			//Chopper has Cargo in rope?
			if (_hasRopeHook && _hasCargoHook) then
			{
				private ["_class", "_pos", "_dir"];
				_class = ((_properties select 0) select 1) select 0;
				_pos = ((_properties select 0) select 1) select 1;
				_dir = ((_properties select 0) select 1) select 2;
				
				_cargo = _class createVehicleLocal _pos;
				_chopper setVariable ["NEO_rope_cargo", _cargo];
				_cargo setDir _dir;
				_cargo setPosASL _pos;
				
				if (_cargo isKindOf "Man") then
				{
					_cargo switchMove "winch_SaviourDown";
				};
				
				[_cargo, [0,0,((boundingBox _cargo) select 1) select 2]] ropeAttachTo _rope;
				ropeSetCargoMass [_rope, _cargo, 0];
			};
			
			//Chopper has fastrope?
			if (_hasWinchRope) then
			{
				private ["_winch"];
				_winch = if (_chopper isKindOf "Heli_Heavy_Base_H") then { [2.45,1.68,-0.7] } else { [1.32,1.44,-0.72] };

				private ["_fastrope"];
				_fastrope = ropeCreate [_chopper, _winch, 15, 15, true];
				ropeSetCargoMass [_fastrope, objNull, 1];

				_chopper setVariable ["NEO_fastrope", _fastrope];
			};
		};
		
	} forEach NEO_choppers;
};
