comment "Exported from Arsenal by Dreamcast";

comment "Remove existing items";
removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;
removeUniform player;
removeVest player;
removeBackpack player;
removeHeadgear player;
removeGoggles player;

comment "Add containers";
player forceAddUniform "rhs_uniform_cu_ocp";
for "_i" from 1 to 3 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {player addItemToUniform "rhsusf_mag_15Rnd_9x19_JHP";};
player addVest "rhsusf_iotv_ocp_Squadleader";
player addItemToVest "SmokeShellGreen";
player addItemToVest "SmokeShellRed";
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 10 do {player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "Chemlight_blue";};
player addHeadgear "rhsusf_ach_helmet_headset_ess_ocp";

comment "Add weapons";
player addWeapon "rhs_weap_m4a1_carryhandle";
player addPrimaryWeaponItem "rhsusf_acc_wmx_bk";
player addWeapon "rhsusf_weap_m9";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "GreekHead_A3_07";
player setSpeaker "male07eng";


//AF_Saved_Loadout = getUnitLoadout player;