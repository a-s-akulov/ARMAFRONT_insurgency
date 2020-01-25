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
for "_i" from 1 to 2 do {player addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
player addVest "rhsusf_spc_mg";
for "_i" from 1 to 2 do {player addItemToVest "CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M";};
player addBackpack "rhsusf_assault_eagleaiii_coy";
for "_i" from 1 to 4 do {player addItemToBackpack "CUP_100Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M";};
for "_i" from 1 to 2 do {player addItemToBackpack "rhsusf_mag_17Rnd_9x19_JHP";};
player addHeadgear "rhsusf_lwh_helmet_marpatwd_blk_ess";

comment "Add weapons";
player addWeapon "CUP_lmg_Mk48_wdl";
player addPrimaryWeaponItem "CUP_optic_CompM2_Woodland";
player addWeapon "rhsusf_weap_glock17g4";
player addHandgunItem "acc_flashlight_pistol";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "AfricanHead_01";
player setSpeaker "male09eng";

//AF_Saved_Loadout = getUnitLoadout player;