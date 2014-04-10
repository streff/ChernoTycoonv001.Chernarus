_stopped = 1;
_x = _farmer addAction ["Start Production", "scripts\tot\startProduction.sqf", [_farmer, _loadbay, _deliverbay, _boxType, _prodRate]];}"]; //add stop item to menu, when used make _stopped equal 1 and remove the stop action
_stopped