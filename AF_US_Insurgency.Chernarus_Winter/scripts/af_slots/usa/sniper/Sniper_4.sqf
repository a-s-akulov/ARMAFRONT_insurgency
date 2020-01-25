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
for "_i" from 1 to 2 do {player addItemToUniform "11Rnd_45ACP_Mag";};
player addVest "rhsusf_spc_marksman";
for "_i" from 1 to 2 do {player addItemToVest "11Rnd_45ACP_Mag";};
for "_i" from 1 to 15 do {player addItemToVest "rhsusf_5Rnd_300winmag_xm2010";};
for "_i" from 1 to 4 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
player addHeadgear "rhs_booniehat2_marpatwd";

comment "Add weapons";
player addWeapon "rhs_weap_XM2010";
player addPrimaryWeaponItem "rhsusf_acc_anpeq15side_bk";
player addPrimaryWeaponItem "rhsusf_acc_LEUPOLDMK4_2";
player addPrimaryWeaponItem "rhsusf_acc_harris_bipod";
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
player setFace "Sturrock";
player setSpeaker "male02eng";

//AF_Saved_Loadout = getUnitLoadout player;
