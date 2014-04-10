//carry out transaction

//define passed variables

_vehicle  = _this select 3 select 0;
_price = _this select 3 select 1;
_spawnloc = _this select 3 select 2;
_passedInit = _this select 3 select 3;

_vendor = _this select 0;
_initiator = _this select 1;
_employer = name leader _initiator;
_owner = _employer;

_vendor globalChat format["%1 %2", _initiator, _employer];

// check if buyer can afford it

_vendor globalChat format["That will be %1", _price];

if (call compile format["TOT_%1_cashBalance >= _price", _employer]) then {


_spawnLoc = format["%1_spawn", _vendor];

_xveh = _vehicle createVehicle (getMarkerPos _spawnLoc);


_stockInit = format["this setVariable['_owner','%1']; this execVM 'scripts\tot\vehicles\vehicleLock.sqf';", _owner];

_fullInit = format["%1 %2", _stockInit, _passedInit];
_xveh setVehicleInit _fullInit;
processInitCommands;

//get data for recording sale in db
_fuel = fuel _xveh;
_pos = getPos _xveh;
_dir = getDir _xveh;
_xvehData = [_vehicle, "", _fuel, _pos, _dir, _owner];
_vehNumber = count TOT_vehicleData;
_varName = format["Vehicle_%1", _vehNumber];
_xveh setVehicleVarName _varName;
_xveh Call Compile Format ["%1=_this ; PublicVariable ""%1""", _varName];

[TOT_vehicleData, [_varName, _xvehData]] call BIS_fnc_arrayPush;
publicVariable "TOT_vehicleData";

_vendor globalChat "Thank You.";

//subtract cash
	
		call compile format["TOT_%1_cashBalance = TOT_%1_cashBalance - _price", _employer];
		call compile format["publicVariable 'TOT_%1_cashBalance';", _employer];

} else {

_vendor globalChat "You can't afford this.";

};