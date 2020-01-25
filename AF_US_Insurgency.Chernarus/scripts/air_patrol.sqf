//by KOKaKOJIbKA
if (!isServer) exitWith {};
private ["_type_patrol","_new_spawn","_task_patrol","_faction","_center","_pos_spawn","_patrol_rad","_side_enemy","_countPatrol","_pos_spawn_f","_i"];

#define PATROL_MARKER "patrol"
#define FILE_FOLDER "scripts\air_patrol.sqf"

#include "..\hpp\arrays\heli_veh.hpp"
#include "..\hpp\arrays\pilot_veh.hpp"
#include "..\hpp\arrays\plane_veh.hpp"

_type_patrol 	= _this select 0;
_new_spawn   	= _this select 1;
_task_patrol 	= _this select 2;
_faction     	= _this select 3;
_countPatrol 	= _this select 4;
_alivePatrol	= param [5,[[],[]]];

_allVehicles 	= [];
_allUnits		= [];

_allVehicles	appEnd (_alivePatrol select 0);
_allUnits		appEnd (_alivePatrol select 1);

_center      	= AF_centerPos;
_pos_spawn 	 	= [];
for "_i" from 1 to _countPatrol do {
	_pos_spawn pushBack ([[PATROL_MARKER],[],{ _position = _this; ((_pos_spawn findIf { (_x distance _position) < 1000 }) isEqualTo -1 && _position distance AF_centerBase > 2000) }] call BIS_fnc_randomPos);
};
_side_enemy = AF_sideEnemy;
_patrol_rad  = 5000;

_fnc_task_patrol = {
	/*
	Author: Joris-Jan van 't Land
	modified: KOKaKOJIbKA
	*/
	private ["_group", "_position", "_maxDist", "_blacklist","_task_patrol"];
	_group     		= _this select 0;
	_position  		= _this select 1;
	_maxDist   		= _this select 2;
	_task_patrol 	= _this select 3;

	{
		_x allowfleeing 0.25;
		_x setskill ["aimingAccuracy", 1.0];
		_x setskill ["courage",0.85];
		_x setskill ["commanding",1.0];
		_x setskill ["general",1.0];
		_x setskill ["spotTime",0.85];
		_x setskill ["spotDistance", 1.0];
	} forEach units _group;

	_group enableAttack true;
	_group setBehaviour "SAFE";
	_group setCombatMode "RED";

	private ["_prevPos"];
	_prevPos = _position;

	for "_i" from 0 to (2 + (random 3)) do
	{
		private ["_wp", "_newPos"];
		_newPos = [[[_prevPos, _maxDist]],["water"]] call BIS_fnc_randomPos;
		_prevPos = _newPos;

		switch _task_patrol do {
			case 0: {
				_wp = _group addWaypoint [_newPos, 0];
				_wp setWaypointType "SAD";
				_wp setWaypointCompletionRadius 10;
			};
			case 1: {
				_wp = _group addWaypoint [_newPos, 0];
				_wp setWaypointType "GUARD";
				_wp setWaypointCompletionRadius 10;
			};
		};
		if (_i == 0) then {
			_wp setWaypointSpeed "NORMAL";
			_wp setWaypointFormation "WEDGE";
		};
	};

	private ["_wp"];
	_wp = _group addWaypoint [_position, 0];
	_wp setWaypointType "CYCLE";
	_wp setWaypointCompletionRadius 10;

	true
};

sleep 120;

while { count _pos_spawn != 0 } do
{
	private["_create_air1","_create_air2","_create_air3","_create_air4"];

	//heli
	if (_type_patrol == 1 || _type_patrol == 3) then
	{
		private ["_grp_patrol1","_pos1","_posAir1","_posAir2","_enemys_air","_class_pilot"];
		switch _faction do 
		{
			case 0: { _enemys_air = AF_ACHPool_0; _class_pilot = AF_pilotPool_0 select floor random count AF_pilotPool_0; };
			case 1: { _enemys_air = AF_ACHPool_1; _class_pilot = AF_pilotPool_1 select floor random count AF_pilotPool_1; };
			case 2: { _enemys_air = AF_ACHPool_2; _class_pilot = AF_pilotPool_2 select floor random count AF_pilotPool_2; };
			case 3: { _enemys_air = AF_ACHPool_3; _class_pilot = AF_pilotPool_3 select floor random count AF_pilotPool_3; };
		};
		_grp_patrol1 = createGroup _side_enemy;

		_air1 = _enemys_air select floor random count _enemys_air;
		_pos1 = _pos_spawn deleteAt 0;

		_posAir1 = [[[_pos1, 150]],["water"]] call BIS_fnc_randomPos;
		_posAir2 = [[[_pos1, 150]],["water"]] call BIS_fnc_randomPos;
		_create_air1 = createVehicle [_air1, _posAir1,[], 0, "FLY"];
		_create_air2 = createVehicle [_air1, _posAir2,[], 0, "FLY"];

		[_create_air1,_class_pilot,_grp_patrol1] spawn AF_addVehCrew;
		[_create_air2,_class_pilot,_grp_patrol1] spawn AF_addVehCrew;

		_create_air1 setVehicleRadar 1;
		_create_air1 setVehicleReportRemoteTargets true;
		_create_air1 setVehicleReceiveRemoteTargets true;
		_create_air1 setVehicleReportOwnPosition true;
		_create_air2 setVehicleRadar 1;
		_create_air2 setVehicleReportRemoteTargets true;
		_create_air2 setVehicleReceiveRemoteTargets true;
		_create_air2 setVehicleReportOwnPosition true;

		[_grp_patrol1,_center,_patrol_rad,_task_patrol] call _fnc_task_patrol;
		_allVehicles appEnd [_create_air1,_create_air2];
		_allUnits appEnd units _grp_patrol1;

		_create_air1 flyInHeight 30;
		_create_air2 flyInHeight 30;
	};
	//plane
	if (_type_patrol == 2 || _type_patrol == 3) then
	{
		private ["_grp_patrol2","_pos2","_posAir3","_posAir4","_enemys_air","_class_pilot"];
		switch _faction do 
		{
			case 0: { _enemys_air = AF_APlanePool_0; _class_pilot = AF_pilotPool_0 select floor random count AF_pilotPool_0; };
			case 1: { _enemys_air = AF_APlanePool_1; _class_pilot = AF_pilotPool_1 select floor random count AF_pilotPool_1; };
			case 2: { _enemys_air = AF_APlanePool_2; _class_pilot = AF_pilotPool_2 select floor random count AF_pilotPool_2; };
			case 3: { _enemys_air = AF_APlanePool_3; _class_pilot = AF_pilotPool_3 select floor random count AF_pilotPool_3; };
		};
		_grp_patrol2 = createGroup _side_enemy;

		_air2 = _enemys_air select floor random count _enemys_air;
		_pos2 = _pos_spawn deleteAt 0;

		_posAir3 = [[[_pos2, 150]],["water"]] call BIS_fnc_randomPos;
		_posAir4 = [[[_pos2, 150]],["water"]] call BIS_fnc_randomPos;
		_create_air3 = createVehicle [_air2, _posAir3,[], 0, "FLY"];
		_create_air4 = createVehicle [_air2, _posAir4,[], 0, "FLY"];

		[_create_air3,_class_pilot,_grp_patrol2] spawn AF_addVehCrew;
		[_create_air4,_class_pilot,_grp_patrol2] spawn AF_addVehCrew;

		_create_air3 setVehicleRadar 1;
		_create_air3 setVehicleReportRemoteTargets true;
		_create_air3 setVehicleReceiveRemoteTargets true;
		_create_air3 setVehicleReportOwnPosition true;
		_create_air4 setVehicleRadar 1;
		_create_air4 setVehicleReportRemoteTargets true;
		_create_air4 setVehicleReceiveRemoteTargets true;
		_create_air4 setVehicleReportOwnPosition true;


		[_grp_patrol2,_center,_patrol_rad,_task_patrol] call _fnc_task_patrol;
		_allVehicles appEnd [_create_air3,_create_air4];
		_allUnits appEnd units _grp_patrol2;

		_create_air3 flyInHeightASL [200, 100, 400];
		_create_air4 flyInHeightASL [200, 100, 400];
	};
};

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
[_allVehicles,_allUnits,count _allVehicles,[_type_patrol,_new_spawn,_task_patrol,_faction,_countPatrol],_new_spawn,FILE_FOLDER] spawn AF_checkPatrol;
