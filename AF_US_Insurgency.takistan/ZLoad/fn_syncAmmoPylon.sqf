_veh = _this select 0;
_zlo_slot = _this select 1;
uiSleep 1;
_magsCurrent = getPylonMagazines _veh;
_pylonWeapons =[];
_counter = 0;
{
	if(_zlo_slot select _counter isEqualTo -1)then
	{/*
		//_ammoz = _veh ammoOnPylon (_counter+1);
		_veh setPylonLoadOut [_counter+1,_x,false,[]];
		_ammoz = _veh ammoOnPylon (_counter+1);
		//systemChat format["Хреново тауча : %1",_x];
		_veh setAmmoOnPylon [_counter+1, _ammoZ];*/
	};
	if(_zlo_slot select _counter isEqualTo 0)then
	{/*
		_ammoz = _veh ammoOnPylon (_counter+1);
		_veh setPylonLoadOut [_counter+1,_x,false,[0]];
		_veh setAmmoOnPylon [_counter+1, _ammoZ];*/
	};
	_counter = _counter + 1;
	_pylonWeapons pushBack	getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon");
} forEach _magsCurrent;


//_veh addMagazineTurret
// 0 1

/*
if (_vehicle getVariable "RIP_VehicleServicing") then {
        if (isNil {_vehicle getVariable "RIP_VehicleMags"}) then {
            _allMags = magazinesAllTurrets _vehicle;
            _pilonMags = getPylonMagazines _vehicle;
            _mags = [];
            {
                if !((_x select 0) in _pilonMags)  then {
                    _vehicle removeMagazinesTurret [(_x select 0),(_x select 1)];
                    _mags pushBack [(_x select 0),(_x select 1)];
                };
                true
            } count _allMags;
            _vehicle setVariable ["RIP_VehicleMags",_mags,true];
            _vehicle setVariable ["RIP_VehiclePilonsMags",_pilonMags,true];
        };

        switch (true) do {
            case (_vehicle isKindOf "Air"): { _timer = 600 };
            case (getNumber(configFile >> "CfgVehicles" >> typeOf _vehicle >> "artilleryScanner") isEqualTo 1): { _timer = 600 };
            default { _timer = 60 };
        };
        systemChat format[localize "STR_RIP_HINT_TIMEREAMMO",_vehname,_timer];
        _endtime = time + _timer;

        waitUntil { uisleep 0.1; ((time > _endtime) || !(_vehicle getVariable "RIP_VehicleServicing")) };

        if (_vehicle getVariable "RIP_VehicleServicing") then {
            {_vehicle addMagazineTurret [(_x select 0),(_x select 1)]} forEach (_vehicle getVariable "RIP_VehicleMags");
            {
                _ammocount = getNumber (configfile >> "CfgMagazines" >> _x >> "count");
                _vehicle SetAmmoOnPylon [_forEachIndex+1, _ammocount];
            } forEach (_vehicle getVariable "RIP_VehiclePilonsMags");
            _vehicle setVariable ["RIP_VehicleMags", nil, true];
            _vehicle setVariable ["RIP_VehiclePilonsMags", nil, true];
            systemChat format[localize "STR_RIP_HINT_REAMMOEND",_vehname];
        };
    };
	*/

	/*
	[["rhs_mag_gsh30_mixed_150",[-1],150,1.00001e+007,2],["60Rnd_CMFlare_Chaff_Magazine",[-1],60,1.00001e+007,2],["rhs_mag_R27ER_APU470",[-1],1,1.00004e+007,2],["rhs_mag_R27ER_APU470",[-1],1,1.00004e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00004e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00004e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00004e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00004e+007,2]]
	[["rhs_mag_gsh30_mixed_150",[-1],150,1.00001e+007,2],["60Rnd_CMFlare_Chaff_Magazine",[-1],60,1.00001e+007,2],["rhs_mag_R27ER_APU470",[-1],1,1.00001e+007,2],["rhs_mag_R27ER_APU470",[-1],1,1.00001e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00001e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00001e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00001e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00001e+007,2]]
	[["rhs_mag_gsh30_mixed_150",[-1],124,1.00001e+007,2],["60Rnd_CMFlare_Chaff_Magazine",[-1],60,1.00001e+007,2],["rhs_mag_R27ER_APU470",[-1],1,1.00007e+007,2],["rhs_mag_R27ER_APU470",[-1],1,1.00007e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00007e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00007e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00007e+007,2],["rhs_mag_R73M_APU73",[-1],1,1.00007e+007,2]]
	*/