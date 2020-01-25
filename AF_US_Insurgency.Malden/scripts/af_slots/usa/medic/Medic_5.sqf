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
player addVest "rhsusf_iotv_ocp_Medic";
for "_i" from 1 to 9 do {player addItemToVest "CUP_30Rnd_556x45_Stanag";};
player addBackpack "rhsusf_falconii_mc";
player addItemToBackpack "Medikit";
for "_i" from 1 to 10 do {player addItemToBackpack "FirstAidKit";};
player addHeadgear "rhsusf_ach_helmet_ocp";

comment "Add weapons";
player addWeapon "CUP_arifle_Mk16_CQC_black";
player addPrimaryWeaponItem "rhsusf_acc_wmx_bk";
player addPrimaryWeaponItem "optic_Holosight";
player addWeapon "rhsusf_weap_m9";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "WhiteHead_06";
player setSpeaker "male05eng";

//AF_Saved_Loadout = getUnitLoadout player;