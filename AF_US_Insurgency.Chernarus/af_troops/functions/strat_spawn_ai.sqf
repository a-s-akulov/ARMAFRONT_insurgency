#include "..\..\hpp\arrays\crew_veh.hpp"
#include "..\..\hpp\arrays\heavy_armored_veh.hpp"
#include "..\..\hpp\arrays\infantry.hpp"
#include "..\..\hpp\arrays\static.hpp"
#include "..\..\hpp\arrays\static_positions.hpp"
#include "..\..\hpp\arrays\random_weapons.hpp"







private ["_grp","_pos","_countUnits2","_st","_haType","_veh","_armCrew","_script"]; // _grp - универсальная временная мпеременная, которая используется в некоторых циклах "не по назначению"

_marker				= (_this select 0) select 0;
_garageType			= (_this select 0) select 1;
_supVehType			= (_this select 0) select 2;
_trigger			= _this select 1;
_enemy_type			= _this select 2;
_inf_count			= _this select 3;
_victoryColor		= _this select 4;
_debug				= _this select 5; // true - вкл. режим дебага, false - выкл.
_markSize			= getMarkerSize _marker;

_pool 				= [];
_weaps				= [];
_stPool				= [];
_haPool				= [];
_units 				= [];
_staticWeapons		= [];
_hArmor				= [];
_stTemp				= [];
_houseLeft			= [];

_stWeps				= _trigger getVariable "stWeps";
_heavyArmor			= _trigger getVariable "hArmor";
_strategicObjects	= _trigger getVariable "stratObjects";

_trigger			setVariable ["handler",_thisScript];
AF_activatedMrkrs	pushBack _marker;
publicVariable		"AF_activatedMrkrs";

_stWepsPos			= _AF_StWepsPos;
_sideEnemy 			= AF_sideEnemy;

{ _x allowDamage true; } forEach (arrayCachePos select { _x inArea _marker });

_garage				= (nearestObjects  [_trigger,[_garageType],selectMax _markSize]) select 0;
_markSizeCoef		= ((_markSize select 0) * (_markSize select 1)) / 1000; // Лой-Манара - 20, это коэффициент размера маркера
_countUnits			= [_trigger getVariable "counter",(_markSizeCoef + floor random 5) * _inf_count] select isNil { _trigger getVariable "counter" }; // сколько в итоге точно будет юнитов в зоне

switch _enemy_type do
{
	case 0: { _pool = _AF_InfPool_0; _weaps = _AF_RandomWep_0; _stPool = _AF_stPool_0; _haPool = _AF_ArmPool_0; _armCrew = AF_crewPool_0; };
	case 1: { _pool = _AF_InfPool_1; _weaps = _AF_RandomWep_1; _stPool = _AF_stPool_1; _haPool = _AF_ArmPool_1; _armCrew = AF_crewPool_1; };
	case 2: { _pool = _AF_InfPool_2; _weaps = _AF_RandomWep_2; _stPool = _AF_stPool_2; _haPool = _AF_ArmPool_2; _armCrew = AF_crewPool_2; };
	case 3: { _pool = _AF_InfPool_3; _weaps = _AF_RandomWep_3; _stPool = _AF_stPool_3; _haPool = _AF_ArmPool_3; _armCrew = AF_crewPool_3; };
};

if (_debug) then
{
	private _markerDeb = format["%1_debug",_marker];
	_markerDeb setMarkerText "Стратегическая зона активирована, идет процесс спавна юнитов...";
};

_marker setMarkerAlpha 1;

_houses 	= nearestObjects [_trigger,["House"],selectMax _markSize];
_houses 	= _houses inAreaArray _marker;
_houses 	= _houses select { count (_x buildingPos -1) > 0 }; // выбраны все здания в которые можно запихнуть юнитов


if (count _houses > 0) then
{ 

	// HQ spawn



	private _hq = [0,count ((_houses select 0) buildingPos -1)];
	{
		if ( (count (_x buildingPos -1)) > (_hq select 1) ) then { _hq = [_forEachIndex,count (_x buildingPos -1)]; };
	} forEach _houses;
	_hq = _houses deleteAt (_hq select 0);

	private _positions = _hq buildingPos -1;
	{
		_grp = (createGroup _sideEnemy) createUnit [selectRandom _pool, _x, [], 0, "CAN_COLLIDE"];
		_grp setFormDir ((((getPosATL _hq) getDir _x) - 45) + round random 90);
		//[group _grp,"inf"] spawn AF_setSkill;
		{ _x setUnitPos selectRandom ["MIDDLE","UP"]; } forEach units _grp;
		_units pushBack group _grp;
	} forEach _positions;
	// STATICS IN HQ
	private _stId = (_stWepsPos findIf { (typeOf _hq) isEqualTo (_x select 0) });
	if (_stId > -1) then
	{
		_stArr = _stWepsPos select _stId;
		_grp = createGroup _sideEnemy;
		{
			_stRelPos	= _hq getRelPos [_x select 0,_x select 1];
			_st = createVehicle [[selectRandom _AF_stPoolInHouse,selectRandom _stPool] select (isNil { _x select 3 }), [_stRelPos select 0,_stRelPos select 1,((getPosATL _hq) select 2) + (_x select 2) + 0.1], [], 0, "CAN_COLLIDE"];
			if (isNil { _x select 3 }) then { _st setDir ( ((getPosATL _hq) getDir _st) - 45 + round random 90 ); } else { _st setDir ((direction _hq) + (_x select 3)); };
			_st allowDamage false;
			_staticWeapons pushBack _st;
			
			sleep 1;
			(selectRandom _pool) createUnit [getPosATL _st, _grp,"this moveinGunner _st"];
			_stTemp pushBack _st;
		} forEach (_stArr select 1);
		//[_grp,"inf"] spawn AF_setSkill;
		_units pushBack _grp;
	};

	_trigger setVariable ["stTemp",_stTemp];
	_stTemp = nil;
	
	_houseLeft	append _houses;
};



// HEAVY ARMOR POSITIONS

_haNil 				= isNil "_heavyArmor";
_vehCount			= if (_haNil) then { (round ((_markSizeCoef / 20) + random (_markSizeCoef / 18)) + 4) } else { (count _heavyArmor) };
for "_i" from 1 to _vehCount do
{
	_pos = [[[getMarkerPos _marker,selectMax _markSize]],["water"],{ (((nearestObject _this) distance _this) > 12) && _this inArea _marker }] call BIS_fnc_randomPos;
	if !(_pos isEqualTo [0,0]) then
	{
		_grp		= createGroup _sideEnemy;
		_vehType 	= if (_haNil) then { (selectRandom _haPool) } else { (_heavyArmor deleteAt 0) };
		_veh		= createVehicle [_vehType,_pos,[],0, "NONE"];
		_veh 		setDir (((_trigger getDir _pos) - 45) + round random 90);

		_script		= [_veh,selectRandom _armCrew,_grp] spawn AF_addVehCrew;
		waitUntil { sleep 1; scriptDone _script };
		_veh 		setVehicleRadar 1;
		_veh 		setVehicleReportRemoteTargets true;
		_veh 		setVehicleReceiveRemoteTargets true;
		_veh		setVehicleReportOwnPosition true;
		_veh		allowCrewInImmobile true;
		_veh		setVehicleLock "LOCKEDPLAYER";

		if !(isNull gunner _veh) then { _grp selectLeader gunner _veh; };
		_grp enableAttack true;
		_grp setCombatMode "RED";
		_units pushBack _grp;
		_hArmor pushBack _veh;

		//[_grp,"inf"] 	spawn AF_setSkill;
		sleep 0.2;
	};
};
if ((count _hArmor) > 0) then { _trigger setVariable ["hArmor",_hArmor]; };


// INF PATROLS SPAWN

_pGrps = _countUnits min (round ( _markSizeCoef / 4 + random(_markSizeCoef / 8) ) );
for "_i" from 1 to _pGrps do
{
	if !(_countUnits isEqualTo 0) then
	{
		_grp = createGroup _sideEnemy;
		_pos = [[_marker],["water"],{ ((nearestObject _this) distance _this) > 6 }] call BIS_fnc_randomPos;
		(selectRandom _pool) createUnit [_pos,_grp];
		(selectRandom _pool) createUnit [_pos,_grp];
		_countUnits = _countUnits - 2;
		for "_i" from 1 to (random 4) do
		{
			(selectRandom _pool) createUnit [_pos,_grp];
			_countUnits = _countUnits - 1;
		};
		_grp setBehaviour "SAFE";
		_grp setSpeedMode "LIMITED";
		_grp setCombatMode "YELLOW";
		_grp setFormation selectRandom ["STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "DIAMOND"];
		[_grp,_marker,0,false] spawn AF_taskPatrol;
		//[_grp,"inf"] 	spawn AF_setSkill;
		_units pushBack _grp;
		sleep 0.2;
	};
};


if (isNil { _trigger getVariable "countStart" }) then
{
	_grp = 0;
	{ _grp = _grp + count units _x; } forEach _units;
	_countUnits2 = _grp;
	_trigger setVariable ["countStart",_countUnits2];
} else { _countUnits2 = _trigger getVariable "countStart"; };

[_units,_weaps] spawn AF_RandomWep; // рандомное оружие юнитам

{ _x allowDamage true; } forEach _staticWeapons; // убрать неуязвимость статиков
{ _x allowDamage true; } forEach _strategicObjects; // убрать неуязвимость стратегических объектов


// спаван машины поддержки в гараже
if (isNil { _trigger getVariable "SUP_VEH_DESTROYED" }) then
{
	_pos = _garage getRelPos[3,180];
	_veh = createVehicle [_supVehType, _pos, [], 0, "CAN_COLLIDE"];
	_veh setDir (direction _garage + 180);
	_veh spawn AF_vehCargo;
	_trigger setVariable ["SUP_VEH_DESTROYED",_veh];
};

// DEBUG
if (_debug) then
{ 
	{
		private _marker = createMarker [format["%1",_x],position _x];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_dot";
		_marker setMarkerText format["Мест: %1",count (_x buildingPos -1)];
	} forEach _houses;
	_grp = 0;
	{ _grp = _grp + count units _x; } forEach _units;
	private _markerDeb = format["%1_debug",_marker];
	_markerDeb setMarkerText format["Юниты заспавнены. Пехота противника: %1 единиц; Изначальное кол-во пехоты в зоне: %2 единиц; Стационары: %3 единиц; Техника: %4 штук. || Зона: ""%5""",_grp,_countUnits2,count _staticWeapons,count _hArmor,_marker];
};

sleep 20;

if (triggerActivated _trigger) then { [_marker,_trigger,_units,_countUnits2,_victoryColor,_debug] spawn AF_stratCheckZone; } else { [_marker,_trigger,_units,_debug] spawn AF_stratRemoveAI; };