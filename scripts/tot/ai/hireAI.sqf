// create ai to join players group

_recruiter = _this select 0;
_initiator = _this select 1;
_employer = name leader _initiator;
_price = 2000;

if (call compile format["TOT_%1_cashBalance >= _price", _employer]) then {
//subtract cash for pilot - months wage in escrow
call compile format["TOT_%1_cashBalance = TOT_%1_cashBalance - _price", _employer];
call compile format["publicVariable 'TOT_%1_cashBalance';", _employer];

_unit = "Pilot_Random_H" createUnit [position player, group player];
_unit setVariable["_employer", name player];

} else {
_recruiter globalChat "You do not have enough cash.";
};