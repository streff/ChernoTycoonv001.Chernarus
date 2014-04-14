//Goods Creation


 //Re-read all the industryVars to get current situation 
_producer = _this select 0;
//_industryVars = _producer getVariable "_industryVars";
_industryVars = missionNamespace getVariable "TOT_" + str(_producer) + "_industryVars";

_initiator = _this select 1;
_employer = name leader _initiator;
_id = _this select 2;
_boxType = _this select 3 select 0;
_loadbay = _this select 3 select 1;
_priceOut = _this select 3 select 2;

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

_owner = _employer;
_boxSize = _this select 3 select 5;
_useType = _boxType select _boxSize;

//define capacity of created goods
_capacityList = [5, 50, 100];
_capacity = _capacityList select _boxSize;

_price = (_priceOut * _capacity);

//_producer globalchat format[" cg _industryVars: %1 ", _industryVars];

_bayPos = getMarkerPos _loadbay;

//original prices as passed by the production script
_basePriceOut = _this select 3 select 4; //passed as integer for single unit of goods

_newPrice = _basePriceOut;
//_producer globalchat format[" cg baseprice: %1 ", _basePriceOut];


[[_producer], "TOT_fnc_MPRemoveaction",false, true] call BIS_fnc_MP; 


if (_capacity <= _available) then {


			//Check if they can afford it
			if (call compile format["TOT_%1_cashBalance >= _price", _employer]) then {

			
										
						// creation & write stuff to boxes
						_veh = createVehicle[_useType, _bayPos,[], 0,"NONE"];
						//leave in for future expansion - ability to produce and recieve more than one kind of goods - has to be a string for delivery comparison though
						_produceSubType = _produceType select 0;
						_goodsInfo = [_producer, _produceSubType, _owner, _capacity];
						_veh setVariable ["_goodsInfo", _goodsInfo, true];
						
						//add addaction for player to be able to read box tags
						_veh addAction["Read Shipping Label", "scripts\tot\readBoxes.sqf"];
						
						
						//add addaction designate pickup
						_veh addAction["Designate for Pickup", "scripts\tot\ai\designatePickup.sqf"];
						
						//db entry - create data
						_pos = getPos _veh;
						_dir = getDir _veh;
						_xvehData = [_useType, _pos, _dir, _goodsInfo];
						[TOT_goodsData, [_veh, _xvehData]] call BIS_fnc_arrayPush;
						publicVariable "TOT_vehicleData";
						
						
						//_producer globalchat format ["Loading %1 of %2 for %3", _useType, _produceType, _owner];	//tell me whats going on
					
						//subtract cash
						call compile format["TOT_%1_cashBalance = TOT_%1_cashBalance - _price", _employer];
						call compile format["publicVariable 'TOT_%1_cashBalance';", _employer];
						
						//subtract available stock
						_available = _available - _capacity;
						
						//change current item price to reflect getting scarce - calculate based on available and maxAvailable values since they are made of capacity numbers
						//todo: make this a function so it only appears once and not here and also in startproduction.sqf
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
						//_producer globalchat format[" _newPrices: %1 ", _newPrice];
						
						//overwrite pricesOut with new stuff
						_priceOut = _newPrice;
						_initVars = format ["TOT_" + str _producer + "_industryVars", _industryVars];
						_industryVars = [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials, _state, _loadbay, _deliverbay, _acceptsGoods];
						missionNamespace setVariable [_initVars, _industryVars];
						publicVariable _initVars;
						
													
			} else {
					_producer globalchat "You do not have enough money.";
			};  //end money check
	
} else {
						
_producer globalchat "I can't fill that. Try something smaller.";
						
};

//set price per size
_sprice = _priceOut * 5;
_mprice = _priceOut * 50;
_lprice = _priceOut * 100;

//add interaction with producer to create goods / perform sale with new prices - single player version

	//_producer addAction[format["Buy %1 Crate - $%2", _produceType, _sprice], "scripts\tot\createGoods.sqf", [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 0]];
	//_producer addAction[format["Buy %1 Pallet - $%2", _produceType, _mprice], "scripts\tot\createGoods.sqf", [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 1]];
	//_producer addAction[format["Buy %1 Container - $%2", _produceType, _lprice], "scripts\tot\createGoods.sqf", [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 2]];
	//_producer addAction["Current Stock", "scripts\tot\tellStock.sqf"];
						
	
	[[_producer, "scripts\tot\startDelivery.sqf", "Deliver Goods", [_producer]], "TOT_fnc_MPAddactionParam", nil, false, true] call BIS_fnc_MP;
sleep 0.5;	
	[[_producer, "scripts\tot\createGoods.sqf", format["Buy %1 Crate - $%2", _produceType, _sprice], [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 0]], "TOT_fnc_MPAddactionParam", nil, false, true] call BIS_fnc_MP;
sleep 0.5;
	[[_producer, "scripts\tot\createGoods.sqf", format["Buy %1 Pallet - $%2", _produceType, _mprice], [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 1]], "TOT_fnc_MPAddactionParam", nil, false, true] call BIS_fnc_MP;
sleep 0.5;	
	[[_producer, "scripts\tot\createGoods.sqf", format["Buy %1 Container - $%2", _produceType, _lprice], [_boxType, _loadbay, _priceOut, _producer, _basePriceOut, 2]], "TOT_fnc_MPAddactionParam", nil, false, true] call BIS_fnc_MP;
sleep 0.5;
	[[_producer, "scripts\tot\tellStock.sqf", "Current Stock"], "TOT_fnc_MPAddactionNoParam", nil, false, true] call BIS_fnc_MP;


	
	
	