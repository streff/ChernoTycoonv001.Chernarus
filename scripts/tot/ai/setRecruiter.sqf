
private ["_recruiter"];
_recruiter = _this select 0;

_recruiter addAction["Hire Driver / Pilot", "scripts\tot\ai\hireAI.sqf"];
//[[_recruiter, "scripts\tot\ai\hireAI.sqf", "Hire Driver / Pilot"], "TOT_fnc_MPAddactionNoParam",nil, false, true] call BIS_fnc_MP;