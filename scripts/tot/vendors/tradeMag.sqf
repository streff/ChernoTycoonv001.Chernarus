//carry out transaction

//define passed variables

_initiator = _this select 1;
_employer = name leader _initiator;
_item  = _this select 3 select 0;
_price = _this select 3 select 1;
_spawnloc = _this select 3 select 2;


_vendor = _this select 0;


// check if buyer can afford it

_vendor globalChat format["That will be %1", _price];

if (call compile format["TOT_%1_cashBalance >= _price", _employer]) then {



_spawnloc addMagazineCargoGlobal[_item, 1];
_vendor globalChat "Thank You.";
//subtract cash
	
		call compile format["TOT_%1_cashBalance = TOT_%1_cashBalance - _price", _employer];
		call compile format["publicVariable 'TOT_%1_cashBalance';", _employer];

} else {

_vendor globalChat "You can't afford this.";

};