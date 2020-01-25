//by Katletka
if (!isServer) exitWith {};
private ["_position","_roads","_vehCount","_pos","_veh","_grp","_enemys_veh","_class_crew","_script","_leader"];


#define PATROL_MARKER "patrol"
#define BLACKLIST_ROADS []
#define FILE_FOLDER "scripts\ground_patrol.sqf"
#define SLEEP_TIME 600
#define BASE_SAFE_ZONE 2000


#include "..\hpp\arrays\crew_veh.hpp"
#include "..\hpp\arrays\heavy_armored_veh.hpp"


_faction     	= _this select 0;
_countGroups 	= _this select 1;
_alivePatrol	= param [2,[[],[]]];

_allPositions 	= [];
_allVehicles	= [];
_allUnits		= [];

_allVehicles	appEnd (_alivePatrol select 0);
_allUnits		appEnd (_alivePatrol select 1);


switch _faction do 
{
	case 0 : { _enemys_veh  = _AF_ArmPool_0; _class_crew  = AF_crewPool_0 select floor random count AF_crewPool_0; };
	case 1 : { _enemys_veh  = _AF_ArmPool_1; _class_crew  = AF_crewPool_1 select floor random count AF_crewPool_1; };
	case 2 : { _enemys_veh  = _AF_ArmPool_2; _class_crew  = AF_crewPool_2 select floor random count AF_crewPool_2; };
	case 3 : { _enemys_veh  = _AF_ArmPool_3; _class_crew  = AF_crewPool_3 select floor random count AF_crewPool_3; };
};




// проба - посомтрим как выйдет
for "_i" from 1 to _countGroups do
{
	_position 	= [[PATROL_MARKER],["water"],{ _position = _this; ((_allPositions findIf { (_x distance _position) < 1000 }) isEqualTo -1 && ((_position distance AF_centerBase) > BASE_SAFE_ZONE) )}] call BIS_fnc_randomPos;
	_position 	= getPosATL ([_position, 5000,AF_centerBase nearRoads BASE_SAFE_ZONE] call BIS_fnc_nearestRoad);
	sleep 0.2;
	_roads		= _position nearRoads 5000;
	sleep 0.2;
	_roads		= _roads select (_roads findIf { !((typeOf _x) in BLACKLIST_ROADS) && _x inArea PATROL_MARKER && ((_x distance AF_centerBase) > BASE_SAFE_ZONE) }); // тут выбирается одна дорога, которая не в черном списке
	_position	= getPosATL _roads;
	_allPositions pushBack _position;

	_vehCount	= 2 + round random 3;

	for "_i" from 1 to _vehCount do
	{
		_grp		= createGroup AF_sideEnemy;
		_pos	= [_position, 0, 100, 10, 0, 20, 0,[["water"]],[[[[_position,20]]] call BIS_fnc_randomPos,[0,0,0]]] call BIS_fnc_findSafePos;
		sleep 0.2;

		_veh =  createVehicle [selectRandom _enemys_veh,_pos,[],0,"CAN_COLLIDE"];
		_script = [_veh,_class_crew,_grp] spawn AF_addVehCrew;
		waitUntil { sleep 1; scriptDone _script };

		_allVehicles pushBack _veh;
		_veh setVehicleRadar 1;
		_veh setVehicleReportRemoteTargets true;
		_veh setVehicleReceiveRemoteTargets true;
		_veh setVehicleReportOwnPosition true;
		_veh allowCrewInImmobile true;

		_leader = leader _grp;
		_leader setskill ["aimingAccuracy",1];
		_leader setskill ["courage",1];
		_leader setskill ["general",1];
		_leader setskill ["spotTime",1];
		_leader setskill ["spotDistance",1];
		_leader setskill ["commanding",1];
		_leader allowFleeing 0;
		{
			_x allowfleeing 0.25;
			_x setskill ["aimingAccuracy", 0.40 + random 0.20];
			_x setskill ["courage",1];
			_x setskill ["general",0.9];
			_x setskill ["spotTime",1];
			_x setskill ["spotDistance",1];
		} forEach (units _grp) - [_leader];
		_grp enableAttack true;
		_grp setBehaviour "Safe";
		_grp setCombatMode "YELLOW";
		_grp setFormation "COLUMN";

		[_grp,PATROL_MARKER,0,true,BLACKLIST_ROADS] spawn AF_taskPatrol;
		[_veh,"GROUND_PATROL"] spawn AF_vehCargo;
	
		_allUnits append units _grp;
	};
};







/*
Это заменено, посмотрим что выйдет

for "_i" from 1 to _countGroups do
{
	_grp		= createGroup AF_sideEnemy;
	_position 	= [[PATROL_MARKER],["water"],{ _position = _this; ((_allPositions findIf { (_x distance _position) < 1000 }) isEqualTo -1 && ((_position distance AF_centerBase) > BASE_SAFE_ZONE) )}] call BIS_fnc_randomPos;
	_position 	= getPosATL ([_position, 5000,AF_centerBase nearRoads BASE_SAFE_ZONE] call BIS_fnc_nearestRoad);
	sleep 0.2;
	_roads		= _position nearRoads 5000;
	sleep 0.2;
	_roads		= _roads select (_roads findIf { !((typeOf _x) in BLACKLIST_ROADS) && _x inArea PATROL_MARKER && ((_x distance AF_centerBase) > BASE_SAFE_ZONE) }); // тут выбирается одна дорога, которая не в черном списке
	_position	= getPosATL _roads;
	_allPositions pushBack _position;

	_vehCount	= 2 + round random 3;

	for "_i" from 1 to _vehCount do
	{
		_pos	= [_position, 0, 100, 10, 0, 20, 0,[["water"]],[[[[_position,20]]] call BIS_fnc_randomPos,[0,0,0]]] call BIS_fnc_findSafePos;
		sleep 0.2;
		if (_i isEqualTo 1) then
		{
			_veh = createVehicle [selectRandom (_enemys_veh select {_x isKindOf "Tank"}),_pos,[],0,"CAN_COLLIDE"];
			if ( (count fullCrew [_veh,"Commander",true]) > 0 ) then
			{
				_class_crew createUnit [_pos,_grp,"this moveInCommander _veh; (group this) selectLeader this;",1,"COLONEL"];
				_class_crew createUnit [_pos,_grp,"this moveInAny _veh;"];
				_class_crew createUnit [_pos,_grp,"this moveInAny _veh;"];
			} else {
				_class_crew createUnit [_pos,_grp,"this moveInGunner _veh; (group this) selectLeader this;",1,"COLONEL"];
				_class_crew createUnit [_pos,_grp,"this moveInAny _veh;"];
			};
		} else {
			_veh =  createVehicle [selectRandom _enemys_veh,_pos,[],0,"CAN_COLLIDE"];
			_script = [_veh,_class_crew,_grp] spawn AF_addVehCrew;
			waitUntil { sleep 1; scriptDone _script };
		};
		_allVehicles pushBack _veh;
		_veh setVehicleRadar 1;
		_veh setVehicleReportRemoteTargets true;
		_veh setVehicleReceiveRemoteTargets true;
		_veh setVehicleReportOwnPosition true;
		_veh allowCrewInImmobile true;
	};
	private _leader = leader _grp;
	_leader setskill ["aimingAccuracy",1];
	_leader setskill ["courage",1];
	_leader setskill ["general",1];
	_leader setskill ["spotTime",1];
	_leader setskill ["spotDistance",1];
	_leader setskill ["commanding",1];
	_leader allowFleeing 0;
	{
		_x allowfleeing 0.25;
		_x setskill ["aimingAccuracy", 0.40 + random 0.20];
		_x setskill ["courage",1];
		_x setskill ["general",0.9];
		_x setskill ["spotTime",1];
		_x setskill ["spotDistance",1];
	} forEach (units _grp) - [_leader];
	_grp enableAttack true;
	_grp setBehaviour "Safe";
	_grp setCombatMode "YELLOW";
	_grp setFormation "COLUMN";
	[_grp,PATROL_MARKER,0,true,BLACKLIST_ROADS] spawn AF_taskPatrol;
	_allUnits append units _grp;
};
*/


/* 
[
	all spawned vehicles,
	all spawned units,
	count of spawned vehicles,
	[params for next spawn],
	sleep to next spawn before current patrol die,
	file folder of executed spawn script,
	execute once with spawn next patrol (optional, default: false)
]
*/
[_allVehicles,_allUnits,count _allVehicles,[_faction,_countGroups],SLEEP_TIME,FILE_FOLDER] spawn AF_checkPatrol;