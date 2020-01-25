// By Katletka
private _AF_check_pilot  = AF_PlayerRoles select 9; // тип юнита - пилот
private _AF_check_crew   = AF_PlayerRoles select 8; // тип юнита - член экипажа
private _str = localize "VR_VehInfo";
private _vehLockCheck = localize "VehLockCheck";

0 = player addEventHandler ["GetInMan",format[
"
	scopeName 'main';
	private _vehicle = _this select 0;
	private _str = ""%4"";
	if (( !(typeOf player isEqualTo ""%1"") && vehicle _vehicle isKindOf ""Air"" ) || ( !(typeOf player isEqualTo ""%2"") && ( (vehicle _vehicle isKindOf ""Tank"" || vehicle _vehicle isKindOf ""Wheeled_APC_F"") ) )) then 
	{
		if ((player == driver vehicle _vehicle) || (player == vehicle _vehicle turretUnit [0]) || (player == commander vehicle _vehicle)) then 
		{
			player action [""GetOut"", vehicle _vehicle];
			hint parseText ""<br/><img size='3' color='#595923' align='center' image='pictures\hint_pic\lock.paa' /><br/><br/>
			<t size='1.2' color='#99ffffff' >%3</t><br/><br/>"";
			breakOut 'main';
		};
	};
	[_str] spawn
	{
		sleep 1;
		if (!isNull(findDisplay 11400)) then { waitUntil {sleep 1; isNull(findDisplay 11400)}; sleep 5;};
		hintSilent parseText (_this select 0);
	};
",_AF_check_pilot,_AF_check_crew,_vehLockCheck,_str]];
0 = player addEventHandler ["SeatSwitchedMan",format[
"
	private _vehicle = _this select 2;
	if (( !(typeOf player isEqualTo ""%1"") && vehicle _vehicle isKindOf ""Air"" ) || ( !(typeOf player isEqualTo ""%2"") && ( (vehicle _vehicle isKindOf ""Tank"" || vehicle _vehicle isKindOf ""Wheeled_APC_F"") ) )) then 
	{
		if ((player == driver vehicle _vehicle) || (player == vehicle _vehicle turretUnit [0]) || (player == commander vehicle _vehicle)) then 
		{
			player action [""GetOut"", vehicle _vehicle];
			hint parseText ""<br/><img size='3' color='#595923' align='center' image='pictures\hint_pic\lock.paa' /><br/><br/>
			<t size='1.2' color='#99ffffff' >%3</t><br/><br/>"";
		};
	};
",_AF_check_pilot,_AF_check_crew,_vehLockCheck]];