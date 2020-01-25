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
player forceAddUniform "rhs_uniform_g3_m81";
for "_i" from 1 to 3 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {player addItemToUniform "rhsusf_mag_15Rnd_9x19_JHP";};
player addVest "V_PlateCarrierIAGL_oli";
for "_i" from 1 to 9 do {player addItemToVest "CUP_30Rnd_556x45_Stanag";};
for "_i" from 1 to 6 do {player addItemToVest "CUP_1Rnd_HE_M203";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
player addHeadgear "rhsusf_ach_helmet_M81";

comment "Add weapons";
player addWeapon "CUP_arifle_Mk16_CQC_EGLM_black";
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
player setFace "WhiteHead_09";
player setSpeaker "male09eng";

//AF_Saved_Loadout = getUnitLoadout player;
