//initialise what bay and what type

_initiator = _this select 1;
_employer = name leader _initiator;
_reciever = _this select 0;


//prices from unit's "industryVars" to keep up to date before each inbound good is processed
_industryVars = missionNamespace getVariable "TOT_" + str _reciever + "_industryVars";
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
_newPrice = _priceIn;	
_baypos = getMarkerPos _deliverbay;


	//put all acceptable objects within 5m of the bay in an array
	_goodsInbound = nearestObjects[_baypos, ["All"], 5];
	

	// start of "if goodsInbound is empty then skip this bit"
	_go = count _goodsInbound;
	//_reciever globalchat format["GO: %1 ", _go];
	if (_go > 0) then {
	

	
	//start of 'foreach' bit - this bracket is intentional
	{
	
	//read data from goods to be delivered - unit in this context means unit of goods.   Yes, I'm not consistent. I'm working on it. 
	_unitInfo = _x getVariable "_goodsInfo";
	_unitProducedBy = _unitInfo select 0;
	_goodsType = _unitInfo select 1;
	_owner = _unitInfo select 2;
	_capacity = _unitInfo select 3;

//prices from unit's "industryVars" to keep up to date before each inbound good is processed
_industryVars = missionNamespace getVariable "TOT_" + str _reciever + "_industryVars";
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



	//calculations
		if (_unitProducedBy != _reciever) then {									//same producer check

			if (_goodsType in _acceptsGoods) then {								//goodstype check
				
				//add mats to industry
				_materials = _materials + _capacity;
				//_reciever globalchat format["_materials: %1 ", _materials];
				
							
				
				_boxType = typeOf _x;
				_value = _priceIn * _capacity;
				//_reciever globalchat format["boxType: %1 ", _boxType];
				//_reciever globalchat format["pricesIn: %1 ", _pricesIn];
				
				//add cash
				call compile format["TOT_%1_cashBalance = TOT_%1_cashBalance + _value", _employer];
				call compile format["publicVariable 'TOT_%1_cashBalance';", _employer];       
				
				//change current item price to reflect getting scarce or plentiful - calculate based on available and maxAvailable values since they are made of capacity numbers
						//todo: make this a function so it only appears once and not here and also in startproduction.sqf
						//get the percentage of max currently available
						_percentStock = _materials / _maxAvailable;
						//_producer globalchat format[" _percentStock: %1 ", _percentStock];
						
						if (_percentStock > 0.2) then
						{
							if (_percentStock > 0.5) then
							{
								if(_percentStock > 0.8) then      
								{
									_newPrice = floor(_newPrice * 0.85);
								}
								else
								{
									_newPrice = floor(_newPrice * 0.93);
								
								
								};
								
							}
							else 
							{
									_newPrice = floor(_newPrice * 0.98);
							};
						
						};
						//end price manipulation with base price at full stock
						//_producer globalchat format[" _newPrices: %1 ", _newPrice];
						
						//overwrite pricesOut with new stuff
						_priceIn = _newPrice;
						_initVars = format ["TOT_" + str _reciever + "_industryVars", _industryVars];
						_industryVars = [_prodRate, _priceOut, _priceIn, _produceType, _available, _maxAvailable, _materials, _state, _loadbay, _deliverbay, _acceptsGoods];
						missionNamespace setVariable [_initVars, _industryVars];
						publicVariable _initVars;
						
				
				_reciever globalchat format["Paid %1", _value];
				deleteVehicle _x;

				[_x, TOT_goodsData] call TOT_fnc_tableRemove;
					

			} else {_reciever globalchat "I don't take those goods."}; //end of acceptsType check
			
		} else {_reciever globalchat "I don't take my own goods."}; //end of 'same producer' check
		
	} forEach _goodsInbound;
		
	}; // end of "if goodsInbound is empty"
	

