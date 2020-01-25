#define	GARAGE_TYPE	"CamoNet_OPFOR_big_F"
#define SUPPORT_VEH	["I_Truck_02_fuel_F","I_Truck_02_ammo_F","I_Truck_02_box_F"] // mode 1 | mode 2 | mode 3


private ["_trig","_objects","_mrkSize","_mrkr","_handler","_par1"];

_enemy_type			= _this select 0;
_spawn_distance		= _this select 1;
_inf_count			= _this select 2;
_civ				= _this select 3;
_st_wep				= _this select 4;
_max_zones			= _this select 5;
_debug				= [false,true] select (_this select 6);

_victoryColor       = "colorGreen"; // color if zone captured
_battleColor		= "colorOrange"; // color if zone NOT captured

_markers 	= AF_InfMarkers;
_sMarkers	= AF_stratMrkrs;
_sObjTypes	= AF_stratObjectsTypes;

{
	_trig = createTrigger ["EmptyDetector",getMarkerPos _x]; 
	_trig setTriggerArea [(getMarkerSize _x select 0) + _spawn_distance,(getMarkerSize _x select 1) + _spawn_distance,markerDir _x,false,300]; 
	_trig setTriggerActivation ["ANYPLAYER","PRESENT",true];
	_trig setTriggerTimeout [5, 5, 5, true];
	_trig setTriggerStatements [format["({ ((getPosATL _x) select 2 < 50) && (speed _x < 150) && AF_sidePlayer isEqualTo side group _x } count thisList > 0) && this && AF_ActTrgrs <= %1",_max_zones],format[
	"
		if (AF_ActTrgrs < %1) then
		{
			private _handler = thisTrigger getVariable 'handler'; 
			private _handler2 = thisTrigger getVariable 'handler2'; 
			if ((isNil '_handler' || { scriptDone _handler }) && (isNil '_handler2' || { scriptDone _handler2 })) then 
			{ 
				['%2',thisTrigger,%3,%4,%5,%6,'%7',%8] spawn AI_spawn; 
			};
		};
	",_max_zones,_x,_enemy_type,_inf_count,_civ,_st_wep,_victoryColor,_debug],""];

	_x setMarkerColor _battleColor;
	_x setMarkerAlpha 0;
	_x setMarkerBrush "DiagGrid";
	if (_debug) then
	{
		private _marker = createMarker [format["%1_debug",_x],getMarkerPos _x];
        _marker setMarkerShape "ICON";
        _marker setMarkerType "Flag";
        _marker setMarkerText format["Зона инициализирована, готова к активации || Зона: ""%1""",_x];
		_x setMarkerAlpha 0.5;
	};
} forEach _markers;


//=============================>>>>		Стратегические объекты	 	<<<<=============================


{
	_mrkr		= _x;
	_mrkSize 	= getMarkerSize _mrkr;

	_trig = createTrigger ["EmptyDetector",getMarkerPos _mrkr]; 
	_trig setTriggerArea [(_mrkSize select 0) + _spawn_distance,(_mrkSize select 1) + _spawn_distance,markerDir _mrkr,false,300]; 
	_trig setTriggerActivation ["ANYPLAYER","PRESENT",true];
	_trig setTriggerTimeout [5, 5, 5, true];
	_par1 = [_x];
	_par1 append [GARAGE_TYPE,selectRandom SUPPORT_VEH];
	_trig setTriggerStatements [format["({ ((getPosATL _x) select 2 < 50) && (speed _x < 150) && AF_sidePlayer isEqualTo side group _x } count thisList > 0) && this && AF_ActStrat < 2",_max_zones],format[
	"		
		private _handler = thisTrigger getVariable 'handler'; 
		private _handler2 = thisTrigger getVariable 'handler2'; 
		if ((isNil '_handler' || { scriptDone _handler }) && (isNil '_handler2' || { scriptDone _handler2 })) then 
		{
			AF_ActStrat = AF_ActStrat + 1;
			[%1,thisTrigger,%2,%3,'%4',%5] spawn AF_stratSpawnAI;
			[[],{ ['pictures\hint_pic\strategic_object.paa',format[
				'<t size=""1.2"" color=""#99ffffff"" align=""center"">%6</t><br/><t size=""1.2"" color=""#4682B4"" align=""center"">%7</t><br/><t size=""1.2"" color=""#99ffffff"" align=""center"">%8</t>',localize 'AF_stratZone',localize 'AF_stratZoneFounded',localize 'AF_stratZoneFoundedDis']] spawn AF_hintPicture; }] remoteExec ['spawn',-2]; 
		};
	",_par1,_enemy_type,_inf_count,_victoryColor,_debug,"%1","%2","%3"],""];
	_trig setVariable ["marker",_mrkr];

	_objects = nearestObjects [_trig,_sObjTypes,(_mrkSize select 0) max (_mrkSize select 1),true];
	_objects = _objects select { _x inArea _mrkr };

	{
		_handler = _x addEventHandler["killed","(_this select 0) spawn AF_stratObjKilled;"];
		_x setVariable ["handler",_handler];
		_x setVariable ["trigger",_trig];
		_x allowDamage false;
	} forEach _objects;

	_trig setVariable ["stratObjects",_objects];
	_trig setVariable ['mrkr',_mrkr];

	_mrkr setMarkerColor _battleColor;
	_mrkr setMarkerAlpha 0;
	_mrkr setMarkerBrush "DiagGrid";
	if (_debug) then
	{
		private _marker = createMarker [format["%1_debug",_mrkr],getMarkerPos _mrkr];
		_marker setMarkerColor "ColorBlue";
        _marker setMarkerShape "ICON";
        _marker setMarkerType "Flag";
        _marker setMarkerText format["Стратегическая зона инициализирована, готова к активации || Зона: ""%1""",_mrkr];
		_mrkr setMarkerAlpha 0.5;
	};
} forEach _sMarkers;
