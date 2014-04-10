// goods production script

//declare vars as private 
//private ["_owner", "_id", "_producer", "_loadbay", "_industryVars", "_prodValue", "_state"];

//initial values - fixed

//_id = _this select 2; //id of action for removal from menu
_producer = _this select 0; //AI unit variable name of producer
_loadbay = _this select 1; //load bay name

//variable variables taken from unit via _industryVars whenever looped
_industryVars = _producer getVariable "_industryVars";
_produceType = _industryVars  select 2; //type of goods by name - string


// things that will shift from the initial as progress changes
_prodRate = _industryVars select 0; //multiples of production - number
_prodValue = 0;    // iterator - used to determine when to produce a load of goods - produce at 100
_typeCounter = _prodRate;  // track which type to produce - this is a variable index, 0 through 2


//get initial state directly from unit
_state = _producer getVariable "_state";     //used to turn on/off production defaults to 0 on initialise

_possibleType = _industryVars select 1; ; // choice of box to use (small med large)
_useType = _possibleType select _typeCounter;  //<- redundant i think

 
 // initialise loop  ------------------  initialise loop ------------------- initialise loop -------------initialise loop   
 while {true} do {

	sleep 5;
	_state = _producer getVariable "_state";

	//do a production cycle - move prodValue towards 1
	while (_state == 1) do {
		_industryVars = _producer getVariable "_industryVars";
		_typeCounter = _prodRate;  // track which type to produce - this is a variable index, 0 through 1
		_useType = _possibleType select _typeCounter;
		_owner = _producer getVariable "_owner"; // person who called the start command
		//cycle takes 5min
		sleep 300;
			
		// creation
		_veh = createVehicle[_useType, getMarkerPos _loadbay,[], 0,"NONE"];
		_veh setVariable ["_goodsInfo", [_baseValue, _producer, _produceType], false];
		_producer globalchat format ["Loading %1 of %2 for %3", _useType, _produceType, _owner];	//tell me whats going on
	};

// end loop -----------end loop -----------end loop -----------end loop -----------end loop -----------end loop -----------end loop -----------
 };