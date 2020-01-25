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
player addVest "V_PlateCarrierSpec_mtp";
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 4 do {player addItemToVest "rhs_mag_mk84";};
for "_i" from 1 to 10 do {player addItemToVest "CUP_15Rnd_9x19_M9";};
player addHeadgear "rhsusf_ach_helmet_headset_ess_ocp";

comment "Add weapons";
player addWeapon "CUP_hgun_BallisticShield_Armed";
player addWeapon "Rangefinder";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "WhiteHead_14";
player setSpeaker "male04eng";

//AF_Saved_Loadout = getUnitLoadout player;