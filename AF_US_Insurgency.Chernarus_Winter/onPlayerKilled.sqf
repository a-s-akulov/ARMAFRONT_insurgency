if (AF_sideEnemy isEqualTo side group player) exitWith {};

AF_Saved_Loadout = getUnitLoadout player;
private _sqNum = player getVariable "sqNum";
private _sqArray = sqArray;
if !(_sqArray isEqualTo []) then 
{	
	private _str = format["sq%1",_sqNum];
	_str = _sqArray findIf { _x select 0 isEqualTo _str };
	if (_str != -1) then
	{
		private _sqBlock = _sqArray select _str;
		_sqBlock = _sqBlock select 2;
		AFgrlp = [player,_sqBlock,localize "RallypointRespawnPoint"] call BIS_fnc_addRespawnPosition;
	};
};


