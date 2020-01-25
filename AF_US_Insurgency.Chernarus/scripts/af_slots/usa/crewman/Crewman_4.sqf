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
player addVest "V_TacVest_khk";
player addItemToVest "SmokeShellBlue";
player addItemToVest "rhs_mag_m67";
for "_i" from 1 to 9 do {player addItemToVest "rhsusf_mag_40Rnd_46x30_AP";};
player addHeadgear "rhsusf_cvc_green_ess";

comment "Add weapons";
player addWeapon "rhsusf_weap_MP7A2";
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
player setFace "WhiteHead_07";
player setSpeaker "male02eng";

//AF_Saved_Loadout = getUnitLoadout player;
