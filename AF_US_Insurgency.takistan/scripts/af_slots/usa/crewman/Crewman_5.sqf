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
player forceAddUniform "rhs_uniform_acu_ucp";
for "_i" from 1 to 3 do {player addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {player addItemToUniform "rhsusf_mag_15Rnd_9x19_JHP";};
player addVest "V_TacVest_khk";
for "_i" from 1 to 8 do {player addItemToVest "30Rnd_9x21_Mag_SMG_02";};
player addItemToVest "SmokeShellBlue";
player addItemToVest "rhs_mag_m67";
player addHeadgear "rhsusf_cvc_ess";

comment "Add weapons";
player addWeapon "SMG_05_F";
player addWeapon "rhsusf_weap_m9";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "AfricanHead_02";
player setSpeaker "male09eng";

//AF_Saved_Loadout = getUnitLoadout player;