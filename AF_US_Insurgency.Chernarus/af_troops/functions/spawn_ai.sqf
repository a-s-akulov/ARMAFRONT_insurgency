#include "..\..\hpp\arrays\animals.hpp"
#include "..\..\hpp\arrays\infantry.hpp"
#include "..\..\hpp\arrays\static.hpp"
#include "..\..\hpp\arrays\static_positions.hpp"
#include "..\..\hpp\arrays\random_weapons.hpp"


private ["_grp","_pos","_countUnits2"]; // _grp - универсальная временная мпеременная, которая используется в некоторых циклах "не по назначению"

_marker				= _this select 0;
_trigger			= _this select 1;
_enemy_type			= _this select 2;
_inf_count			= _this select 3;
_civ				= _this select 4;
_st_wep				= _this select 5;
_victoryColor		= _this select 6;
_markSize			= getMarkerSize _marker;
_debug				= _this select 7; // true - вкл. режим дебага, false - выкл.

AF_ActTrgrs			= AF_ActTrgrs + 1;
AF_activatedMrkrs	pushBack _marker;
publicVariable		"AF_activatedMrkrs";

_pool 				= [];
_weaps				= [];
_units 				= [];
_unitsCiv			= [];
_unitsAnim			= [];
_staticWeapons		= [];
_trigger			setVariable ["handler",_thisScript];
_sideEnemy 			= AF_sideEnemy;
_markSizeCoef		= ((_markSize select 0) * (_markSize select 1)) / 2000; // Лой-Манара - 20, это коэффициент размера маркера
_countUnits			= [_trigger getVariable "counter",(_markSizeCoef + floor random 5) * _inf_count] select isNil { _trigger getVariable "counter" }; // сколько в итоге точно будет юнитов в зоне
{ _x allowDamage true; } forEach (arrayCachePos select { _x inArea _marker });

switch _enemy_type do
{
	case 0: { _pool = _AF_InfPool_0; _weaps = _AF_RandomWep_0; };
	case 1: { _pool = _AF_InfPool_1; _weaps = _AF_RandomWep_1; };
	case 2: { _pool = _AF_InfPool_2; _weaps = _AF_RandomWep_2; };
	case 3: { _pool = _AF_InfPool_3; _weaps = _AF_RandomWep_3; };
};

if (_debug) then
{
	private _markerDeb = format["%1_debug",_marker];
	_markerDeb setMarkerText "Зона активирована, идет процесс спавна юнитов...";
};

_marker setMarkerAlpha 1;

_houses 	= nearestObjects [_trigger,["House"],selectMax _markSize];
_houses 	= _houses inAreaArray _marker;
_houses 	= _houses select { count (_x buildingPos -1) > 0 }; // выбраны все здания в которые можно запихнуть юнитов
_houseLeft	= [];
_houseLeft	append _houses;


// HOUSE INFANTRY SPAWN

if ( count _houses > 0 ) then 
{ 
	_grp = ([_houseLeft,round (_countUnits * 3 / 10),_pool,_sideEnemy,_trigger] call AF_fillHouse); 
	_countUnits = _countUnits - count _grp; 
	_units append _grp; 
};

// PATROLS SPAWN

_pGrps = (round (_countUnits / 2)) min (round ( _markSizeCoef / 10 + random(_markSizeCoef / 20) ) );
for "_i" from 1 to _pGrps do
{
	if !(_countUnits isEqualTo 0) then
	{
		_grp = createGroup _sideEnemy;
		_pos = [[_marker],["water"],{ ((nearestObject _this) distance _this) > 6 }] call BIS_fnc_randomPos;
		(selectRandom _pool) createUnit [_pos,_grp];
		(selectRandom _pool) createUnit [_pos,_grp];
		_countUnits = _countUnits - 2;
		if (random 1 > 0.5) then
		{
			(selectRandom _pool) createUnit [_pos,_grp];
			_countUnits = _countUnits - 1;
		};
		[_grp,_marker,0,false] spawn AF_taskPatrol;
		_grp setSpeedMode "LIMITED";
		//[_grp,"inf"] 	spawn AF_setSkill;
		_units pushBack _grp;
		sleep 0.2;
	};
};

// STATIC WEAPONS SPAWN

if (_st_wep isEqualTo 1) then
{
	private ["_stWepType","_building","_stWepArr","_stBType","_stRelPos","_stWPos","_st","_grp","_x1","_stTypes"];

	private _stWepsPos		= _AF_StWepsPos;
	switch _enemy_type do 
	{
		case 0: { _stTypes = _AF_stPool_0; };
		case 1: { _stTypes = _AF_stPool_1; };
		case 2: { _stTypes = _AF_stPool_2; };
		case 3: { _stTypes = _AF_stPool_3; };
	};
	private _stWeps			= _trigger getVariable "stWeps";
	private _stNil			= isNil "_stWeps";
	private _grp			= createGroup _sideEnemy;
	private _stWepsCount	= if (_stNil) then { (round ((_markSizeCoef / 10) + random (_markSizeCoef / 5))) } else { (count _stWeps) };
	private _buildings		= [];
	_buildings				append (_houses select { _x1 = typeOf _x; 	(_stWepsPos findIf { _x1 isEqualTo (_x select 0) }) > -1 });
	_stWepsCount			= _stWepsCount min (count _buildings);

	for "_i" from 1 to _stWepsCount do
	{
		_building	= _buildings deleteAt floor (random count _buildings);
		if (alive _building) then
		{
			_stBType	= typeOf _building;
			_stWepArr	= _stWepsPos select (_stWepsPos findIf { (_x select 0) isEqualTo _stBType });
			_stWepArr	= selectRandom (_stWepArr select 1);
			_stWepType 	= if (_stNil) then { [selectRandom _AF_stPoolInHouse,selectRandom _stTypes] select (isNil { _stWepArr select 3 }) } else { (_stWeps deleteAt 0) };
			_stRelPos	= _building getRelPos [_stWepArr select 0,_stWepArr select 1];
			_stWPos		= [_stRelPos select 0,_stRelPos select 1,((getPosATL _building) select 2) + (_stWepArr select 2) + 0.1];

			_st 	= createVehicle [_stWepType, _stWPos, [], 0, "CAN_COLLIDE"];
			_st allowDamage false;

			if (isNil { _stWepArr select 3 }) then 
			{ 
				_st setDir ( ((getPosATL _trigger) getDir _stWPos) - 45 + round random 90 ); 
			} else 
			{
				_st setDir ((direction _building) + (_stWepArr select 3));
			};

			(selectRandom _pool) createUnit [_stWPos, _grp,"this moveinGunner _st"];
			_staticWeapons pushBack _st;
			sleep 0.2;
		};
	};
	if ((count (units _grp)) > 0) then
	{
		//[_grp,"inf"] 	spawn AF_setSkill;
		_units pushBack _grp;
		_trigger setVariable ["stWeps",_staticWeapons];
	};
};


// Если остались еще нераспределенные юниты - распихать их по оставшимся домам

if ( count _houseLeft > 0 && _countUnits > 0) then { _units append ([_houseLeft,_countUnits,_pool,_sideEnemy,_trigger] call AF_fillHouse); };


// CIVILIAN SPAWN

if (_civ isEqualTo 1) then
{
	private ["_unit","_pos"];
	private _countCivs	= round (_markSizeCoef * 1.5 + random _markSizeCoef);
	_countCivs			= _countCivs min 20;
	private _f			= round (_countCivs / 6);
	for "_i" from 1 to _f do
	{
		_pos = [[_marker],["water"],{ ((nearestObject _this) distance _this) > 6 }] call BIS_fnc_randomPos;
		_unit = (createGroup civilian) createUnit [selectRandom AF_CivUnitPool, _pos, [], 0, "CAN_COLLIDE"];
		[group _unit,_marker,0,false] spawn AF_taskPatrol;
		(group _unit) setSpeedMode "LIMITED";
		_unitsCiv pushBack group _unit;
		sleep 0.1;
	};
	_countCivs = (_countCivs - _f) min (round (count _houses / 2));
	for "_i" from 1 to _countCivs do
	{
		_pos = selectRandom ((selectRandom _houses) buildingPos - 1);
		_unitsCiv pushBack group ((createGroup civilian) createUnit [selectRandom AF_CivUnitPool, _pos, [], 0, "CAN_COLLIDE"]);
		sleep 0.1;
	};
};

// ANIMALS SPAWN

_animCount 		= round (_markSizeCoef / 2 + 1 + random (_markSizeCoef / 4));
for "_i" from 1 to _animCount do
{
	_grp = selectRandom _AF_AnimPool;
	_pos = [[_marker],["water"],{ ((nearestObject _this) distance _this) > 6 }] call BIS_fnc_randomPos;
	if (_grp isEqualTo "Sheep_random_F" || _grp isEqualTo "Goat_random_F") then
	{
		private _countHerd = round (2 + random 3);
		for "_i" from 1 to _countHerd do
		{
			_unitsAnim pushBack createAgent [_grp, _pos, [], 0, "NONE"];
		};
	};
	_unitsAnim pushBack createAgent [selectRandom _AF_AnimPool, _pos, [], 0, "CAN_COLLIDE"];
	sleep 0.2;
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
	_markerDeb setMarkerText format["Юниты заспавнены. Пехота противника: %1 единиц; Изначальное кол-во пехоты в зоне: %2 единиц; Стационары: %3 единиц; Гражданские: %4 штук; Животные: %5 штук. || Зона: ""%6""",_grp,_countUnits2,count _staticWeapons,count _unitsCiv,count _unitsAnim,_marker];
};

sleep 20;

if (triggerActivated _trigger) then { [_marker,_trigger,_units,_countUnits2,_victoryColor,_unitsCiv,_unitsAnim,_debug] spawn AF_checkZone; } else { [_marker,_trigger,_units,_unitsCiv,_unitsAnim,_debug] spawn AI_remove; };