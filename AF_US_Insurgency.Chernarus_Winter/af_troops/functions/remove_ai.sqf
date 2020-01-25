_marker			= _this select 0;
_trigger		= _this select 1;
_units			= _this select 2;
_unitsCiv		= _this select 3;
_unitsAnim		= _this select 4;
_debug			= _this select 5;

_unitsAlive		= 0;
_stWepsAlive 	= [];
_stWeps			= _trigger getVariable "stWeps";

// удаление пехов противника
{
	_unitsAlive = _unitsAlive + ({ alive _x } count (units _x));
	{ if (_x in allPlayers) then { _x remoteExec ['forceRespawn',_x]; }; deleteVehicle _x; } forEach units _x;
	deleteGroup _x;
} forEach _units;

// удаление стационаров противника
if (!isNil "_stWeps") then
{
	{
		if (alive _x) then
		{
			_stWepsAlive pushBack (typeOf _x);
		};
		deleteVehicle _x;
	} forEach _stWeps;
	_trigger setVariable ["stWeps",_stWepsAlive];
};

// удаление гражданских
{
	{ deleteVehicle _x; } forEach units _x;
	deleteGroup _x;
} forEach _unitsCiv;

// удаление животных
{
	deleteVehicle _x;
} forEach _unitsAnim;

_trigger setVariable ["counter",_unitsAlive];

AF_ActTrgrs = AF_ActTrgrs - 1;
AF_activatedMrkrs	deleteAt (AF_activatedMrkrs find _marker);
publicVariable		"AF_activatedMrkrs";
_marker setMarkerAlpha 0;

if (_debug) then { private _markerDeb = format["%1_debug",_marker]; _markerDeb setMarkerText format["Зона деактивирована, юниты удалены. Живых юнитов оставалось: %1 штук, целых стационаров: %2 единиц || Зона: ""%3""",_unitsAlive,count _stWepsAlive,_marker]; };