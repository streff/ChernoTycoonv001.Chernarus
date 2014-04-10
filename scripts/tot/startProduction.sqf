// goods production script -- transactional version - player to purchase goods for resale

//initial values - fixed
_producer = _this select 0; //AI unit variable name of producer
//_loadbay = _this select 1; //load bay name
_boxType = _this select 2;  // choice of box to use (small med large)

//variable variables taken from global industryVars whenever looped - declared here so they exist outside of the loop, populated with initial values
_industryVars = missionNamespace getVariable "TOT_" + str(_producer) + "_industryVars";

_prodRate = _industryVars select 0; //multiples of production - number
_priceOut = _industryVars  select 1; //unit price prices set in setup script
_priceIn = _industryVars  select 2;    //unit price of prices set in setup script
_produceType = _industryVars  select 3;  // name of goods - array
_available = _industryVars  select 4;  // number of goods available -  scarcity affects price
_maxAvailable = _industryVars  select 5;  // max number of goods available -  vendor storage space
_materials = _industryVars select 6; // mats available to produce from
_state = _industryVars select 7; //initial state
_loadbay = _industryVars select 8; //loadbay - goods outbound
_deliverbay = _industryVars select 9; //delivery bay - goods inbound
_acceptsGoods = _industryVars select 10; //goods accepted

//store prices as base prices to be referenced when adjusting for market forces - out is outbound or sales to the player, in is inbound or purchases by the vendor
//pass the outbound one to the create script as well so it can keep track in the same way
_basePriceOut = _priceOut;
_basePriceIn = _priceIn;

//set price per size
_sprice = _priceOut * 5;
_mprice = _priceOut * 50;
_lprice = _priceOut * 100;


//sleep for a bit
sleep random 3;

//production iteration counter
_prodIterator = 0;

//production loop
 // initialise loop  ------------------  initialise loop ------------------- initialise loop -------------initialise loop   
 while {true} do {
 
[[_producer], "TOT_fnc_MPRemoveaction",false, true] call BIS_fnc_MP; 
 
 
//set prices for current stock levels ----  run once to initialise prices then script loops production  --------------------------------------------------------------
_newPrice = _basePriceOut;

						//change current item price to reflect getting scarce - calculate based on available and maxAvailable values since they are made of capacity numbers
						//get the percentage of max currently available
						_percentStock = _available / _maxAvailable;
						//_producer globalchat format[" _percentStock: %1 ", _percentStock];

						if (_percentStock < 0.8) then
						{
							if (_percentStock < 0.5) then
							{
								if(_percentStock < 0.2) then      
								{
								
									_newPrice = floor(_newPrice * 1.15);
									
								}
								else
								{
									_newPrice = floor(_newPrice * 1.07);
									
								};
								
							}
							else 
							{
									_newPrice = floor(_newPrice * 1.03);
									
							};
						
						};
						//end price manipulation with base price at full stock
						//_producer globalchat format[" _newPrice: %1 ", _newPrice];
						
						//overwrite pricesOut with new stuff
						_priceOut = _newPrice;
						//_producer setVariable ["_industryVars", [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials]];
						_initVars = format ["TOT_" + str _producer + "_industryVars", _industryVars];
						_industryVars = [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials, _state, _loadbay, _deliverbay, _acceptsGoods];
						missionNamespace setVariable [_initVars, _industryVars];
						publicVariable _initVars;
						
						//_producer globalchat format[" _priceOut: %1 ", _priceOut];
						
						//set price per size
						_sprice = _priceOut * 5;
						_mprice = _priceOut * 50;
						_lprice = _priceOut * 100;

						
						//add interaction with producer to create goods / perform sale with new prices - single player version
				
						[[_producer, "scripts\tot\startDelivery.sqf", "Deliver Goods", [_producer, _deliverbay, _acceptsType, _acceptsGoods]], "TOT_fnc_MPAddactionParam", nil, true, true] spawn BIS_fnc_MP;
						[[_producer, "scripts\tot\createGoods.sqf", format["Buy %1 Crate - $%2", _produceType, _sprice], [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 0]], "TOT_fnc_MPAddactionParam", nil, true, true] spawn BIS_fnc_MP;
						[[_producer, "scripts\tot\createGoods.sqf", format["Buy %1 Pallet - $%2", _produceType, _mprice], [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 1]], "TOT_fnc_MPAddactionParam", nil, true, true] spawn BIS_fnc_MP;
						[[_producer, "scripts\tot\createGoods.sqf", format["Buy %1 Container - $%2", _produceType, _lprice], [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 2]], "TOT_fnc_MPAddactionParam", nil, true, true] spawn BIS_fnc_MP;
						[[_producer, "scripts\tot\tellStock.sqf", "Current Stock"], "TOT_fnc_MPAddactionNoParam", nil, true, true] spawn BIS_fnc_MP;


 //_producer globalchat format["%1 sleeping", _producer];
 sleep 300 + random 10;	// ready, steady.. sleep for ~300 seconds.  One 'production cycle'. Can cycle empty, so they are not constantly checking for goods to aid server performance
 
 //Re-read all the industryVars to get current situation
_industryVars = missionNamespace getVariable "TOT_" + str(_producer) + "_industryVars";
_prodRate = _industryVars select 0; //multiples of production - number
_priceOut = _industryVars  select 1; //unit price prices set in setup script
_priceIn = _industryVars  select 2;    //unit price of prices set in setup script
_produceType = _industryVars  select 3;  // name of goods - array
_available = _industryVars  select 4;  // number of goods available -  scarcity affects price
_maxAvailable = _industryVars  select 5;  // max number of goods available -  vendor storage space
_materials = _industryVars select 6; // mats available to produce from
_state = _industryVars select 7; //initial state
_loadbay = _industryVars select 8; //loadbay - goods outbound
_deliverbay = _industryVars select 9; //delivery bay - goods inbound
_acceptsGoods = _industryVars select 10; //goods accepted

if (_materials >= 50) then {
	//_producer globalchat format["%1 mats ok", _materials];

		//make sure there is space for a new good to be produced
		if (_available < _maxAvailable) then {
		//_producer globalchat format["%1 space ok", _available];
			
			//go make stuff
			//Re-read all the industryVars to get current situation
				
					_materials = _materials - 50;
					_initVars = format ["TOT_" + str _producer + "_industryVars", _industryVars];
					_industryVars = [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials, _state, _loadbay, _deliverbay, _acceptsGoods];
					missionNamespace setVariable [_initVars, _industryVars];
					publicVariable _initVars;
					_prodIterator = _prodIterator + (10 * _prodRate);
			
			//enough stuff made - ready to add to 'available' and reset iterator to 0
					if (_prodIterator > 100) then {
					_producer globalchat format["New Goods Available - %1", _producer];
					_available = _available + 350;
					_prodIterator = _prodIterator - 100;			//keep overflow production for next run - dont zero the proditerator
					
				};
			
			
		} else {
		//backlogged, so sleep for xxxlongtimexxx minutes - it's gonna take a while for someone to clear full stock, and I dont want to risk server load problems with lots of these guys doing looped checks.. 
		// set short for testing tho, but needs balance tested at normal gameplay speeds. 
		sleep 300 + random 30;
		};

 } else {
 // no materials available, check if it's a primary (keeps producing anyway but at a reduced rate)
	if (_state == 1) then {
//_producer globalchat format["%1 _initialState for %2", _initialState, _producer];
		
		//make sure there is space for a new good to be produced
		if (_available < _maxAvailable) then {
		//_producer globalchat format["%1 space ok", _available];
			//go make stuff
			
			sleep 10;
			_prodIterator = _prodIterator + (10 * _prodRate);
		//_producer globalchat format["%1 iterator", _prodIterator];
			//ready to add 1 to 'available' and reset iterator to 0
			if (_prodIterator > 100) then {
					_producer globalchat format["New Goods Available - %1", _producer];
					_available = _available + 100;
					_prodIterator = _prodIterator - 100;			//keep overflow production for next run - dont zero the proditerator
					
	//Re-read all the industryVars to get current situation

					_initVars = format ["TOT_" + str _producer + "_industryVars", _industryVars];
					_industryVars = [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials, _state, _loadbay, _deliverbay, _acceptsGoods];
					missionNamespace setVariable [_initVars, _industryVars];
					publicVariable _initVars;
				};
			
			
		} else {
		//backlogged, so sleep for xxxlongtimexxx minutes - it's gonna take a while for someone to clear full stock, and I dont want to risk server load problems with lots of these guys doing looped checks.. 
		// set short for testing tho, but needs balance tested at normal gameplay speeds. 
		sleep 300 + random 20;
		};    //THIS BIT SHOULD BE A STRAIGHT COPY OF THE ONE ABOVE FROM THE COMMENT ABOUT 'MAKING SURE THERE IS SPACE' TO THIS LINE - CURRENTLY 56 TO 83 SHOULD MIRROR 92 TO 119

	} else {
	// secondary industries with no mats sleep this long
	sleep 10;
	};
}; //end first 'if' - materials level check


// end loop -----------end loop -----------end loop -----------end loop -----------end loop -----------end loop -----------end loop --------
};