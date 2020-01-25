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
player addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";
player addVest "CUP_V_O_Ins_Carrier_Rig_MG";
for "_i" from 1 to 6 do {player addItemToVest "rhsusf_mag_17Rnd_9x19_JHP";};
for "_i" from 1 to 3 do {player addItemToVest "rhsusf_100Rnd_556x45_soft_pouch";};
player addBackpack "B_Carryall_oli";
for "_i" from 1 to 4 do {player addItemToBackpack "rhsusf_100Rnd_556x45_soft_pouch";};
player addHeadgear "rhsusf_ach_helmet_M81";

comment "Add weapons";
player addWeapon "rhs_weap_m249_pip";
player addPrimaryWeaponItem "rhsusf_acc_SF3P556";
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
player setFace "Barklem";
player setSpeaker "male12eng";

//AF_Saved_Loadout = getUnitLoadout player;