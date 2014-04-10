// TOT - take on tycoon (better name pending)
// Makes use of:
// Osmo's Interaction & Service scripts:
// http://forums.bistudio.com/showthread.php?133036-Helicopter-Interaction
// http://forums.bistudio.com/showthread.php?133068-Helicopter-Service
// NEO's ToH Multiplayer Slingload - http://forums.bistudio.com/showthread.php?132909-Multiplayer-Slingload
// Kronzky's Urban Patrol script - http://kronzky.info/ups/
// [R3F] Arty & Logistics (Arty bit turned off) - http://www.armaholic.com/page.php?id=9285
/////////////////////////////////////////////////////////////////////////////////////
//define persistence databases
TOT_playerData = [];
TOT_vehicleData = [];
TOT_objectData = [];
TOT_industryData = [];


//add osmos interactions
//_choppers = allMissionObjects "Air";
//{ _x execVM "scripts\OSMO_interaction\OSMO_interaction_init.sqf" } forEach _choppers;

//add _neo_ multiplayer slingload
//(allMissionObjects "Air") execVM "scripts\NEO_slingload\sl_init.sqf";


//add osmos servicing at Balota airfield
[Helipad_Service_Balota, "Marker_Service_Balota"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";

//add osmos servicing at NW airfield
[Helipad_Service_NW_0, "Marker_Service_NW_0"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";
[Helipad_Service_NW_1, "Marker_Service_NW_1"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";
[Helipad_Service_NW_2, "Marker_Service_NW_2"] execVM "scripts\OSMO_service\OSMO_service_init.sqf";


// add arty and logistics scripts - arty is off
execVM "R3F_ARTY_AND_LOG\init.sqf";

//player setup - client script

if (!isDedicated) then {
execVM "scripts\tot\initTycoon.sqf";




//Tycoon - Vendors - run locally for each client

//goods vendors
//basic items
//crates bags and furniture
[itemVendorZelenogorsk, 1] execVM "scripts\tot\vendors\itemVendor.sqf";
[itemVendorVysota, 2] execVM "scripts\tot\vendors\itemVendor.sqf";
[itemVendorCherno, 3] execVM "scripts\tot\vendors\itemVendor.sqf";



//weapon vendors
// low end weapons
[weaponVendor1, weaponVendor1_spawn,1] execVM "scripts\tot\vendors\weaponVendor.sqf";

//high end weapons
[weaponVendor2, weaponVendor2_spawn,2] execVM "scripts\tot\vendors\weaponVendor.sqf";

//ammo vendors
// low end ammo
[ammoVendor1, ammoVendor1_spawn,1] execVM "scripts\tot\vendors\ammoVendor.sqf";

//high end ammo
[ammoVendor2, ammoVendor2_spawn,2] execVM "scripts\tot\vendors\ammoVendor.sqf";


// Vehicle Vendors - road
[roadVendor1,1] execVM "scripts\tot\vendors\roadVendor.sqf";

[roadVendor2,2] execVM "scripts\tot\vendors\roadVendor.sqf";


// Vehicle Vendors - air
[balotaHeli1,1] execVM "scripts\tot\vendors\airVendor.sqf";
[balotaHeli2,3] execVM "scripts\tot\vendors\airVendor.sqf";

[balotaPlane1,1] execVM "scripts\tot\vendors\planeVendor.sqf";

[heliVendorNW1,3] execVM "scripts\tot\vendors\airVendor.sqf";
[heliVendorNW2,4] execVM "scripts\tot\vendors\airVendor.sqf";


// Boats vendors

[boatvendorElektro,1] execVM "scripts\tot\vendors\boatVendor.sqf";

//set recruiter
[recruiterBalota] execVM "scripts\tot\ai\setRecruiter.sqf";
[recruiterCherno] execVM "scripts\tot\ai\setRecruiter.sqf";

[banker1] execVM "scripts\tot\industries\setBank.sqf";[banker2] execVM "scripts\tot\industries\setBank.sqf";
[banker3] execVM "scripts\tot\industries\setBank.sqf";

}; //end client / hostedServ scripts

//start server only scripts
//set tot industry scripts if you are the server
if (isDedicated || isServer) then {

// init farmers
[farmKozlovka, "farmKozlovka_load", "farmKozlovka_deliver"] execVM "scripts\tot\industries\setFarm.sqf";

//init fisherys
[fisheryKamenka, "fisheryKamenka_load", "fisheryKamenka_deliver"] execVM "scripts\tot\industries\setFishery.sqf";

//set logging camp
[loggingCampBashnya, "loggingCampBashnya_load", "loggingCampBashnya_deliver"] execVM "scripts\tot\industries\setLoggingCamp.sqf";
[loggingCampMyshkino, "loggingCampMyshkino_load", "loggingCampMyshkino_deliver"] execVM "scripts\tot\industries\setLoggingCamp.sqf";

//set lumber mill
[berezinoLumbermill, "berezinoLumbermill_load", "berezinoLumbermill_deliver"] execVM "scripts\tot\industries\setLumbermill.sqf";

//set carpenter
[carpenterNovy, "carpenterNovy_load", "carpenterNovy_deliver"] execVM "scripts\tot\industries\setCarpenter.sqf";

//set exporter - docks
[exportDocksCherno, "exportDocksCherno_load", "exportDocksCherno_deliver"] execVM "scripts\tot\industries\setExportDocks.sqf";

//set exporter - air
[exportAirNW, "exportAirNW_load", "exportAirNW_deliver"] execVM "scripts\tot\industries\setExportAir.sqf";

//setQuarry
[quarrySolnichny, "quarrySolnichny_load", "quarrySolnichny_deliver"] execVM "scripts\tot\industries\setQuarry.sqf";

//set cement works
[cementWorksStary, "cementWorksStary_load", "cementWorksStary_deliver"] execVM "scripts\tot\industries\setCementWorks.sqf";

//set Buildingsite
[buildingSiteCherno, "buildingSiteCherno_load", "buildingSiteCherno_deliver"] execVM "scripts\tot\industries\setBuildingSite.sqf";

//init granary
[granaryRogovo, "granaryRogovo_load", "granaryRogovo_deliver"] execVM "scripts\tot\industries\setGranary.sqf";

//init markets
[marketElektro, "marketElektro_load", "marketElektro_deliver"] execVM "scripts\tot\industries\setMarket.sqf";
[marketCherno, "marketCherno_load", "marketCherno_deliver"] execVM "scripts\tot\industries\setMarket.sqf";



//set town transport
[chernoTaxi] execVM "scripts\tot\passengers\townPassengers.sqf";

//set air passengers
[balota_airfield] execVM "scripts\tot\passengers\airportPassengers.sqf";

//load persistence data file
execVM "scripts\tot\initDB.sqf";

};  // end 'are you the server' if statement


//add respawn script - client side
_index = player addMPEventHandler ["mpkilled", {Null = _this execVM "scripts\tot\playerkilled.sqf";}];

//test action to get player location/objects & shit
//player addAction["Where Am I","scripts\tot\whereAmI.sqf"];
//onMapSingleClick {player setPos _pos;};

