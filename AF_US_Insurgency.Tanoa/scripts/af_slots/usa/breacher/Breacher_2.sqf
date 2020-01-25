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
player addVest "V_PlateCarrierSpec_rgr";
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_mk84";};
for "_i" from 1 to 8 do {player addItemToVest "rhsusf_8Rnd_00Buck";};
player addHeadgear "rhsusf_ach_helmet_M81";

comment "Add weapons";
player addWeapon "rhs_weap_M590_8RD";
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
player setFace "WhiteHead_21";
player setSpeaker "male12eng";

//AF_Saved_Loadout = getUnitLoadout player;