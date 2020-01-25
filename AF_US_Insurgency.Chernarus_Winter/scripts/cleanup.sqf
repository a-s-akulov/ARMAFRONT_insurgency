//author: SOLDAT1C
//Modified: KOKaKOJIbKA + Katletka
private ["_all_groups","_m","_removeGrp","_members"];
_all_groups = allGroups;


for "_m" from 0 to ((count _all_groups) - 1) do {
	_removeGrp = true;
	_groupoup = (_all_groups select _m);

	if (!isNull _groupoup) then {
		_members = (units _groupoup);
		{
			if (alive _x) then {
				_removeGrp = false;
			};
		} forEach _members;
	};

	if (_removeGrp && !isNull _groupoup) then {
		deleteGroup _groupoup;
	};
};

{
	deleteVehicle _x;
} forEach allMissionObjects "WeaponHolder","GroundWeaponHolder","WeaponHolderSimulated";

{deleteVehicle _x} forEach (allDead - AF_vehRespawnArr);

AF_vehRespawnArr = AF_vehRespawnArr - (AF_vehRespawnArr select {!alive _x});

private ["_deleteVehlist","_center"];

_deleteVehlist = AF_deleteVehlist;
_center        = AF_centerPos;

{
	private "_freeGunnerPositions";
	_freeGunnerPositions = _x emptyPositions "Gunner";
	if ((_x distance _center < 8000) && ((typeOf _x) in _deleteVehlist) && (_freeGunnerPositions > 0)) then {
		deleteVehicle _x;
	};
} forEach Vehicles;

if !(isNull arsenal_box) then
{
	clearItemCargoGlobal arsenal_box;
	clearWeaponCargoGlobal arsenal_box;
	clearBackpackCargoGlobal arsenal_box;
	clearMagazineCargoGlobal arsenal_box;
};

sleep 900;
_clean = [] execVM "scripts\cleanUp.sqf";