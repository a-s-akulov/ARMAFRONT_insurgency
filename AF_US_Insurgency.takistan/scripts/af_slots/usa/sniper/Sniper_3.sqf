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
for "_i" from 1 to 2 do {player addItemToUniform "11Rnd_45ACP_Mag";};
player addVest "rhsusf_iotv_ocp_Rifleman";
for "_i" from 1 to 4 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 10 do {player addItemToVest "CUP_5Rnd_762x67_G22";};
for "_i" from 1 to 2 do {player addItemToVest "11Rnd_45ACP_Mag";};
player addHeadgear "rhsusf_ach_helmet_camo_ocp";

comment "Add weapons";
player addWeapon "CUP_srifle_G22_des";
player addPrimaryWeaponItem "CUP_optic_LeupoldMk4_MRT_tan";
player addPrimaryWeaponItem "CUP_bipod_VLTOR_Modpod";
player addWeapon "hgun_Pistol_heavy_01_F";
player addHandgunItem "muzzle_snds_acp";
player addHandgunItem "acc_flashlight_pistol";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "WhiteHead_16";
player setSpeaker "male03eng";

//AF_Saved_Loadout = getUnitLoadout player;