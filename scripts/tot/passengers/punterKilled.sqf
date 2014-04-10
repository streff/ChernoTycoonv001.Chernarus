_punter = _this select 0;
_startTown = _punter getVariable "_startTown";	
	_faresLabel = format ['TOT_' + str _startTown + '_Fares'];
	_fares = missionNamespace getVariable _faresLabel;
	_fares1 = _fares;
	_fares = _fares - 1;
	//hint format["punter killed1 - %1 %2 \n%3", _fares1, _fares, _startTown];
	missionNamespace setVariable [_faresLabel, _fares];
	publicVariable _faresLabel;