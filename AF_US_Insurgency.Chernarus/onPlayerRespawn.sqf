// Инициализация зевса после смерти
[] spawn { sleep 4; if (!isNil "pIsCurator") then { player remoteExec["AF_curatorRespawn",2]; }; };
// ниже - клин оружия
player addAction ["", {
	playSound3D ['a3\sounds_f\weapons\Other\dry9.wss', (_this select 0)];
}, "", 0, false, true, "DefaultAction", "isNil {player getVariable ""KOKa_allowFire""} && (primaryWeapon player isEqualTo currentWeapon player) && (isNull objectParent player)"];
 
// функции респа для 2й стороны
if (AF_sideEnemy isEqualTo side group player && isNil "AF_firestResawn") exitWith { [] spawn AF_Sside_pRespawn; };

if !(isNil "AF_Saved_Loadout") then { player setUnitLoadout AF_Saved_Loadout; };
[player,["Marker_RepairST","Marker_RepairST2"],20] spawn zlo_fnc_CreateZone;
if (!isNil "AFgrlp") then // удаление точки респа после каждого возрожения - при смерти создается новая
{ 
	AFgrlp call BIS_fnc_removeRespawnPosition; 
	AFgrlp = nil;
};
if (pRole isEqualTo 0) then { player addAction[format["<t color='#ff9900'>%1</t>",localize "RallypointCreate"], "scripts\af_groups_spawn\AF_Groups_Spawn.sqf",[],7,false,true,"","(isNull objectParent player)",0]; };
// мех-вод в танки админам
if ((getPlayerUID player in AF_admins) && (pRole isEqualTo 8)) then {
		[player] spawn KOKa_fnc_addDriver;
	};
// выдача терминала и хака пчеле
if ((getPlayerUID player) isEqualTo "76561198158341391") then 
{
	player linkItem "B_UavTerminal";
	removeBackpack player;
	player addBackpack "B_UGV_02_Demining_backpack_F";
	player setUnitTrait ["UAVHacker",1];
};

// чтоб народ не превращался в enemy
player addRating 9999999;