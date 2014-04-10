_box = _this select 0;   //the box to be read (also the object the addaction is attached to)
_reader = _this select 1;   //player doing the reading
_info = _box getVariable "_goodsInfo";
_producer = _info select 0;
_produceType = _info select 1;
_owner = _info select 2;
_capacity = _info select 3;

_reader globalchat format["Product: %1 %2 Produced At: %3 Owner: %4", _capacity, _produceType, _producer, _owner];

