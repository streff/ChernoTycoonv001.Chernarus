//airfield lights

_lampPostList = [lightsBalota_1, lightsBalota_2];


{
_post = _x;
_lightsource = position _post nearestObject 161790;
_lightsource switchLight "ON";
} forEach _lampPostList;