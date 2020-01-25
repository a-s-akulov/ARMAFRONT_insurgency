/*
	by KOKaKOJIbKA
*/
player addAction ["<t color='#e60000'>механик водитель</t>",{
	private _player = _this select 0; 
	private _vehicle = (vehicle _player);

	_player setVariable ["add_driver",true];
	private _ai = createAgent [typeOf _player, [0,0,0], [], 0, "NONE"];

	_ai allowDamage false;
	_ai moveInDriver _vehicle;

	uiSleep 1;

	waitUntil {(isNull objectParent _player) || (isNull objectParent _ai) || (!alive _vehicle) || (!alive _player) || ({alive _x} count (crew _vehicle) < 2)};

	_ai action ["EngineOff", (vehicle _ai)];
	deleteVehicle _ai;
	_player setVariable ["add_driver",nil];

},[], 0, false, true, "", "(isNil {player getVariable ""add_driver""}) && (alive player) && (gunner (vehicle player) isEqualTo player) && (speed player < 1) && (!isNull objectParent player) && (vehicle player isKindOf ""Tank"" || vehicle player isKindOf ""Wheeled_APC_F"")"];
