
// Remove entry from table
TOT_fnc_tableRemove = 
{
private ["_item", "_table"];
_item = _this select 0;
_table = _this select 1;
if (count _table > 0) then{
					{
					if (_x find _item > -1) then {
															//when found..
															_table = [_table, _forEachIndex] call BIS_fnc_removeIndex;
														};
					} forEach _table;

};