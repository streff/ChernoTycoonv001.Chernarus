// pay OSMO - addition for TOT by streff

_id = _this select 2;
_initiator = _this select 3 select 0;
_serviceman = _this select 3 select 1;
_price = _this select 3 select 2;
_employer = name (leader _initiator);



	if (call compile format["TOT_%1_cashBalance >= _price", _employer]) then {
	
		call compile format["TOT_%1_cashBalance = TOT_%1_cashBalance - _price", _employer];
		call compile format["publicVariable 'TOT_%1_cashBalance';", _employer];
		//response
		_serviceman globalchat format["Thanks, received $%1.", _price];
		// set global variable
		call compile format["TOT_%1_payOsmo = 1;", _employer];
		call compile format["publicVariable 'TOT_%1_payOsmo'", _employer];


	} else {
		//no money
		_serviceman globalchat format["Sorry, you do not have enough money."];
	
	};
	

player removeAction _id;