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
for "_i" from 1 to 2 do {player addItemToUniform "rhsusf_mag_17Rnd_9x19_JHP";};
player addVest "rhsusf_iotv_ocp_SAW";
for "_i" from 1 to 4 do {player addItemToVest "rhsusf_100Rnd_762x51";};
player addBackpack "rhsusf_assault_eagleaiii_ocp";
for "_i" from 1 to 4 do {player addItemToBackpack "rhsusf_100Rnd_762x51";};
for "_i" from 1 to 4 do {player addItemToBackpack "rhsusf_mag_17Rnd_9x19_JHP";};
player addHeadgear "rhsusf_ach_helmet_ESS_ocp";

comment "Add weapons";
player addWeapon "rhs_weap_m240G";
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
player setFace "WhiteHead_11";
player setSpeaker "male05eng";

//AF_Saved_Loadout = getUnitLoadout player;