#include "hpp\lists.hpp"
#include "hpp\initFunctions.hpp"
#include "af_troops\init_functions.hpp";
["AF_DebMinesShow" call BIS_fnc_getParamValue] execVM "scripts\ied.sqf";

enableSaving [false, false];
/*------------params------------*/
private ["_AF_monthMission","_AF_dayMission","_AF_ENcomponent"];
_AF_timeMission 		= "AF_time" call BIS_fnc_getParamValue;
_AF_weatherMission 		= "AF_weather" call BIS_fnc_getParamValue;
_AF_cacheCount 			= "AF_cacheCount" call BIS_fnc_getParamValue;
_AF_MaxZones 			= "AF_CountTrigActive" call BIS_fnc_getParamValue;
_AF_timeLimitMissions 	= "AF_timeLimitMissions" call BIS_fnc_getParamValue;
_AF_markersGroups 		= "AF_markersGroups" call BIS_fnc_getParamValue;
_AF_distSpawnAI 		= "AF_distSpawnAI" call BIS_fnc_getParamValue;
_AF_MaxTicketsDead	= "AF_MaxTicketsDead" call BIS_fnc_getParamValue;
_AF_MaxKilledCivs		= "AF_MaxKilledCivs" call BIS_fnc_getParamValue;
_AF_enemyUnits 			= "AF_enemyUnits" call BIS_fnc_getParamValue;
_AF_enemyUnitsPatrol 	= "AF_enemyUnitsPatrol" call BIS_fnc_getParamValue;
_AF_numberGroup 		= "AF_numberGroup" call BIS_fnc_getParamValue;
_AF_numberGroupStWep 	= "AF_numberGroupStWep" call BIS_fnc_getParamValue;
_AF_armourPatrol 		= "AF_armourPatrol" call BIS_fnc_getParamValue;
_AF_AirPatrolCount 		= "AF_AirPatrolCount" call BIS_fnc_getParamValue;
_AF_airPatrols 			= "AF_airPatrol" call BIS_fnc_getParamValue;
_AF_airPatrolsMod 		= "AF_airPatMod" call BIS_fnc_getParamValue;
_AF_airPatRespawn 		= "AF_airPatRespawn" call BIS_fnc_getParamValue;
_AF_ambientCivilians 	= "AF_ambientCivils" call BIS_fnc_getParamValue;
_AF_civiliansBomber 	= "AF_civilsBomber" call BIS_fnc_getParamValue;
_AF_MainTroopsDebug		= "AF_MainTroopsDebug" call BIS_fnc_getParamValue;
_AF_DebCasheShow   		= "AF_DebCasheShow" call BIS_fnc_getParamValue;
_AF_DebIntelShow   		= "AF_DebIntelShow" call BIS_fnc_getParamValue;
/*------------------------------*/
_AF_monthMission        = 7;
_AF_dayMission          = 3;
_AF_ENcomponent         = (random 10);

AF_BVHarr               = [];
AF_pDT 		            = 0;
AF_cDeads 				= 0;
AF_pMaxDT				= [_AF_MaxTicketsDead,999999] select (_AF_MaxTicketsDead isEqualTo -1);
AF_cMaxKill				= [_AF_MaxKilledCivs,999999] select (_AF_MaxKilledCivs isEqualTo -1);
AF_cacheCount 			= _AF_cacheCount;
[_AF_enemyUnits,_AF_distSpawnAI,_AF_numberGroup,_AF_ambientCivilians,_AF_numberGroupStWep,_AF_MaxZones,_AF_MainTroopsDebug] execVM "af_troops\start.sqf"; // SPAWN MAIN TROOPS IN ZONES
setWind [_AF_ENcomponent,_AF_ENcomponent, false];   // ветер
setDate [2015,_AF_monthMission,_AF_dayMission,_AF_timeMission,0]; // Дата
[_AF_cacheCount,_AF_DebCasheShow,_AF_DebIntelShow] spawn AF_fnc_setupCaches; // схроны
if (_AF_weatherMission == -1) then {
	_AF_weatherMission = ceil random 100;
	[[_AF_weatherMission / 100],"bis_fnc_setOvercast",true,true] call BIS_fnc_MP; // погода
};
if (_AF_armourPatrol != 0) then {
	[_AF_enemyUnitsPatrol,_AF_armourPatrol] execVM "scripts\ground_patrol.sqf"; // наземный патруль
};

if (_AF_civiliansBomber isEqualTo 1) then {  [] spawn AF_fnc_start_bomber; }; // Аллах-Бабахи

if (_AF_ambientCivilians == 1) then { /* TEMPORARY DESABLED (OR NOT TEMPORARY) */ }; // гражданский трафик

if (_AF_timeLimitMissions > 0) then {
	[_AF_timeLimitMissions] execVM "scripts\limit_time.sqf"; // лимит времени
};

if (_AF_MaxTicketsDead > -1 || _AF_MaxKilledCivs > -1) then  // лимит смертей игроков и гражданских
{
	[_AF_MaxTicketsDead,_AF_MaxKilledCivs] spawn AF_killLimits;
};

if (_AF_AirPatrolCount != 0) then {
	[_AF_airPatrols,_AF_airPatRespawn,_AF_airPatrolsMod,_AF_enemyUnitsPatrol,_AF_AirPatrolCount] execVM "scripts\air_patrol.sqf"; // воздушный патруль
};
// Арсенал
[arsenal_box,[_weapons,_magazines,_items,_backpacks]] spawn 
{
    params ["_box","_array"];
    _array params ["_weapons","_magazines","_items","_backpacks"];
    // отчистка ящика
    clearWeaponCargoGlobal _box;
    clearMagazineCargoGlobal _box;
    clearItemCargoGlobal _box;
    clearBackPackCargoGlobal _box;

    // запуск арсенала
    [_box,_weapons,true,true] call BIS_fnc_addVirtualWeaponCargo;
    [_box,_magazines,true,true] call BIS_fnc_addVirtualMagazineCargo;
    [_box,_items,true,true] call BIS_fnc_addVirtualItemCargo;
    [_box,_backpacks,true,true] call BIS_fnc_addVirtualBackpackCargo;
};
/*
// Звуки СТО
private _stoMark = "marker_94"; // маркер около СТО - позиция выбирается между ним и объектом ниже
private _stoObj = BeeRepair; // объект для звука
createSoundSource ["repair_1_sound", _stoObj, [], 0]; // йифра в конце - радиус размещения
createSoundSource ["repair_2_sound", _stoObj, [_stoMark], 20];
createSoundSource ["repair_3_sound", _stoObj, [_stoMark], 20];
createSoundSource ["repair_4_sound", _stoObj, [], 0];
*/
// метки авто раз в 10 мин
[] spawn AF_baseVehMarks;