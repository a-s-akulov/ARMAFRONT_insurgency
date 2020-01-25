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
player addItemToUniform "30Rnd_556x45_Stanag";
player addVest "rhsusf_spc_patchless";
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_an_m14_th3";};
for "_i" from 1 to 8 do {player addItemToVest "30Rnd_556x45_Stanag";};
player addBackpack "rhsusf_assault_eagleaiii_coy";
player addItemToBackpack "ToolKit";
player addItemToBackpack "MineDetector";
for "_i" from 1 to 2 do {player addItemToBackpack "DemoCharge_Remote_Mag";};
for "_i" from 1 to 2 do {player addItemToBackpack "APERSMine_Range_Mag";};
player addHeadgear "rhsusf_lwh_helmet_marpatwd_headset";

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
player setFace "WhiteHead_18";
player setSpeaker "male10eng";

//AF_Saved_Loadout = getUnitLoadout player;
