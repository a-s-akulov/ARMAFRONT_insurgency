_iedMkr=["iedMkr_1","iedMkr_2","iedMkr_3","iedMkr_4","iedMkr_5","iedMkr_6","iedMkr_7","iedMkr_8","iedMkr_9"];	//List of markers to spawn IEDs in
_iedNum=10;						//Number of IEDs per marker, defined in iedMkr	[Default: 5]
_iedDmg=true;					//Can the IED be killed with weapons?			[Default: false] TRUE = Yes | FALSE = Can only be disarmed
_Dbug=_this select 0;			//Show IED markers on map?						[Default: false]



//!!DO NOT EDIT BELOW!!
_iedBlastList=["Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","Bo_Mk82","Bomb_03_F","Bomb_04_F","BombCluster_01_Ammo_F"];
_iedList=["IEDLandBig_F","IEDLandSmall_F","IEDUrbanBig_F","IEDUrbanSmall_F","rhssaf_mine_tma4"];
_iedAmmo=["IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo"];
_iedJunkP=[""];
if(_Dbug isEqualTo 0)then{{_x setMarkerAlpha 0;}forEach _iedMkr;};

if(!isServer)exitWith{};
iedAct = 
{ 
	_iedObj=_this select 0;
	if(mineActive _iedObj)then {
	_iedBlast=selectRandom (_this select 1);
	_bomb=createVehicle[_iedBlast,(getPosATL _iedObj),[],0,""];
	createVehicle["Crater",(getPosATL _iedObj),[],0,""];
	//[[position _bomb,3],"CREATE_EFFECT",true,false] call BIS_fnc_MP;
	{deleteVehicle _x}forEach nearestObjects[getPosATL _iedObj,_this select 2,4];
	deleteVehicle _iedObj; };
};

{private["_ieds","_trig"];_ieds=[];_iedArea=getMarkerSize _x select 0;_iedRoad=(getMarkerPos _x)nearRoads _iedArea;
	for "_i" from 1 to _iedNum do{
	if(count _ieds==_iedNum*4)exitWith{};
	_iedR=selectRandom _iedRoad;
	_ied=selectRandom _iedList;_junk=selectRandom _iedJunkP;
	_ied=createMine[_ied,getPosATL _iedR,[],8];_ied setPosATL(getPosATL _ied select 2+1);_ied setDir(random 359);
	if(!_iedDmg)then{_ied allowDamage false;};
	if(round(random 2)==1)then{_iedJunk=createVehicle[_junk,getPosATL _ied,[],0,""];_iedJunk setPosATL(getPosATL _iedJunk select 2+1);_iedJunk enableSimulationGlobal false;};
	_jnkR=selectRandom _iedRoad;_junk=createVehicle[_junk,getPosATL _jnkR,[],8,""];_junk setPosATL(getPosATL _junk select 2+1);
	_junk enableSimulationGlobal false;
	_trig=createTrigger["EmptyDetector",getPosATL _ied];
	_trig setTriggerArea[10,10,0,FALSE,10];
	_trig setTriggerActivation[str AF_sidePlayer,"PRESENT",false];
	_trig setTriggerTimeout[0.2,0.4,0.6,true];
	if(isMultiplayer)then{
	_trig setTriggerStatements[
		"{vehicle _x in thisList && speed vehicle _x>4}count playableUnits>0",
		format["{if((typeOf _x)in %1)then{[_x,%2,%3]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",_iedAmmo,_iedBlastList,_iedJunkP],
		"deleteVehicle thisTrigger"];}else{
	_trig setTriggerStatements[
		"{vehicle _x in thisList && isPlayer vehicle _x && speed vehicle _x>4}count allUnits>0",
		format["{if((typeOf _x)in %1)then{[_x,%2,%3]call iedAct;};}forEach nearestObjects[thisTrigger,[],10];",_iedAmmo,_iedBlastList,_iedJunkP],
		"deleteVehicle thisTrigger"];};

	_ieds pushBack _ied;
	if(_Dbug isEqualTo 1)then{
		private _iedMkrs=[];
		_iedPos=getPosWorld _ied;
		_mkrID=format["m %1",_iedPos];
		_mkr=createMarker[_mkrID,getPosWorld _ied];
		_mkr setMarkerShape"ICON";_mkr setMarkerType"mil_dot";_mkr setMarkerBrush"Solid";_mkr setMarkerAlpha 1;_mkr setMarkerColor"ColorEast";
		_iedMkrs pushBack _mkr;};
	};
}forEach _iedMkr;
sleep 5;
{ civilian revealMine _x; AF_sidePlayer revealMine _x; } forEach allMines;