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
player addItemToVest "SmokeShell";
for "_i" from 1 to 12 do {player addItemToVest "30Rnd_556x45_Stanag";};
player addHeadgear "rhsusf_lwh_helmet_marpatwd";

comment "Add weapons";
player addWeapon "CUP_arifle_Mk16_SV_black";
player addPrimaryWeaponItem "rhsusf_acc_wmx_bk";
player addPrimaryWeaponItem "rhsusf_acc_eotech_xps3";
player addWeapon "rhsusf_weap_m9";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "GreekHead_A3_08";
player setSpeaker "male08eng";

//AF_Saved_Loadout = getUnitLoadout player;