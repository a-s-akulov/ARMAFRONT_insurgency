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
player addItemToUniform "30Rnd_556x45_Stanag";
player addVest "V_TacVestIR_blk";
for "_i" from 1 to 3 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 9 do {player addItemToVest "30Rnd_556x45_Stanag";};
player addBackpack "B_AssaultPack_rgr";
player addItemToBackpack "Medikit";
for "_i" from 1 to 5 do {player addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 5 do {player addItemToBackpack "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShellOrange";};
for "_i" from 1 to 2 do {player addItemToBackpack "SmokeShellRed";};
player addHeadgear "rhsusf_ach_helmet_M81";

comment "Add weapons";
player addWeapon "arifle_Mk20C_plain_F";
player addPrimaryWeaponItem "acc_flashlight";
player addPrimaryWeaponItem "optic_Aco";
player addWeapon "rhsusf_weap_m9";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "WhiteHead_14";
player setSpeaker "male11eng";

//AF_Saved_Loadout = getUnitLoadout player;
