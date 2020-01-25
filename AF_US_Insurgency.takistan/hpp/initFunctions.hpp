/*------------fnc_caches------------*/

AF_fnc_cacheKilled = {
//author: by Fireball, Kol9yN
//modified: KOKaKOJIbKA
	private ["_pos","_dur","_count","_veh"];
	private _chacheMrkrs = _this getVariable "mrkrs";
	_pos    = getPosATL (_this);
	curTime = time;
	_dur    = 5 + random 5;
	"Bo_Air_LGB" createVehicle _pos;
	while {true} do {
		_veh = "Bo_Air_LGB" createVehicle _pos; 
		_veh setVectorDirAndUp [[(random 1) -0.5,(random 1)-0.5,(random 1) -0.5],[0,(random -1.5),(random 1) -0.5]];
		if (random 100 > 70) then { "Cluster_120mm_AMOS" createVehicle _pos; }; 
		if ((time - curTime) > _dur) exitWith { "Bo_Air_LGB" createVehicle _pos; }; 
		sleep random 1; 
	};
	//delete markers
	{
		if ((markerType _x == "hd_unknown") && (markerPos _x distance _pos < 600)) then {
			deleteMarker _x;
		};
	} forEach allMapMarkers;

	remoteExec ["",_this getVariable "jip_1"];
	remoteExec ["",_this getVariable "jip_2"];

	deleteVehicle _this;
	{ deleteMarker _x; } forEach _chacheMrkrs;
	arrayCachePos = arrayCachePos - [_this];
	publicVariable "arrayCachePos";
	if (_this isEqualTo currCache) then { currCache = nil; };
	sleep 3;
	AF_cacheCount = AF_cacheCount - 1;

	[[AF_cDeads,AF_pDT,AF_cacheCount,selectRandom [
			"ATrack27",
			"ATrack23",
			"ATrack17",
			"LeadTrack02_F",
			"LeadTrack04_F_Tank",
			"EventTrack02_F_Orange",
			"EventTrack01_F_Curator",
			"LeadTrack01b_F_Bootcamp"
		],AF_cMaxKill,AF_pMaxDT],{
		[[_this select 0,_this select 4,0],[_this select 1,_this select 5,0],_this select 2] spawn AF_statIGUI;
		["pictures\hint_pic\explosion.paa","AF_cacheKilled"] spawn AF_hintPicture;
		playSound3D ["a3\sounds_f\sfx\Beep_Target.wss", player];
		playMusic (_this select 3);
	}] remoteExec ['spawn',-2];

	[_pos] spawn AF_fnc_markerCache;
	sleep 5;
	["","hintSilent",true,false] call BIS_fnc_MP;
	sleep 5;
	if (AF_cacheCount == 0) exitWith {
		[["task_0","SUCCEEDED"],"BIS_fnc_taskSetState",true,false] call BIS_fnc_MP;
		sleep 5;
		"Caches_Destroyed" remoteExec ["BIS_fnc_endMission",AF_sidePlayer];
		["Caches_Destroyed_ss",false] remoteExec ["BIS_fnc_endMission",AF_sideEnemy];
	};
	true
};

AF_fnc_markerCache = {
//author: KOKaKOJIbKA
	private "_pos";
	_pos = _this select 0;
	_num = ceil random 100;

	_marker = format["destroy%1",_num];
	_d_marker = createMarker [_marker,_pos];
	_d_marker setMarkerShape "ICON";
	_d_marker setMarkerType "hd_destroy";
	_d_marker setMarkerSize [0.7,0.7];
	_d_marker setMarkerText "Уничтожен";
};

AF_fnc_intelCache = {
//author: unknown
//modified: KOKaKOJIbKA
	private ["_intelPos","_intelHouse","_intel","_id","_positions","_type","_nWestUnits","_intelHouses","_AF_DebIntelShow"];
	_AF_DebIntelShow = _this select 0;

	_arrayIntel = [];
	_intelHouses = [AF_centerPos, AF_radiusPos, 6, true] call AF_fnc_findHouses;
	for "_i" from 0 to 100 do 
	{
		_intelHouse = _intelHouses deleteAt floor random count _intelHouses;
		if (!(isNil "_intelHouse") && { (count ( _arrayIntel select { (_intelHouse distance _x) < 300 } )) < 3 }) then
		{
			_intel = createVehicle [selectRandom AF_typeIntel, selectRandom (_intelHouse buildingPos -1), [], 0, "CAN_COLLIDE"];
			_intel enableDynamicSimulation true;
			_arrayIntel pushBack _intel;

			if ( _AF_DebIntelShow == 1 ) then
			{
				//!!!!! DEBUG KATLETKA !!!!
				private _marker = createMarker [format["Intel%1",_intel],getPosATL _intel];
				_marker setMarkerShape "ICON";
				_marker setMarkerType "respawn_unknown";
				_marker setMarkerText format["Intel position"];
				//!!!!! DEBUG KATLETKA !!!!
			};

			[_intel,['Взять разведданные', {
				[_this select 0, _this select 1] remoteExec ["AF_IntelFounded",2];
			}, [], 10, true, true, '',"true",5]] remoteExec ["addAction",AF_sidePlayer,_intel];
		};

	};
	true
};

AF_IntelFounded =
{
	params ["_target","_caller"];
	_caller playAction "PutDown";
	private _posCache 		= if (isNil "currCache") then { currCache = selectRandom arrayCachePos; currCache } else { currCache };
	private _cahceMarks 	= _posCache getVariable "mrkrs";
	private _dist 			= 50 max (500 - (50 * (count _cahceMarks)));

	private _marker = createMarker [format["mkC-%1-%2_%3",_posCache,_dist,random 1000],_posCache getRelPos [random _dist,random 360]];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "hd_unknown";
	_marker setMarkerSize [0.7,0.7];
	_marker setMarkerText format["%1 m.",_dist];
	_cahceMarks pushBack _marker;
	_posCache setVariable ["mrkrs",_cahceMarks];
	deleteVehicle _target;
	['pictures\hint_pic\geo_pos_cache_icon.paa',[name _caller,' ','AF_intel_founded_str']] remoteExec ['AF_hintPicture',-2];
	{playSound3D ["a3\sounds_f_epc\CAS_01\incom.wss", _x];} forEach (playableunits + switchableunits);
};

AF_fnc_findHouses = {
//author: unknown
//modified: KOKaKOJIbKA
	private ["_buildings","_minPositions","_enterables","_alive","_temp"];
	_buildings = nearestObjects [_this select 0, ["House"], _this select 1]; 
	_minPositions = (_this select 2) - 1;
	_alive = _this select 3;

	_enterables = [];
	{
		_temp = _x; 
		if (
			
			(format["%1", _temp buildingPos _minPositions] != "[0,0,0]") &&
			(alive _temp || !_alive)
		) then { 
			_enterables set [count _enterables, _temp]; 
		};
	} forEach _buildings;
	_enterables
};

AF_fnc_setupCaches = {
//author: unknown
//modified: KOKaKOJIbKA
	private ["_cachePos","_cacheHouse","_cache","_id","_positions","_type","_nWestUnits","_cacheHouses","_AF_DebCasheShow","_AF_DebIntelShow"];
	_AF_DebCasheShow = _this select 1;
	_AF_DebIntelShow = _this select 2;

	_cacheHouses = [AF_centerPos, AF_radiusPos, 6, true] call AF_fnc_findHouses;
	arrayCachePos = [];
	for "_i" from 0 to (AF_cacheCount - 1) do {
		_cache = createVehicle [AF_cacheType, AF_spawnPos, [], 0, "None"];
		_cache allowDamage false;
		_cache addEventHandler["Killed", {(_this select 0) spawn AF_fnc_cacheKilled;}]; 
		while { count _cacheHouses > 1 } do {
			_cacheHouse = _cacheHouses select floor(random(count _cacheHouses - 1)); 
			_type       = typeOf _cacheHouse;
			_nWestUnits = nearestObjects[getPosATL _cacheHouse, [AF_cacheType], AF_cacheRadius];
			if (count _nWestUnits == 0 && _type in AF_casheHousePos && _cacheHouse distance AF_base_center > 1500) exitWith {
				_id = AF_casheHousePos find _type; 
				_positions = AF_casheHousePos select (_id+1); 
				_cachePos = _cacheHouse buildingPos (_positions select floor(random(count _positions - 1)));
			};
			_cacheHouses = _cacheHouses - [_cacheHouse];
		};
		_cache setPosATL _cachePos;
		_cache enableDynamicSimulation true;

		private _cacheJIP = [_cache,{ _this addAction [format["<t color='#00FFFF'>%1</t>",localize 'addActInCarCache'],"[[(_this select 0),(_this select 1)],{ [_this select 0,_this select 1] spawn AF_cacheInVeh; }] remoteExec ['spawn',2];",[],10,false,true,"","",5]; }] remoteExec ["spawn",AF_sidePlayer,true];
		_cache setVariable ["jip_1",_cacheJIP];
		_cacheJIP = [_cache,
							{ 
								_this addAction [format["<t color='#00FFFF'>%1</t>",localize 'addActTakeCache'],
								"
									[
										[_this select 0,_this select 1],
										{ 
											[_this select 0,_this select 1] spawn AF_cacheTakeIt;
										}
									] remoteExec ['spawn',2];
								",[],11,false,true,"","",5]; 
							}] remoteExec ["spawn",AF_sidePlayer,true];
		_cache setVariable ["jip_2",_cacheJIP];
		_cache setVariable ["mrkrs",[]];

		if ( _AF_DebCasheShow == 1 ) then
		{
			//!!!!! DEBUG KATLETKA !!!!
			private _marker = createMarker [format["Cache%1",_cachePos],_cachePos];
			_marker setMarkerShape "ICON";
			_marker setMarkerType "respawn_unknown";
			_marker setMarkerText format["Cache position"];
			_marker setMarkerColor "ColorBlue";
			//!!!!! DEBUG KATLETKA !!!!
		};

		arrayCachePos = arrayCachePos + [_cache];
		publicVariable "arrayCachePos";
		/*//for tests
		_num = ceil random 100;
		_marker = format["cache%1",_num];
		_d_marker = createMarker [_marker,_cachePos];
		_d_marker setMarkerShape "ICON";
		_d_marker setMarkerType "hd_destroy";
		*/
		/*_cacheHouse addEventHandler ["handleDamage", {
			_damage = _this select 2; 
			_cache  = getPosATL (_this select 0) nearestObject AF_cacheType;
			if (_damage > 0.9) then {_cache setDamage 1;};
			_damage
		}];*/

		_cache spawn
		{
			sleep 5;
			private _cache = _this;
			if (  ((AF_InfMarkers findIf { _cache inArea _x }) isEqualTo -1) && ((AF_stratMrkrs findIf { _cache inArea _x }) isEqualTo -1) ) then { _cache allowDamage true; };
		};
	};
	_clean = [] execVM "scripts\cleanUp.sqf";
	_casheIntel = [_AF_DebIntelShow] call AF_fnc_intelCache;
	["task_0",AF_sidePlayer,["Найдите и уничтожьте все схроны с оружием.<br/><br/>","Найти и уничтожить",""],[],"ASSIGNED",1] call BIS_fnc_setTask;
	true
};

/*------------------------------*/
/*--------createMarker.sqf------*/
AF_getGridPos = {
//author: unknown
//modified: KOKaKOJIbKA
	private ["_pos","_x","_y"];

	_pos = getPosATL _this;
	_x = _pos select 0;
	_y = _pos select 1;
	_x = _x - (_x % 100);
	_y = _y - (_y % 100);
	[_x + 50, _y + 50, 0]
};

/*------------------------------*/
//-------------Скрипт Шахида----------
AF_fnc_start_bomber = {
	if ((random 1) > 0.7) then { // плотность смертников
		private _id = allUnits findIf 
		{ 
			_x1 = _x; 
			side group _x isEqualTo civilian && 
			{  
				((allPlayers select { AF_sidePlayer isEqualTo side group _x }) findIf { _x distance _x1 < 100 } > -1) && { (isNull objectParent _x) }
			} 
		};
		if (_id > -1) then
		{
			_bomber = allUnits select _id;
			_bomber dofollow player; // следование смертника за игроком
			_bomber setVariable ["isBomber",true];
			[_bomber,[AF_sidePlayer],"rhsusf_explosive_m112x4"] execVM "scripts\suicideBomber.sqf"; // предмет на теле и адрес самого скрипта
		};
	};
	sleep 120;
	[] spawn AF_fnc_start_bomber;
};

/*------------------------------*/

// снаряжение транспорта
AF_vehCargo =
{
	sleep 1;
	if ("OBJECT" isEqualTo typeName _this) exitWith
	{
		clearItemCargoGlobal _this;
		clearWeaponCargoGlobal _this;
		clearBackpackCargoGlobal _this;
		clearMagazineCargoGlobal _this;

		sleep 0.1;
		_this addItemCargoGlobal ["FirstAidKit", 10];
		_this addItemCargoGlobal ["ToolKit", 1];
		_this addWeaponCargoGlobal ["rhs_weap_m72a7", 2];
		_this addMagazineCargoGlobal ["rhs_m72a7_mag", 2];
		_this addMagazineCargoGlobal ["rhs_mag_30Rnd_556x45_M855A1_Stanag", 30];
	};
	private _veh	= _this select 0;
	private _mode	= _this select 1;

	clearItemCargoGlobal _veh;
	clearWeaponCargoGlobal _veh;
	clearBackpackCargoGlobal _veh;
	clearMagazineCargoGlobal _veh;
	sleep 0.1;
	if (_mode isEqualTo "GROUND_PATROL") exitWith
	{
		_veh addWeaponCargoGlobal ["rhs_weap_rpg26", 2];
		_veh addItemCargoGlobal ["FirstAidKit", 10];
	};
};

// инициализация ограничений миссии по смертям
AF_killLimits =
{
	private _maxP = _this select 0;
	private _maxC = _this select 1;
	private _str  = [
	"
		private	'_old';
		private _unit = _this select 0;
		private _killer = _this select 1;
		private _instigator = _this select 2;
		if (isNull _instigator) then { _instigator = UAVControl vehicle _killer select 0 };
		if (!isNull _instigator && { _instigator in allPlayers }) then
		{
			if ((side group _unit) isEqualTo side group _instigator) then
			{
				['',
				[
					'<t color=''#FF0000''>',
					name _instigator,
					'</t><br/>',
					'AF_teamKilled',
					'<t color =''',
					([side group _instigator, false] call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML,
					'''> ( ',
					str side group _instigator,
					' )</t><br/>',
					'<t color=''#DCDCDC''>',
					name _unit,
					'</t>'
				]] remoteExec ['AF_hintPicture',-2];
				if (AF_sideEnemy isEqualTo side group _instigator) then
				{
					[[],{
						AF_ss_respTime = AF_ss_respTime + 120;
						sleep 7;
						['','AF_teamKilled_instigator'] spawn AF_hintPicture;
					}] remoteExec ['spawn',_instigator];
				};
			};
		};
	", format[
	"
		private _unit = _this select 0;
		private _killer = _this select 1;
		private _instigator = _this select 2;
		if (isNull _instigator) then { _instigator = UAVControl vehicle _killer select 0 };
		if (!isNull _instigator && { _instigator in allPlayers }) then
		{
			if ((side group _unit) isEqualTo side group _instigator) then
			{
				['',
				[
					'<t color=''#FF0000''>',
					name _instigator,
					'</t><br/>',
					'AF_teamKilled',
					'<t color =''',
					([side group _instigator, false] call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML,
					'''> ( ',
					str side group _instigator,
					' )</t><br/>',
					'<t color=''#DCDCDC''>',
					name _unit,
					'</t>'
				]] remoteExec ['AF_hintPicture',-2];
				if (AF_sideEnemy isEqualTo side group _instigator) then
				{
					[[],{
						AF_ss_respTime = AF_ss_respTime + 120;
						sleep 7;
						['','AF_teamKilled_instigator'] spawn AF_hintPicture;
					}] remoteExec ['spawn',_instigator];
				};
			};
		};
		
		if (_unit in allPlayers && { AF_sidePlayer isEqualTo side group _unit }) then
		{
			_old = AF_pDT;
			AF_pDT = AF_pDT + 1;
			[[AF_cDeads,AF_cMaxKill,0],[AF_pDT,AF_pMaxDT,0],AF_cacheCount] remoteExec ['AF_statIGUI',-2];
			if (AF_pDT >= AF_pMaxDT) then { ['Players_Dead',false] remoteExec ['BIS_fnc_endMission',AF_sidePlayer]; 'Players_Dead_ss' remoteExec ['BIS_fnc_endMission',AF_sideEnemy]; };
			if ( (AF_pMaxDT - AF_pDT) <= 15 && (AF_pMaxDT - _old) > 15 ) then { selectRandom[
				'ATrack9',
				'ATrack10',
				'LeadTrack01a_F',
				'LeadTrack01b_F',
				'LeadTrack03_F',
				'LeadTrack03_F_Tank',
				'AmbientTrack01a_F_Tacops',
				'AmbientTrack01b_F_Tacops',
				'AmbientTrack02a_F_Tacops',
				'AmbientTrack02b_F_Tacops',
				'AmbientTrack03a_F_Tacops',
				'AmbientTrack03b_F_Tacops',
				'AmbientTrack04a_F_Tacops',
				'AmbientTrack04b_F_Tacops',
				'EventTrack01_F_Jets'
			] remoteExec ['playMusic',-2]; };
		}; 

	"]] select (_maxP > -1);

	if (_maxC > -1) then
	{ _str = _str + format[
	"
		if ((side group _unit) isEqualTo civilian) then
		{
			if (isNil { _unit getVariable 'isBomber' }) then
			{
				_old = AF_cDeads;
				AF_cDeads = AF_cDeads + 1;
				[[AF_cDeads,AF_cMaxKill,0],[AF_pDT,AF_pMaxDT,0],AF_cacheCount] remoteExec ['AF_statIGUI',-2];

				if !(isNull _instigator) then
				{
					['',
					[
						'<t color=''#FF0000''>',
						name _instigator,
						'</t><br/>',
						selectRandom ['AF_killed_r1','AF_killed_r2','AF_killed_r3','AF_killed_r4'],
						'<t color=''#DCDCDC''>',
						name _unit,
						'</t>'
					]] remoteExec ['AF_hintPicture',-2];
					if (AF_sideEnemy isEqualTo side group _instigator) then
					{
						[[],{
							AF_ss_respTime = AF_ss_respTime + 120;
							sleep 7;
							['','AF_civilKilled_instigator'] spawn AF_hintPicture;
						}] remoteExec ['spawn',_instigator];
					};
				};

				if (AF_cDeads >= AF_cMaxKill) then { ['Civilians_Dead',false] remoteExec ['BIS_fnc_endMission',AF_sidePlayer]; ['Civilians_Dead_ss',false] remoteExec ['BIS_fnc_endMission',AF_sideEnemy]; };
				if ( (AF_cMaxKill - AF_cDeads) <= 5 && (AF_cMaxKill - _old) > 5 ) then { selectRandom[
					'ATrack9',
					'ATrack10',
					'LeadTrack01a_F',
					'LeadTrack01b_F',
					'LeadTrack03_F',
					'LeadTrack03_F_Tank',
					'AmbientTrack01a_F_Tacops',
					'AmbientTrack01b_F_Tacops',
					'AmbientTrack02a_F_Tacops',
					'AmbientTrack02b_F_Tacops',
					'AmbientTrack03a_F_Tacops',
					'AmbientTrack03b_F_Tacops',
					'AmbientTrack04a_F_Tacops',
					'AmbientTrack04b_F_Tacops',
					'EventTrack01_F_Jets'
				] remoteExec ['playMusic',-2]; };
			};
		};
	"]; };
	addMissionEventHandler ["EntityKilled",_str];
};

// Mission Main Directory
_descExtPath = str missionConfigFile;
mDir = compileFinal str (_descExtPath select [0, count _descExtPath - 15]);

AF_cacheInVeh =
{
	private _cache 			= _this select 0;
	private _caller			= _this select 1;
	private _veh			= (_cache nearEntities[["Car","Tank","Air","Ship"],8]) select 0;
	private _pic			= "pictures\hint_pic\vehiclegui_ca.paa";

	if (!alive _cache || !alive _caller) exitWith {};
	if (isNil "_veh") exitWith 								{ [_pic,"noCarCache"] remoteExec ["AF_hintPicture",_caller]; };

	if !(isNil {_veh getVariable "cacheLoad"}) exitWith 	{ [_pic,"tooManyCache"] remoteExec ["AF_hintPicture",_caller]; };
			
	if (!alive _veh) exitWith 								{ [_pic,"deadVehCache"] remoteExec ["AF_hintPicture",_caller]; };

	if (!isNull attachedTo _cache) exitWith 				{ [_pic,"isTakenCache"] remoteExec ["AF_hintPicture",_caller]; };
	
	_cache allowDamage false;
	_cache setPos [0,0,0];
	private _handler 		= _veh addMPEventHandler ["MPKilled", 
								{
									private _veh = _this select 0;
									private _cache 	= (_veh getVariable "cacheLoad") select 0;
									_veh removeAction _action;
									private _cPos = _veh getRelPos [6,180];

									_cache setPos _cPos;
									_cache allowDamage true;
									_cache setDamage 1;
									
									remoteExec ["",_veh];
									[_veh,{ _this removeAction (_this getVariable "cAction"); }] remoteExec ["spawn",0];
									_veh removeMPEventHandler ["MPKilled",_thisEventHandler];
								}];
	_veh setVariable ["cacheLoad",[_cache,_handler]];
	[_veh,{ private _act = _this addAction [format["<t color='#00FFFF'>%1</t>",localize "addActFromCarCache"],"[[(_this select 0),(_this select 1)],{ [_this select 0,_this select 1] spawn AF_cacheOutVeh; }] remoteExec ['spawn',2];",[],10,false,true,"","isNull objectParent _this",5]; _this setVariable ["cAction",_act]; }] remoteExec ["spawn",AF_sidePlayer,_veh];
	[[configFile >> "CfgVehicles" >> typeOf _veh] call BIS_fnc_displayName,{ hint parseText format["<br/><img size='3' color='#595923' align='center' image='pictures\hint_pic\vehiclegui_ca.paa' /><br/><br/>
			<t size='1.2' color='#99ffffff' >%1</t><br/><br/><t size='1.3' color='#ff0000' >%2</t>",localize "actInCarCache",_this]; }]remoteExec ["spawn",_caller];
};

AF_cacheOutVeh =
{
	private _veh 			= _this select 0;
	private _caller			= _this select 1;
	private _cache			= (_veh getVariable "cacheLoad") select 0;
	private _handler		= (_veh getVariable "cacheLoad") select 1;
	if (isNil "_handler" || !alive _cache || !alive _caller) exitWith {};
	private _cPos = _veh getRelPos [6,180];
	
	_cache setPos _cPos;

	_veh removeMPEventHandler ["MPKilled",_handler];
	remoteExec ["",_veh];
	[_veh,{ _this removeAction (_this getVariable "cAction"); _this setVariable ["cAction",nil]; }] remoteExec ["spawn",AF_sidePlayer];
	_veh setVariable ["cacheLoad",nil];

	["pictures\hint_pic\vehiclegui_ca.paa","actFromCarCache"] remoteExec ["AF_hintPicture",_caller];
	sleep 2;
	_cache allowDamage true;
};

AF_cacheTakeIt =
{
	// DraggingAmmoBox	Тащит ящик, ящика нет

	private _cache 			= _this select 0;
	private _caller			= _this select 1;
	private _pic			= "pictures\hint_pic\carry_box.paa";

	if (!alive _cache || !alive _caller) exitWith {};

	if (!isNull attachedTo _cache) exitWith 			{ [_pic,"isTakenCache"] remoteExec ["AF_hintPicture",_caller]; };

	if (count ((attachedObjects _caller) select { !isNull _x }) > 0) exitWith 	{ [_pic,"tooManyInfCache"] remoteExec ["AF_hintPicture",_caller]; };

	private _handler 		= _caller addMPEventHandler ["MPKilled", 
								{
									private _caller = _this select 0;
									{ _x setDamage 1; } forEach attachedObjects _caller;
									_caller removeMPEventHandler ["MPKilled",_thisEventHandler];
								}];

	remoteExec ["AF_weapsBack",_caller];

	_caller setVariable ["hanCache",_handler];
	_cache attachTo [_caller,[0,0.5,0],"Pelvis"];
	_cache setDir 90;
	[_pic,"doTookCache"] remoteExec ["AF_hintPicture",_caller];
	[[],{ player addAction [format["<t color='#00FFFF'>%1</t>",localize 'addActPutDownCache'],"[[(_this select 0),(_this select 2)],{ [_this select 0,_this select 1] spawn AF_cachePutIt; }] remoteExec ['spawn',2];",[],12,true,true,"","",0]; }] remoteExec ["spawn",_caller];
};

AF_cachePutIt =
{
	private _caller			= _this select 0;
	private _action			= _this select 1;
	private _cache			= attachedObjects _caller;
	private _handler		= _caller getVariable "hanCache";
	if (!alive _caller || (count ((attachedObjects _caller) select { !isNull _x }) == 0) || isNil "_handler") exitWith {};
	_cache					= _cache select ((count _cache) -1);
	if (!alive _cache) exitWith {};

	_caller removeMPEventHandler ["MPkilled",_handler];

	[[_cache,_action],
	{ 
		detach (_this select 0); 
		player removeAction (_this select 1);
		["pictures\hint_pic\carry_box.paa","doPutCache"] spawn AF_hintPicture;
		0 spawn AF_weapsBack;
	}] remoteExec ["spawn",_caller];
};

AF_curatorInit = // инициализация куратора при подключении игрока к серверу
{
	private _unit			= _this;
	private _UID 			= getPlayerUID _unit;
	if (_UID in AF_Curators) then { _unit spawn AF_curatorAdd; };
};

AF_curatorAdd = // выдача куратора игроку
{
	private _unit 			= _this;
	private _UID 			= getPlayerUID _unit;
	private _curators		= allCurators;
	private _arrID			= _curators findIf { (str _x) isEqualTo _UID };

	if (_arrID > -1 ) exitWith { _unit assignCurator (_curators select _arrID); [[],{ pIsCurator = true; }] remoteExec ["spawn",_unit]; };

	private _groupLogic		= [group (_curators select 0),createGroup sideLogic] select (_curators isEqualTo []);

	private _curator		= _groupLogic createUnit ["moduleCurator_f",[0,0,0],[],0,"CAN_COLLIDE"];
	_unit assignCurator _curator;
	_curator setVehicleVarName _UID;
	[[],{ pIsCurator = true; }] remoteExec ["spawn",_unit];
};

AF_curatorRespawn = // переподключение игрока к его куратору после смерти
{
	private _unit 			= _this;
	private _UID 			= getPlayerUID _unit;
	private _curators		= allCurators;
	private _arrID			= _curators findIf { (str _x) isEqualTo _UID };
	if (_arrID > -1) then { _unit spawn AF_curatorAdd; } else { [[],{ pIsCurator = nil; }] remoteExec ["spawn",_unit]; };
};

AF_curatorRemove = // удаление куратора
{
	private _unit			= _this;
	private _UID 			= getPlayerUID _unit;
	private _curators		= allCurators;
	private _arrID			= _curators findIf { (str _x) isEqualTo _UID };

	if (_arrID > -1) then 
	{
		private _curator = _curators select _arrID;
		private _group = group _curator;
		unassignCurator _curator;
		deleteVehicle _curator;
		if (allCurators isEqualTo []) then { deleteGroup _group; };
	};
	[[],{ pIsCurator = nil; }] remoteExec ["spawn",_unit];
};


AF_addVehCrew =
{
	private _veh 	= _this select 0;
	private _type	= _this select 1;
	private _group 	= _this select 2;
	private _places = { !((_x select 0) isEqualTo "Cargo") } count ((_veh) call BIS_fnc_vehicleRoles);
	_places = ([3,4] select (_veh isKindOf "Air")) min _places;
	for "_i" from 1 to _places do
	{
		_type createUnit [getPosATL _veh, _group,"this moveinAny _veh"];
	};
	_veh setVehicleRadar 1;
};


AF_taskPatrol =
{
	private _grp 			= _this select 0;
	private _center			= _this select 1;
	private _radius			= _this select 2;
	private _roadsPriority	= _this select 3;
	private _roadsBlackList = param [4,[]];
	private _wpPosition		= [];
	private _cIsArray		= ((typeName _center) isEqualTo "ARRAY");
	private _cIsObj			= ((typeName _center) isEqualTo "OBJECT");

	if (_cIsArray || _cIsObj) then
	{
		_wpPosition			= _center getPos [random _radius,random 360];
		_wpPosition			= [_wpPosition, 0, 100, 10, 0, 0.25, 0, [["water"]], [_wpPosition,_wpPosition]] call BIS_fnc_findSafePos;
	} else {
		_wpPosition			= [[_center], ["water"]] call BIS_fnc_randomPos;
	};
	if _roadsPriority 		then 
	{  
		_wpPosition 		= getPosATL ([_wpPosition, 5000] call BIS_fnc_nearestRoad);
		private _road		= _wpPosition nearRoads 5000;
		sleep 0.2;
		_wpPosition			= getPosATL (_road select (_road findIf { !((typeOf _x) in _roadsBlackList) })); // тут выбирается одна дорога, которая не в черном списке
	};
	
	private _leader			= leader _grp;
	_leader setVariable ["stopLag",true];
	private _wp				= _grp addWaypoint [_wpPosition, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 20;
	_wp setWaypointStatements ["true",format["if ( isNil { this getVariable 'stopLag' } ) then { deleteWaypoint [group this,currentWaypoint group this]; [group this,%1,%2,%3,%4] spawn AF_taskPatrol; } else { [group this, currentWaypoint group this] setWaypointStatements ['false','']; };",[[format["'%1'",_center],"vehicle this"] select _cIsObj,_center] select _cIsArray,_radius,_roadsPriority,_roadsBlackList]];
	sleep 5;
	_grp setCurrentWaypoint _wp;
	_leader setVariable ["stopLag",nil];
};


AF_baseVehMarks =
{
	sleep 600;
	private "_marker";
	private _temp = AF_BVHarr;
	private _vehicles = AF_vehRespawnArr select { (alive _x) && (_x distance AF_centerBase) > 500 };
	{ deleteMarker _x; } forEach _temp;
	_temp = [];
	{
		if ((speed _x) isEqualTo 0) then
		{
			_marker = createMarker [format["baseVMark_%1", _x],getPosATL _x];
			_marker setMarkerShape "ICON";
            _marker setMarkerType "n_motor_inf";
			_marker setMarkerSize [0.5,0.5];
			_marker setMarkerColor "colorBlack";
			_temp pushBack _marker;
		};
	} forEach _vehicles;
	[{ deleteMarkerLocal _x; },_temp] remoteExec ["forEach",AF_sideEnemy];
	AF_BVHarr = _temp;
	[] spawn AF_baseVehMarks;
};


AF_vehRespawn =
{
	private _veh 		= _this select 0;
	private _params		= _this select 1;
	private _pos		= _params select 0;
	private _dir		= _params select 1;
	private _pylons		= _params select 2;
	private _camo		= _params select 3;
	private _respPoints	= _params select 4;
	
	private _type		= typeOf _veh;
	
	AF_vehRespawnArr deleteAt (AF_vehRespawnArr find _veh);
	if (_respPoints > 0) then
	{
		private _old	= AF_pDT;
		AF_pDT			= _old + _respPoints;
		[[AF_cDeads,AF_cMaxKill,0],[AF_pDT,AF_pMaxDT,0],AF_cacheCount] remoteExec ['AF_statIGUI',-2];
		if (AF_pDT >= AF_pMaxDT) then { ['Players_Dead',false] remoteExec ['BIS_fnc_endMission',AF_sidePlayer]; 'Players_Dead_ss' remoteExec ['BIS_fnc_endMission',AF_sideEnemy]; };
		if ( (AF_pMaxDT - AF_pDT) <= 15 && (AF_pMaxDT - _old) > 15 ) then
		{
			selectRandom[
				'ATrack9',
				'ATrack10',
				'LeadTrack01a_F',
				'LeadTrack01b_F',
				'LeadTrack03_F',
				'LeadTrack03_F_Tank',
				'AmbientTrack01a_F_Tacops',
				'AmbientTrack01b_F_Tacops',
				'AmbientTrack02a_F_Tacops',
				'AmbientTrack02b_F_Tacops',
				'AmbientTrack03a_F_Tacops',
				'AmbientTrack03b_F_Tacops',
				'AmbientTrack04a_F_Tacops',
				'AmbientTrack04b_F_Tacops',
				'EventTrack01_F_Jets'
			] remoteExec ['playMusic',-2];
		};
	};

	sleep 300;

	{ _veh deleteVehicleCrew _x; } forEach crew _veh;
	deleteVehicle _veh;
		
	sleep 3;
	_veh = createVehicle [_type,_pos,[],0,'CAN_COLLIDE'];
	_veh setDir _dir;
	_veh setVariable ["params",[_pos, _dir, _pylons, _camo, _respPoints]];
	_veh addEventHandler ["Killed","[(_this select 0),(_this select 0) getVariable 'params'] remoteExec ['AF_vehRespawn',2];"];

	if !(_pylons isEqualTo []) then
	{
		private _pylonPaths = (configProperties [configFile >> "CfgVehicles" >> _type >> "Components" >> "TransportPylonsComponent" >> "Pylons", "isClass _x"]) apply {getArray (_x >> "turret")};
		{ _veh removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon") } forEach getPylonMagazines _veh;
		{ _veh setPylonLoadout [_forEachIndex + 1, _x, true, _pylonPaths select _forEachIndex] } forEach _pylons;
	};

	{
		_veh setObjectTextureGlobal [_forEachIndex,_x];
	} forEach _camo;

	if !((typeOf _veh) isEqualTo "B_supplyCrate_F") then
	{
		_veh spawn AF_vehCargo;
		_veh setVehicleReportRemoteTargets true;
		_veh setVehicleReceiveRemoteTargets true;
		_veh setVehicleReportOwnPosition true;
	};

	

	AF_vehRespawnArr pushBack _veh;
};

AF_vehRespawnINIT =
{
	private _veh		= _this;
	private _type		= typeOf _veh;
	private _respPoints	= switch true do
	{
		case ( _type isKindOf "Car" ) : { 3 };
		case ( _type isKindOf "Ship" ) : { 4 };
		case ( (_type isKindOf "Apc") || (_type isKindOf "Wheeled_APC_F") || (_type isKindOf "Wheeled_APC") ) : { 5 };
		case ( _type isKindOf "Tank" ) : { 7 };
		case ( _type isKindOf "Helicopter" ) : { 10 };
		case ( _type isKindOf "Plane" ) : { 15 };
		default { 3 };
	};
	private _params		= [getPosATL _veh, direction _veh, getPylonMagazines _veh, getObjectTextures _veh, _respPoints];

	_veh setVariable ["params",_params];
	_veh addEventHandler ["Killed","[(_this select 0),(_this select 0) getVariable 'params'] remoteExec ['AF_vehRespawn',2];"];
	if !(_type isEqualTo "B_supplyCrate_F") then { _veh spawn AF_vehCargo; } else
	{
		_veh setVehicleReportRemoteTargets true;
		_veh setVehicleReceiveRemoteTargets true;
		_veh setVehicleReportOwnPosition true;
	};

	

	AF_vehRespawnArr pushBack _veh;
};

AF_checkPatrol =
{
/* 
	[
		all spawned vehicles,
		all spawned units,
		count of spawned vehicles,
		[params for next spawn],
		sleep to next spawn before current patrol die,
		file folder of executed spawn script,
		execute once with spawn next patrol (optional, default: false)
	]
*/

	#define NEAR_OBJ_DIST 500

	private ["_unit"];

	private _allVehicles		= (_this select 0) select { alive _x };
	private _allUnits			= (_this select 1) select { alive _x };
	private _startVehCount		= _this select 2;
	private _spawnParams		= _this select 3;
	private _sleep				= _this select 4;
	private _fileFolder			= _this select 5;
	private _finish				= param [6,false];


	{
		_unit = _x;
		if ( ((_allVehicles findIf { _unit distance _x < NEAR_OBJ_DIST }) isEqualTo -1) && ((allPlayers findIf { _unit distance _x < NEAR_OBJ_DIST }) isEqualTo -1) ) then { _unit setDamage 1; };
	} forEach _allUnits;
	_allUnits = _allUnits select { alive _x };

	{
		_unit = _x;
		if ((_allUnits findIf { _unit distance _x < NEAR_OBJ_DIST }) isEqualTo -1) then	{ _unit setDamage 1; } else { _unit setFuel 1; };
	} forEach _allVehicles;
	_allVehicles = _allVehicles select { alive _x };

	if _finish exitWith { private _params = _spawnParams; _params pushBack [_allUnits,_allVehicles]; _params execVM _fileFolder; };

	if ( (_startVehCount - (count _allVehicles)) > (_startVehCount - _startVehCount^(1/3)) ) exitWith { sleep _sleep; [_allVehicles,_allUnits,_startVehCount,_spawnParams,_sleep,_fileFolder,true] spawn AF_checkPatrol; };

	sleep 300;
	[_allVehicles,_allUnits,_startVehCount,_spawnParams,_sleep,_fileFolder] spawn AF_checkPatrol;
};

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


