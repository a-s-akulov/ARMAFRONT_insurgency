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
player addVest "rhsusf_iotv_ocp_Medic";
for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 9 do {player addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";};
player addBackpack "rhsusf_falconii_mc";
player addItemToBackpack "Medikit";
for "_i" from 1 to 5 do {player addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 5 do {player addItemToBackpack "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShellOrange";};
for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShellRed";};
player addHeadgear "rhsusf_ach_helmet_ocp";

comment "Add weapons";
player addWeapon "rhs_weap_hk416d10";
player addPrimaryWeaponItem "rhsusf_acc_M952V";
player addPrimaryWeaponItem "rhsusf_acc_T1_low";
player addWeapon "rhsusf_weap_m9";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "WhiteHead_13";
player setSpeaker "male11eng";

//AF_Saved_Loadout = getUnitLoadout player;