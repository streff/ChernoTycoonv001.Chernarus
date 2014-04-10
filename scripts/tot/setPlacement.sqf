_obj = _this select 0;
_index = _this select 1;
_building = nearestBuilding _obj;
_obj setPos (_building buildingPos _index);