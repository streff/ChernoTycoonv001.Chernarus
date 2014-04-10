//Add other objects Classes here - To make those slingload aware
private ["_pickable_object_classes"];
_pickable_object_classes = ["Barrels_H", 
"Land_Barrel_Sand_H", 
"Man", 
"LandVehicle", 
"Land_Misc_Cargo1E_EP1",
"Misc_cargo_cont_small_EP1",
"Misc_cargo_cont_net1",
"Misc_cargo_cont_net2",
"Misc_cargo_cont_net3",
"Misc_cargo_cont_small",
"Misc_cargo_cont_small2",
"Misc_cargo_cont_tiny",
"CargoCont_Net1_H",
"Fort_Crate_wood"

];

private ["_action", "_unit", "_chopper"];
_action = _this select 3;
_unit = _this select 1;
_chopper = _this select 0;

private ["_properties", "_hasRopeHook", "_hasCargoHook", "_hasWinchRope", "_hasPipMain", "_hasPipSecondary"];
_properties = _chopper getVariable "NEO_chopperProperties";
_hasRopeHook = (_properties select 0) select 0;
_hasCargoHook = count ((_properties select 0) select 1) > 0;
_hasWinchRope = _properties select 1;
_hasPipMain = (_properties select 2) select 0;
_hasPipSecondary = (_properties select 2) select 1;

switch (_action) do
{
	case "create" :
	{
		_chopper setVariable ["NEO_chopperProperties", [[true, []], _hasWinchRope, [_hasPipMain, _hasPipSecondary]], true];
		[_chopper, "NEO_fnc_ropeCreate"] call BIS_fnc_mp;
		hint "Hook Rope deployed...";
	};
	
	case "destroy" :
	{
		_chopper setVariable ["NEO_chopperProperties", [[false, []], _hasWinchRope, [_hasPipMain, _hasPipSecondary]], true];
		[_chopper, "NEO_fnc_ropeDestroy"] call BIS_fnc_mp;
		hint "Hook Rope pulled...";
	};
	
	case "attach" :
	{
		private ["_cargo_objects", "_cargo"];
		_cargo_objects = nearestObjects [_chopper, _pickable_object_classes, 35];
		_cargo = objNull;
		
		private ["_total_objects"];
		_total_objects = [];
		
		{
			if ((!(_x isKindOf "Man") || !isPlayer _x) && _x != vehicle player) then  
			{
				_total_objects set [count _total_objects, _x];
			};
		} forEach _cargo_objects;
		
		if (count _cargo_objects > 0) then
		{
			_cargo = _cargo_objects select 0;
			
			//Height difference between chpper and object
			private ["_chopper_height", "_cargo_height", "_height_difference"];
			_chopper_height = (getPosASL _chopper) select 2;
			_cargo_height = (getPosASL _cargo) select 2;
			_height_difference = _chopper_height - _cargo_height;
			
			//Acceptable height difference?
			if (_height_difference < 14) then
			{
				//Aceptable 2D distance?
				private ["_3d_distance", "_2d_distance"];
				_3d_distance = _chopper distance _cargo;
				_2d_distance = _3d_distance - _height_difference;
				
				if (_2d_distance < 3) then
				{
					//pickup objects - store any variables they have - either goodsinfo or R3F_LOG_objets_charges - initialise as zero, overwrite if anything is there, test for zero on drop
					/*
					_goodsInfo = 0;
					_r3f_logCargo = 0;
					if ( !isNil{_cargo getVariable "_goodsInfo"}) then {
						_goodsInfo = _cargo getVariable "_goodsInfo";
					};
					if ( !isNil{_cargo getVariable "R3F_LOG_objets_charges"}) then {
						_r3f_logCargo = _cargo getVariable "R3F_LOG_objets_charges";
					};
					*/
					
					//_chopper setVariable ["NEO_chopperProperties", [[true, [typeOf _cargo, getPosASL _cargo, getDir _cargo, side _cargo, _goodsInfo, _r3f_logCargo]], _hasWinchRope, [_hasPipMain, _hasPipSecondary]], true];
					_chopper setVariable ["NEO_chopperProperties", [[true, [typeOf _cargo, getPosASL _cargo, getDir _cargo, side _cargo, _cargo]], _hasWinchRope, [_hasPipMain, _hasPipSecondary]], true];
					[_chopper, "NEO_fnc_ropeAttach"] call BIS_fnc_mp;
					//deleteVehicle _cargo;
					
					//move to debug area - 10 10 10 at the moment, no idea where it is
					_cargo setPos [10,10,10];
					hint "Cargo successfully attached...";
				}
				else
				{
					hint "You are too far from cargo to attach...";
				};
			}
			else
			{
				hint "You are too high to attach cargo...";
			};
		}
		else
		{
			hint "No cargo object near to attach...";
		};
	};
	
	case "detach" :
	{
		[[_chopper, ((_chopper getVariable "NEO_chopperProperties") select 0) select 1], "NEO_fnc_ropeDetach"] call BIS_fnc_mp;
		_chopper setVariable ["NEO_chopperProperties", [[true, []], _hasWinchRope, [_hasPipMain, _hasPipSecondary]], true];
		hint "Cargo detached...";
	};
	
	case "create_fastrope" :
	{
		_chopper setVariable ["NEO_chopperProperties", [[_hasRopeHook, (_properties select 0) select 1], true, [_hasPipMain, _hasPipSecondary]], true];
		
		private ["_door"];
		_door = if (_chopper isKindOf "Heli_Heavy_Base_H") then { "door_back_R" } else { "DoorR3_Open" };
		_chopper animateDoor [_door, 1];
		waitUntil { _chopper animationPhase _door == 1 };
		if (_chopper isKindOf "Heli_Heavy_Base_H") then
		{
			_chopper animate ["Winch_LowerPole", 1];
			_chopper animate ["Winch_UpperPole", 1];
			waitUntil { _chopper animationPhase "Winch_LowerPole" == 1 && _chopper animationPhase "Winch_UpperPole" == 1 };
			_chopper animate ["Winch_Hook", 1];
			waitUntil { _chopper animationPhase "Winch_Hook" == 1 };
		};
		
		[_chopper, "NEO_fnc_fastropeCreate"] call BIS_fnc_mp;
		hint "Winch Rope deployed...";
	};
	
	case "destroy_fastrope" :
	{
		_chopper setVariable ["NEO_chopperProperties", [[_hasRopeHook, (_properties select 0) select 1], false, [_hasPipMain, _hasPipSecondary]], true];
		[_chopper, "NEO_fnc_fastropeDestroy"] call BIS_fnc_mp;
		hint "Winch Rope pulled...";
		
		private ["_door"];
		_door = if (_chopper isKindOf "Heli_Heavy_Base_H") then { "door_back_R" } else { "DoorR3_Open" };
		_chopper animateDoor [_door, 0];
		if (_chopper isKindOf "Heli_Heavy_Base_H") then
		{
			_chopper animate ["Winch_Hook", 0];
			waitUntil { _chopper animationPhase "Winch_Hook" == 0 };
			_chopper animate ["Winch_LowerPole", 0];
			_chopper animate ["Winch_UpperPole", 0];
		};
	};
	
	case "fastrope" :
	{
		[_chopper, player, _chopper getVariable "NEO_fastrope"] spawn NEO_fnc_fastrope;
	};
	
	case "pipOn" :
	{
		_chopper setVariable ["NEO_chopperProperties", [[_hasRopeHook, (_properties select 0) select 1], _hasWinchRope, [true, _hasPipSecondary]], true];
		
		//Run only on chopper crew players machines
		{
			if (isPlayer _x) then
			{
				[[_chopper, 0], "NEO_fnc_pipOn", _x] call BIS_fnc_mp;
			};
		} forEach crew _chopper;
	};
	
	case "pipOff" :
	{
		_chopper setVariable ["NEO_chopperProperties", [[_hasRopeHook, (_properties select 0) select 1], _hasWinchRope, [false, _hasPipSecondary]], true];
		
		//Run only on chopper crew players machines
		{
			if (isPlayer _x) then
			{
				[[_chopper, 0], "NEO_fnc_pipOff", _x] call BIS_fnc_mp;
			};
		} forEach crew _chopper;
	};
	
	case "pipOnSecondary" :
	{
		_chopper setVariable ["NEO_chopperProperties", [[_hasRopeHook, (_properties select 0) select 1], _hasWinchRope, [_hasPipMain, true]], true];
		
		//Run only on chopper crew players machines
		{
			if (isPlayer _x) then
			{
				[[_chopper, 1], "NEO_fnc_pipOn", _x] call BIS_fnc_mp;
			};
		} forEach crew _chopper;
	};
	
	case "pipOffSecondary" :
	{
		_chopper setVariable ["NEO_chopperProperties", [[_hasRopeHook, (_properties select 0) select 1], _hasWinchRope, [_hasPipMain, false]], true];
		
		//Run only on chopper crew players machines
		{
			if (isPlayer _x) then
			{
				[[_chopper, 1], "NEO_fnc_pipOff", _x] call BIS_fnc_mp;
			};
		} forEach crew _chopper;
	};
};
