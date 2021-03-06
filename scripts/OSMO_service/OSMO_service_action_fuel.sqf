_serviceman = _this select 0;
_osmobot = _this select 1;
_vehicle = _this select 3;

{_serviceman removeAction _x} foreach OSMO_service_actions;

OSMO_service_actions = [];
OSMO_service_fuellist_opened = true;

//insert fuel payment here
	  
	  _fullCost = 0;
	  _thisCost = 0;
	  
switch (true) do 
{ 
		case (_vehicle isKindOf "Heli_Light01_Base_H"):
		{
      //assume 150L tank, 3 a litre so 450 bucks a tank
	  _tankSize = 150;
	  _fuelCostL = 3;
	  _toRefill = 1 - (fuel _vehicle);
	  _fullCost = floor(_tankSize * _fuelCostL);
	  _thisCost = floor(_fullCost * _torefill);
	  
		}; 
		case (_vehicle isKindOf "Heli_Medium01_Base_H"):
		{
      //assume 200L tank, 3 a litre so 600 bucks a tank
	  _tankSize = 200;
	  _fuelCostL = 3;
	  _toRefill = 1 - (fuel _vehicle);
	  _fullCost = floor(_tankSize * _fuelCostL);
	  _thisCost = floor(_fullCost * _torefill);          
		}; 
		case (_vehicle isKindOf "Heli_Heavy_Base_H"):
		{
      //assume 250L tank, 3 a litre so 750 bucks a tank
	  _tankSize = 250;
	  _fuelCostL = 3;
	  _toRefill = 1 - (fuel _vehicle);
	  _fullCost = floor(_tankSize * _fuelCostL);
	  _thisCost = floor(_fullCost * _torefill);    
		}; 						            
  default 
  {
  };
};

hint "Scroll your action menu to select the fuel level.";
_fuel_options = [1,0.75,0.5,0.25];
{
	_option = _thisCost - ((1 - _x)* _fullCost);
  _act = _serviceman addAction [format ["Refuel to %1%2, $%3",(_x*100), "%", _option], "scripts\OSMO_service\OSMO_service_action.sqf", [_vehicle, _x, _option], 6, true, true, "", "isNil {_target getVariable ""OSMO_SV_service_busy""}","",-1, -1, 1, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_refuel_ca' size='1.5' shadow='true' /></t>",format ["Refuel to %1%2",(_x*100), "%"]];
  OSMO_service_actions set [count OSMO_service_actions, _act];
  
} foreach _fuel_options;

_act = _serviceman addAction [format ["Keep Current Level (%1%2)",((fuel _vehicle)*100), "%"], "scripts\OSMO_service\OSMO_service_action.sqf", [_vehicle, (fuel _vehicle), 0], 6, true, true, "", "isNil {_target getVariable ""OSMO_SV_service_busy""}","",-1, -1, 1, 0,"<t align='center'><img image='hsim\ui_h\data\ui_action_refuel_ca' size='1.5' shadow='true' /></t>",format ["Keep Current Level (%1%2)",((fuel _vehicle)*100), "%"]];
OSMO_service_actions set [count OSMO_service_actions, _act];

_act = _serviceman addAction ["Cancel", "scripts\OSMO_service\OSMO_service_action_cancel.sqf", nil, 6, true, true, "", "isNil {_target getVariable ""OSMO_SV_service_busy""}"];
OSMO_service_actions set [count OSMO_service_actions, _act];

_timer = time + 20;
waituntil{((_osmobot distance _serviceman) > 6) || (time > _timer) || !OSMO_service_fuellist_opened};
[_serviceman] execVM "scripts\OSMO_service\OSMO_service_action_cancel.sqf";