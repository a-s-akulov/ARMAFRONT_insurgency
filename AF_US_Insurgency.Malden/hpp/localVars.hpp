if (isNil "sqArray") then { sqArray = []; };
earplugs            = false;

AF_question			= compile preprocessFileLineNumbers "scripts\af_questWindow\af_questWin.sqf";
AF_Slots_Switcher 	= compile preprocessFileLineNumbers "scripts\af_slots\AF_Slots_Function.sqf";
KOKa_fnc_addDriver 	= compile preprocessFileLineNumbers "scripts\fn_addDriver.sqf";
fn_Crew_Hud         = compile preprocessFileLineNumbers "scripts\fn_crewHud.sqf";
Bee_earplugs        = compile preprocessFileLineNumbers "scripts\bee_earplugs.sqf";
AF_weapsBack        = compile preprocessFileLineNumbers "scripts\weaps_back.sqf";
AF_hintPicture      = compile preprocessFileLineNumbers "scripts\hint_with_picture.sqf";
AF_statIGUI         = compile preprocessFileLineNumbers "scripts\setStatIGUI.sqf";
AF_Sside_pRespawn   = compile preprocessFileLineNumbers "scripts\sside_prespawn.sqf";
AF_timer            = compile preprocessFileLineNumbers "scripts\af_timer.sqf";

AF_admins = ["76561198018837250","76561197996339648"]; // steamID администрации
AF_3DIcons =
[
    ["pictures\3d_icons\ammo.paa",[arsenal_box,1.8]], // арсенал
    ["pictures\3d_icons\medical_tent.paa",[AF_baseHospital,3]], // медпункт
    ["pictures\3d_icons\repair.paa",[BeeRepairZone,4]], // СТО авто
    ["pictures\3d_icons\repair.paa",[zlo_marker_repairStation,5]], // СТО самолетов
    ["pictures\3d_icons\repair.paa",[zlo_marker_repairStation_1,5]], // СТО самолетов 2
    ["pictures\3d_icons\wheel-icon.paa",[AF_baseGarage_1,2]], // Гараж Авто
    ["pictures\3d_icons\wheel-icon.paa",[AF_baseGarage_2,2]] // Гараж Авто 2
];
AF_PlayerRoles =
[
    "rhsusf_army_ocp_squadleader",      // SquadLeader      || 0
    "rhsusf_army_ocp_medic",            // Medic            || 1
    "rhsusf_army_ocp_engineer",         // Egineer          || 2
    "rhsusf_army_ocp_grenadier",        // Grenadier        || 3
    "rhsusf_army_ocp_machinegunner",    // Machinegunner    || 4
    "rhsusf_army_ocp_sniper",           // Sniper           || 5
    "rhsusf_army_ocp_rifleman",         // Rifleman         || 6
    "rhsusf_army_ocp_rifleman_m590",    // Breacher         || 7
    "rhsusf_army_ocp_crewman",          // Crewman          || 8
    "rhsusf_airforce_pilot"             // Pilot            || 9
];

AF_pIcons =                             // расположения иконок в папках в соответствии с ролями выше  
[
    "pictures\3d_icons\com.paa",        // SquadLeader      || 0
    "pictures\3d_icons\medic.paa",      // Medic            || 1
    "pictures\3d_icons\engineer.paa",   // Egineer          || 2
    "pictures\3d_icons\GL.paa",         // Grenadier        || 3
    "pictures\3d_icons\minigunner.paa", // Machinegunner    || 4
    "pictures\3d_icons\sniper.paa",     // Sniper           || 5
    "pictures\3d_icons\soldier.paa",    // Rifleman         || 6
    "pictures\3d_icons\soldier.paa",    // Breacher         || 7
    nil,                                // Crewman          || 8
    nil                                 // Pilot            || 9
];