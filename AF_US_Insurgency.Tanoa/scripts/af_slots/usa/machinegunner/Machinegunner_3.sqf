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
for "_i" from 1 to 2 do {player addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
player addVest "CUP_V_O_Ins_Carrier_Rig_MG";
for "_i" from 1 to 4 do {player addItemToVest "rhs_mag_100Rnd_556x45_M855A1_cmag_mixed";};
player addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";
player addBackpack "B_Carryall_oli";
for "_i" from 1 to 4 do {player addItemToBackpack "rhs_mag_100Rnd_556x45_M855A1_cmag_mixed";};
for "_i" from 1 to 3 do {player addItemToBackpack "rhsusf_mag_17Rnd_9x19_JHP";};
player addHeadgear "rhsusf_ach_helmet_M81";

comment "Add weapons";
player addWeapon "rhs_weap_m27iar";
player addPrimaryWeaponItem "rhsusf_acc_SF3P556";
player addPrimaryWeaponItem "rhsusf_acc_M952V";
player addPrimaryWeaponItem "rhsusf_acc_g33_xps3";
player addPrimaryWeaponItem "rhsusf_acc_harris_bipod";
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
player setFace "GreekHead_A3_06";
player setSpeaker "male12eng";

//AF_Saved_Loadout = getUnitLoadout player;