#include "hpp\localVars.hpp"
#include "hpp\briefing.hpp"

if ((side group player) isEqualTo AF_sideEnemy && ("AF_secondSide" call BIS_fnc_getParamValue) isEqualTo 0) exitWith { failMission "Side_Closed"; };

[] execVM "scripts\intro.sqf";
[] execVM "event_handlers\local_handlers\display_key_down.sqf"; // local event handler 'keyDown'
[] execVM "event_handlers\local_handlers\draw_map.sqf"; // local event handler 'Draw'
[] execVM "event_handlers\local_handlers\map_mouse_click.sqf"; // local event handler 'MouseButtonClick'
[] execVM "scripts\veh_rules\vr_EventHandlers.sqf";
[] execVM "scripts\fn_jammedWeapons.sqf";
[] execVM "scripts\bee_repair_vehicle.sqf";
[] execVM "scripts\marker_playerLoc.sqf";

AF_firestResawn = true;

//Блокировка клавиш crtl+r в арсенале и других кнопок
[missionNamespace, "arsenalOpened", { 
    disableSerialization;
    private "_control";
    private _display = _this select 0;
    {
        _control = _display displayCtrl _x;
        _control ctrlRemoveAllEventHandlers "buttonclick";
        _control ctrlRemoveAllEventHandlers "onKeyDown";
        _control ctrlRemoveAllEventHandlers "onKeyUp";
        _control ctrlEnable false; 
        ctrlDelete _control;
    } forEach [44147,44149,44150];
    _display displayAddEventHandler ["keydown", "_this select 3"]; 
}] call BIS_fnc_addScriptedEventHandler;

// Откл. Команд в чате
showSubtitles false;
enableSentences false;

// Проверка на зевса
[] spawn { waitUntil {!isNull(findDisplay 46)}; sleep 2; player remoteExec ["AF_curatorInit",2]; };

// Установка роли для игрока
pRole = AF_PlayerRoles findIf { _x isEqualTo typeOf player};

// 3D - Иконки
_descExtPath = str missionConfigFile;
mDir = compileFinal str (_descExtPath select [0, count _descExtPath - 15]);

if (side group player isEqualTo AF_sidePlayer) then
{
    onEachFrame 
    {
        _conf = call mDir;
        {
            _pos = getPosATL ((_x select 1) select 0);
            _pos set [2,(_pos select 2) + ((_x select 1) select 1)];
            _d = player distance _pos;
            if (_d < 50) then { drawIcon3D [_conf + (_x select 0),
                    [1,1,1,2.5 - (_d * 0.05)],[_pos select 0,_pos select 1,(_pos select 2) + (_d / 30)], 3 - (0.03 * _d), 3 - (0.03 * _d), 0]; };
        } forEach AF_3DIcons;
        private _s = side group player;
        {
            if ((side group _x) isEqualTo _s && alive _x) then {
                _dist = (player distance _x) / 15;
                _color = [([playerSide,false] call BIS_fnc_sideColor),[0.227,0.773,0,1]] select (groupId (group _x) isEqualTo groupId (group player));
                if (cursorTarget != _x) then {
                    _color set [3, 1 - _dist]
                };
                drawIcon3D [
                    _conf + (AF_pIcons select (AF_PlayerRoles find typeOf _x)),
                    _color,
                    [
                        visiblePosition _x select 0,
                        visiblePosition _x select 1,
                        (visiblePosition _x select 2) +
                        ((_x modelToWorld (
                            _x selectionPosition 'head'
                        )) select 2) + 0.45 + _dist / 1.5
                    ],
                    2 - (0.1 * _dist),
                    2 - (0.1 * _dist),
                    0,
                    [name _x,format["%1 (300)",name _x]] select ((lifeState _x) isEqualTo "INCAPACITATED"),
                    2,
                    0.035,
                    'RobotoCondensedBold'
                ];
            };
        } count allPlayers - [player];
    };
};
if (side group player isEqualTo AF_sideEnemy) then
{
    onEachFrame 
    {
        private _s = side group player;
        {
            if ((side group _x) isEqualTo _s && alive _x && !isObjectHidden _x) then {
                _dist = (player distance _x) / 15;
                _color = [([playerSide,false] call BIS_fnc_sideColor),[0.227,0.773,0,1]] select (groupId (group _x) isEqualTo groupId (group player));
                if (cursorTarget != _x) then {
                    _color set [3, 1 - _dist]
                };
                drawIcon3D [
                    "",
                    _color,
                    [
                        visiblePosition _x select 0,
                        visiblePosition _x select 1,
                        (visiblePosition _x select 2) +
                        ((_x modelToWorld (
                            _x selectionPosition 'head'
                        )) select 2) + 0.45 + _dist / 1.5
                    ],
                    2 - (0.1 * _dist),
                    2 - (0.1 * _dist),
                    0,
                    [name _x,format["%1 (300)",name _x]] select ((lifeState _x) isEqualTo "INCAPACITATED"),
                    2,
                    0.035,
                    'RobotoCondensedBold'
                ];
            };
        } count allPlayers - [player];
    };
    
    // локально удалить глобальные маркеры, которые должны быть скрыты от второй стороны
    {
        deleteMarkerLocal _x;
    } forEach (allMapMarkers select { ((_x select [0,6]) isEqualTo "sqMark") || ((_x select [0,10]) isEqualTo "baseVMark_") });

    AF_ss_respAllow = true;
    AF_ss_respTime  = -1;
};

//Дебаг-инструмент: отображение всех юнитов на карте от Катлеты
if (("AF_DebKatletaShow" call BIS_fnc_getParamValue) == 1) then
{
    while { true } do 
    {
            if (!isNil "allMapMarkersKatletDebug") then
            {
                {
                    deleteMarker _x;
                } forEach allMapMarkersKatletDebug;
            };
            allMapMarkersKatletDebug = [];
            {
                private _marker = createMarker [format["%1",_x],position _x];
                _marker setMarkerShape "ICON";
                _marker setMarkerType "respawn_unknown";
                _marker setMarkerText format["%1",_x];
                allMapMarkersKatletDebug pushback _marker;
            } forEach allUnits;
            sleep 1;
    };
};

// Счетчик смертей (отображение)
disableSerialization;

46 cutRsc ["AFPoints","PLAIN",-1,false];