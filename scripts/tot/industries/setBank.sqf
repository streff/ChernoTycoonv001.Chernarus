//set unit as bank


_banker = _this select 0;

//mp version
[[_banker, "scripts\tot\showBank.sqf", "Show Balance"], "TOT_fnc_MPAddactionNoParam",false] call BIS_fnc_MP;
