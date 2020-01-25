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
player forceAddUniform "U_B_PilotCoveralls";
for "_i" from 1 to 2 do {player addItemToUniform "FirstAidKit";};
player addItemToUniform "SmokeShellGreen";
player addItemToUniform "SmokeShellRed";
for "_i" from 1 to 2 do {player addItemToUniform "rhsusf_mag_15Rnd_9x19_FMJ";};
player addItemToUniform "rhs_mag_nspn_green";
player addItemToUniform "B_IR_Grenade";
player addBackpack "B_Parachute";
player addHeadgear "H_PilotHelmetFighter_B";

comment "Add weapons";
player addWeapon "rhsusf_weap_m9";

comment "Add items";
player linkItem "ItemMap";
player linkItem "ItemCompass";
player linkItem "ItemWatch";
player linkItem "ItemRadio";
player linkItem "ItemGPS";

comment "Set identity";
player setFace "WhiteHead_15";
player setSpeaker "male01eng";

//AF_Saved_Loadout = getUnitLoadout player;
