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
player forceAddUniform "U_B_HeliPilotCoveralls";
for "_i" from 1 to 4 do {player addItemToUniform "FirstAidKit";};
player addItemToUniform "SmokeShellGreen";
player addItemToUniform "SmokeShellRed";
player addVest "V_TacVest_oli";
for "_i" from 1 to 3 do {player addItemToVest "CUP_30Rnd_9x19_MP5";};
for "_i" from 1 to 2 do {player addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {player addItemToVest "Chemlight_green";};
for "_i" from 1 to 2 do {player addItemToVest "rhs_mag_nspn_green";};
for "_i" from 1 to 2 do {player addItemToVest "rhsusf_mag_15Rnd_9x19_JHP";};
player addHeadgear "rhsusf_hgu56p";

comment "Add weapons";
player addWeapon "CUP_smg_MP5A5";
player addWeapon "rhsusf_weap_m9";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";
player linkItem "NVGoggles_OPFOR";

comment "Set identity";
player setFace "WhiteHead_15";
player setSpeaker "male10eng";

//AF_Saved_Loadout = getUnitLoadout player;