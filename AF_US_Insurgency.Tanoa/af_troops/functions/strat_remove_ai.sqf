_marker			= _this select 0;
_trigger		= _this select 1;
_units			= _this select 2;
_debug			= _this select 3;

_WIN			= param [4,false];

_unitsAlive		= 0;
_stWepsAlive 	= [];
_haVehAlive		= [];
_stWeps			= _trigger getVariable "stWeps";
_heli			= _trigger getVariable "heli";
_haVeh			= _trigger getVariable "hArmor";
_supVeh			= _trigger getVariable "SUP_VEH_DESTROYED";

// удаление пехов противника
{
	_unitsAlive = _unitsAlive + ({ alive _x } count (units _x));
	{ if (_x in allPlayers) then { _x remoteExec ['forceRespawn',_x]; }; deleteVehicle _x; } forEach units _x;
	deleteGroup _x;
} forEach _units;



// Удаление Тяжелой техники противника

if (!isNil "_haVeh") then
{
	{
		if (alive _x) then
		{
			_haVehAlive pushBack (typeOf _x);
		};
		deleteVehicle _x;
	} forEach _haVeh;
	_trigger setVariable ["hArmor",_haVehAlive];
};


// удаление штабных статиков и всех временных объектов

{ deleteVehicle _x; } forEach (_trigger getVariable "stTemp");



// удаление машины поддержки (трофей которая)
if (!(isNil "_supVeh") && { !(_supVeh isEqualTo true) }) then
{
	_trigger setVariable ["SUP_VEH_DESTROYED",( [true,nil] select (alive _supVeh) )];
	if ((crew _supVeh) isEqualTo [] && !_WIN) then { deleteVehicle _supVeh; };
	if _WIN then { AF_vehRespawnArr pushBack _supVeh; };
};

{ if _WIN then { _x removeEventHandler ["killed",_x getVariable "handler"]; }; _x allowDamage false; } forEach (_trigger getVariable "stratObjects");

_trigger setVariable ["counter",_unitsAlive];
AF_ActStrat = AF_ActStrat - 1;
AF_activatedMrkrs	deleteAt (AF_activatedMrkrs find _marker);
publicVariable		"AF_activatedMrkrs";
_marker setMarkerAlpha 0;



if (_debug) then { private _markerDeb = format["%1_debug",_marker]; _markerDeb setMarkerText format["Стратегическая зона деактивирована, юниты удалены. Живых юнитов оставалось: %1 штук целых тяж. машин: %4 || Зона: ""%6""",_unitsAlive,count _haVehAlive,_marker]; };