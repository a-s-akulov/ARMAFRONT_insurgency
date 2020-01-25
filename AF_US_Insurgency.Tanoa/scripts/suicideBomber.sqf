//Created by Zooloo75/Stealthstick
//Modified : KOKaKOJIbKA(2015)Katletka(2018-2019),Пчёлка=Ъ(2018-2019)

private ["_bomber","_targetSide","_explosiveClass"];

_bomber = _this select 0;
_targetSide = _this select 1;
_explosiveClass = _this select 2;
_info = [_bomber,_targetSide,_explosiveClass];
_runCode = 1;

while {alive _bomber && _runCode == 1} do
{
	_nearUnits = nearestObjects [_bomber,["CAManBase"],70];
	_nearUnits = _nearUnits - [_bomber];
	{
		if(!(side _x in _targetSide)) then {_nearUnits = _nearUnits - [_x];};
	} forEach _nearUnits;
	_nearCars = nearestObjects[_bomber,["LandVehicle"],70];
	_nearCars = _nearCars - [_bomber];
	{
		if(!(side _x in _targetSide)) then {_nearCars = _nearCars - [_x];};
	} forEach _nearCars;
	if(count _nearUnits != 0 or count _nearCars != 0) then
	{
		if(count _nearCars > 0) then
		{
			_nearUnits = _nearCars;
		};
		_pos = position (_nearUnits select 0);
		_bomber SetUnitPos "UP";
		_bomber setSkill ["endurance", 1];
		_bomber setSkill ["spotTime", 0.8];
		_bomber setSkill ["courage", 1];
		_bomber setSkill ["spotDistance", 1];
		_bomber allowFleeing 0;
		_bomber disableAI "AUTOTARGET";
		_bomber disableAI "FSM";
		_bomber doMove _pos;
		waitUntil {_bomber distance _pos < 20 or (_bomber distance _pos < 30 && (vehicle player) != player) isEqualTo true};
		if(_bomber distance (_nearUnits select 0) < 15) exitWith {
			_runCode = 0;
			_explosive = _explosiveClass createVehicle (position _bomber);
			[_bomber,_explosive] spawn 
			{
				_bomber = _this select 0;
				_explosive = _this select 1; 
				sleep 5;
				if(alive _bomber) then { _bomb = "Bo_GBU12_LGB" createVehicle(position _bomber); _bomb setDamage 1;/*[[position _bomber,2],"CREATE_EFFECT",true,false] call BIS_fnc_MP;*/};
				_bomber addRating -10000000;
			};
			[_explosive,_bomber] spawn {_explosive = _this select 0; _bomber = _this select 1; waitUntil {!alive _bomber}; deleteVehicle _explosive;};
			_explosive setVectorDirAndUp [ [1, 0, 0], [0, 1, 0] ];
			_explosive attachTo [_bomber,[0,0.13,0.25],"Pelvis"];
			_rbSay = format ["akbar_%1",ceil(random(5))];
			private _plrs = allPlayers select { (_x distance _bomber) < 70; };
			[_bomber,_rbSay] remoteExec ["say3D",_plrs];
		};
	};
	sleep 1;
};

