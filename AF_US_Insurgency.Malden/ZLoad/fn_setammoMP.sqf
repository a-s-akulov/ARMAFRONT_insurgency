_veh = _this select 0;
_zlo_slots = _this select 1;

		uiSleep 0.5;
if(local _veh) then{
	
	_veh setVehicleAmmo 1; 
	[1, "setVehicleAmmo", _veh, true, false,false] call BIS_fnc_MP;
	_times = 0;
	while {_times <= 10} do {
		uiSleep 0.2;
		_veh setVehicleAmmo 1; 
		[1, "setVehicleAmmo", _veh, true, false,false] call BIS_fnc_MP;

		_times = _times + 1;
	};
	};
/*
_allMags = magazinesAllTurrets _veh;
copyToClipboard format["%1",_allMags];
_veh removeMagazinesTurret [((_allMags select 0) select 0),[-1]];
_veh removeMagazinesTurret [((_allMags select 1) select 0),[-1]];
uisleep 0.2;
_cx1 = getNumber (configfile >> "CfgMagazines" >> ((_allMags select 0) select 0) >> "count");
_cx2 = getNumber (configfile >> "CfgMagazines" >> ((_allMags select 1) select 0) >> "count");
_veh addMagazineTurret[((_allMags select 0)select 0),[-1],_cx1];
_veh addMagazineTurret[((_allMags select 1)select 0),[-1],_cx2];
*/