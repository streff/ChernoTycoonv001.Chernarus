//show Bank

_user = player;
_userName = name _user;

_cash = 0;
_bank = 0;


call compile format["_cash = TOT_%1_cashBalance;", _userName];
call compile format["_bank = TOT_%1_bankBalance;", _userName];

hint format["%1 \nCash Balance: %2 \nBank Balance: %3", _userName, _cash, _bank];