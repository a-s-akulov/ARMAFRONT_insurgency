scopeName "main";
if (pRole isEqualTo 0) then 
{
	{
		if (side player != side _x && { side _x != civilian && side _x != sideEnemy }) then { hintSilent localize "RallypointEnemyNearby"; playSound "BeeBlip"; breakTo "main"; };
	} forEach (player nearEntities ["Man",50]);
	[player,"ainvpercmstpsraswrfldnon_putdown_amovpercmstpsraswrfldnon"] remoteExec ["playMove", player];
	waitUntil {(animationState player) == "ainvpercmstpsraswrfldnon_putdown_amovpercmstpsraswrfldnon" || !alive player};
	waitUntil {(animationState player) != "ainvpercmstpsraswrfldnon_putdown_amovpercmstpsraswrfldnon" || !alive player};
	if (!alive player) exitWith { };

	private _sqNum = player getVariable "sqNum";
	private _sqArray = sqArray;
	private _sqBlock = [];
	private _str = -1;
	private _position = getPosATL player;
	if !(_sqArray isEqualTo []) then 
	{	
		_str = format["sq%1",_sqNum];
		_str = _sqArray findIf { _x select 0 isEqualTo _str };
		if (_str != -1) then
		{
			_sqBlock = _sqArray select _str;
			format["sqMark%1",_sqNum] setMarkerPos _position;
			deleteVehicle (_sqBlock select 1);
		};
	} else { _sqArray = []; };
	if (_sqBlock isEqualTo []) then
	{
		_sqBlock pushBack format["sq%1",_sqNum];
		private _marker = createMarker [format["sqMark%1",_sqNum],_position];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "respawn_unknown";
		_marker setMarkerText format["%1",group player];
		_marker remoteExec ["deleteMarkerLocal",AF_sideEnemy];
	};
	_sqblock set [2,_position];


	private _object = createVehicle ["Misc_Backpackheap_EP1",[player getRelPos [2, 0] select 0,player getRelPos [2, 0] select 1,_position select 2], [], 0, "CAN_COLLIDE"]; // Object of created Rolepoint
	_object setDir (getDir player + 270);
	_object addAction[format["<t color='#ff9900'>%1</t>",localize "RallypointRemove"], 
	{
		[player,"ainvpercmstpsraswrfldnon_putdown_amovpercmstpsraswrfldnon"] remoteExec ["playMove", player];
		waitUntil {(animationState player) == "ainvpercmstpsraswrfldnon_putdown_amovpercmstpsraswrfldnon" || !alive player};
		waitUntil {(animationState player) != "ainvpercmstpsraswrfldnon_putdown_amovpercmstpsraswrfldnon" || !alive player};
		if (!alive player) exitWith { };
		private _sqNum = player getVariable "sqNum";
		private _sqArray = sqArray;	
		private _str = format["sq%1",_sqNum];
		_str = _sqArray findIf { _x select 0 isEqualTo _str };
		private _sqBlock = _sqArray select _str;
		deleteMarker format["sqMark%1",_sqNum];
		deleteVehicle (_sqBlock select 1);
		_sqArray deleteAt _str;
		sqArray = _sqArray;
		publicVariable "sqArray";
		localize "RallypointDeleted" remoteExec ["hintSilent",group player];
		"BeeBlip" remoteExec ["playSound",group player];
	},[],8,true,true,"",format["if (player == %1 && isNull objectParent player) then { true };",player],4];
	_object allowDamage false;
	_sqBlock set [1,_object];
	if ( _str > -1 ) then { _sqArray set [_str,_sqBlock]; } else { _sqArray pushBack _sqBlock; };
	sqArray = _sqArray;
	publicVariable "sqArray";
	localize "RallypointCreated" remoteExec ["hintSilent",group player];
	"BeeBlip" remoteExec ["playSound",group player];
	localize "RallypointCreatedYou" remoteExec ["hintSilent",player];
};
//[player,"amovpercmstpsraswrfldnon"] remoteExec ["playMove", player];