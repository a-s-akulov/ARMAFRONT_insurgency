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
player forceAddUniform "rhs_uniform_FROG01_wd";
for "_i" from 1 to 3 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {player addItemToUniform "rhsusf_mag_15Rnd_9x19_JHP";};
player addVest "rhsusf_spc_rifleman";
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 12 do {player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
player addItemToVest "SmokeShell";
player addHeadgear "rhsusf_lwh_helmet_marpatwd";

comment "Add weapons";
player addWeapon "rhs_weap_m4a1_carryhandle";
player addPrimaryWeaponItem "rhsusf_acc_wmx_bk";
player addPrimaryWeaponItem "rhsusf_acc_grip3";
player addWeapon "rhsusf_weap_m9";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "WhiteHead_02";
player setSpeaker "male06eng";

//AF_Saved_Loadout = getUnitLoadout player;