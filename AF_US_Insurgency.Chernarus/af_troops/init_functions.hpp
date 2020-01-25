AI_spawn          = compile preprocessFileLineNumbers "af_troops\functions\spawn_ai.sqf";
AI_remove         = compile preprocessFileLineNumbers "af_troops\functions\remove_ai.sqf";
AF_stratRemoveAI  = compile preprocessFileLineNumbers "af_troops\functions\strat_remove_ai.sqf";
AF_stratSpawnAI   = compile preprocessFileLineNumbers "af_troops\functions\strat_spawn_ai.sqf";

// ===========>>>>      FUNCTIONS      <<<<===========

// установка скиллов ботам
AF_setSkill       =
{
   private _grp			   = _this select 0;
   private _mode			   = _this select 1;

   private _skills         = [];
   switch _mode do
   {
      case "inf": { _skills = inf_skill; };
   };

   {
      private _unit = _x;
      {
         private _skillvalue = (_skills select _forEachIndex) + (random 0.8) - (random 0.6);
         _unit setSkill [_x,_skillvalue];
      } forEach ['aimingAccuracy','aimingShake','aimingSpeed','spotDistance','spotTime','courage','reloadSpeed','commanding','general'];

   } forEach (units _grp); 
};

// случайное оружие ботам
AF_RandomWep      =
{
   private ["_unit","_mags"];

   private _groups			= _this select 0;
   private _weaps 			= _this select 1;

   {
      {
         _unit = _x;
         _mags = primaryWeaponMagazine _unit;
         {
            _unit removeMagazines _x;
         } forEach _mags;
         _unit removeWeapon primaryWeapon _unit;

         _mags = selectRandom _weaps;

         { _unit addMagazines [_x,2]; } forEach (_mags select 1);
         { _unit addMagazines [_x,2]; } forEach (_mags select 1);
         { _unit addMagazines [_x,6]; } forEach (_mags select 1);

         _unit addWeapon (_mags select 0);
         if ((count _mags) > 2) then { { _unit addPrimaryWeaponItem _x; } forEach (_mags select 2); };

         removeBackpack _unit;
         
      } forEach units _x;
   } forEach _groups;



};

// проверка обычной зоны
AF_checkZone      = 
{
   private ["_temp"];

   private _marker			= _this select 0;
   private _trigger			= _this select 1;
   private _units				= _this select 2;
   private _countUnits		= _this select 3;
   private _victoryColor	= _this select 4;
   private _unitsCiv			= _this select 5;
   private _unitsAnim		= _this select 6;
   private _debug				= _this select 7;
   private _counter			= 0;
   private _temp2				= [];
   _trigger			setVariable ["handler2",_thisScript];

   {
      sleep 0.1;
      {
         if !(_x in allPlayers) then { _x setDamage 1; } else
         {
            ["pictures\hint_pic\escape_zone_icon.paa","AF_ss_outOfZone"] remoteExec ["AF_hintPicture",_x];
            _x spawn
            {
               sleep 30;
               if ( alive _this && !isHidden _this && ((AF_activatedMrkrs findIf { _this inArea _x }) isEqualTo -1) ) then { _this remoteExec ["forceRespawn",_this]; };
            };
         };
      } forEach ((units _x) select { !(_x inArea _marker) });
      _temp = { alive _x } count (units _x);
      if (_temp isEqualTo 0) then { deleteGroup _x; } else { _temp2 pushBack _x; };
      _counter = _counter + _temp;
   } forEach _units;
   _units = _units arrayIntersect _temp2;

   if (_debug) then { systemChat format["[DEBUG] В зоне ""%1"" осталось %2 живых единиц противника",_marker,_counter]; };

   if (_countUnits / 10 < _counter ) then
   {
      sleep 20;
      if (triggerActivated _trigger) then
      { 
         [_marker,_trigger,_units,_countUnits,_victoryColor,_unitsCiv,_unitsAnim,_debug] spawn AF_checkZone;
      } else 
      { 
         for "_i" from 1 to 5 do
         {
            sleep 20;
            if (triggerActivated _trigger) exitWith
            { 
               [_marker,_trigger,_units,_countUnits,_victoryColor,_unitsCiv,_unitsAnim,_debug] spawn AF_checkZone;
            };
            if (_i isEqualTo 5 && { !(triggerActivated _trigger) } ) then
            {
               [_marker,_trigger,_units,_unitsCiv,_unitsAnim,_debug] spawn AI_remove;
               { _x allowDamage false; } forEach (arrayCachePos select { _x inArea _marker });
            };
         };
      };
   } else
   {
      (selectRandom AF_musicZoneCaptured) remoteExec ["playMusic",0];
      private _handle = [_marker,_trigger,_units,_unitsCiv,_unitsAnim,_debug] spawn AI_remove;
      waitUntil { sleep 1; scriptDone _handle };
      _marker setMarkerColor _victoryColor;
      _marker setMarkerAlpha 1;
      _marker setMarkerBrush "FDiagonal";
      deleteVehicle _trigger;
      if (_debug) then { private _markerDeb = format["%1_debug",_marker]; _markerDeb setMarkerText format["Зона захвачена, триггер удалён.  || Зона: ""%1""",_marker]; };
   };
};

// наполнение дома обычной зоны
AF_fillHouse =
{
   private _houses 		   = _this select 0;
   private _countUnits 	   = _this select 1;
   private _pool			   = _this select 2;
   private _sideEnemy	   = _this select 3;
   private _trigger		   = _this select 4;
   private _units			   = [];
   private _house			   = _houses deleteAt floor (random count _houses);

   if (alive _house) then
   {
      private _buildPositions	= _house buildingPos -1;
      private _countBuildPoss	= ceil random (count _buildPositions / 2);
      if (_countUnits < _countBuildPoss) then { _countBuildPoss = _countUnits; };
      private ["_pos","_unit"];

      for "_i" from 1 to _countBuildPoss do
      {
         _pos = _buildPositions deleteAt floor (random count _buildPositions);
         _unit = (createGroup _sideEnemy) createUnit [selectRandom _pool, _pos, [], 0, "CAN_COLLIDE"];
         _unit setFormDir (((_trigger getDir _pos) - 45) + round random 90);
         [_unit,"inf"] spawn AF_setSkill;
         _unit setUnitPos selectRandom ["MIDDLE","UP"];
         _units pushBack group _unit;
         _countUnits = _countUnits - 1;
      };
      sleep 0.5;
   };
   if (_countUnits > 0 && count _houses > 0) then 
   { 
      _units append ([_houses,_countUnits,_pool,_sideEnemy,_trigger] call AF_fillHouse);
   };

   _units
};

// проверка стратегической зоны
AF_stratCheckZone =
{
   private ["_temp"];
   private _marker			= _this select 0;
   private _trigger			= _this select 1;
   private _units				= _this select 2;
   private _countUnits		= _this select 3;
   private _victoryColor	= _this select 4;
   private _debug				= _this select 5;
   private _counter			= 0;
   private _temp2				= [];
   _trigger			setVariable ["handler2",_thisScript];

   if !(isNil {_trigger getVariable "stObjectsDestroyed"}) exitWith { [_marker,_trigger,_units,_debug] spawn AF_stratObjectFail; };

   {
      sleep 0.1;
      {
         if !(_x in allPlayers) then { _x setDamage 1; } else
         {
            ["pictures\hint_pic\escape_zone_icon.paa","AF_ss_outOfZone"] remoteExec ["AF_hintPicture",_x];
            _x spawn
            {
               sleep 30;
               if ( alive _this && !isHidden _this && ((AF_activatedMrkrs findIf { _this inArea _x }) isEqualTo -1) ) then { _this remoteExec ["forceRespawn",_this]; };
            };
         };
      } forEach ((units _x) select { !(_x inArea _marker) });
      _temp = { alive _x } count (units _x);
      if (_temp isEqualTo 0) then { deleteGroup _x; } else { _temp2 pushBack _x; };
      _counter = _counter + _temp;
   } forEach _units;
   _units = _units arrayIntersect _temp2;

   if (_debug) then { systemChat format["[DEBUG] В зоне ""%1"" осталось %2 живых единиц противника",_marker,_counter]; };

   if (_countUnits / 10 < _counter ) then
   {
      sleep 20;
      if (triggerActivated _trigger) then
      {
         if !(isNil {_trigger getVariable "stObjectsDestroyed"}) exitWith { [_marker,_trigger,_units,_debug] spawn AF_stratObjectFail; };
         [_marker,_trigger,_units,_countUnits,_victoryColor,_debug] spawn AF_stratCheckZone;
      } else 
      { 
         for "_i" from 1 to 5 do
         {
            sleep 20;
            if !(isNil {_trigger getVariable "stObjectsDestroyed"}) exitWith { [_marker,_trigger,_units,_debug] spawn AF_stratObjectFail; };
            if (triggerActivated _trigger) exitWith
            { 
               [_marker,_trigger,_units,_countUnits,_victoryColor,_debug] spawn AF_stratCheckZone;
            };
            if (_i isEqualTo 5 && { !(triggerActivated _trigger) } ) then
            {
               [_marker,_trigger,_units,_debug] spawn AF_stratRemoveAI;
               { _x allowDamage false; } forEach (arrayCachePos select { _x inArea _marker });
            };
         };
      };
   } else
   {
      [selectRandom AF_musicZoneCaptured,
      {
         playMusic _this;
         ["pictures\hint_pic\strategic_object.paa",format[
            "<t size='1.2' color='#99ffffff' align='center'>%1</t><br/><t size='1.2' color='#006400' align='center'>%2</t><br/><t size='1.2' color='#99ffffff' align='center'>%3</t><br/><br/><t size='1.2' color='#99ffffff' align='center'>%4</t>",
            localize "AF_stratZone",localize "AF_stratZoneCaptured",localize "AF_stratZoneCapturedDis1",localize "AF_stratZoneCapturedDis2"]
         ] spawn AF_hintPicture;
      }] remoteExec ["spawn",-2];
      _marker setMarkerColor _victoryColor;
      _marker setMarkerAlpha 1;
      _marker setMarkerBrush "FDiagonal";
      /*waitUntil 
      { 
         sleep 20;
         if !(isNil { _trigger getVariable "stObjectsDestroyed" }) exitWith 
         {
            [_marker,_trigger,_units,_debug] spawn AF_stratObjectFail;  
         };

         !(triggerActivated _trigger)
      };*/
      private _script = [_marker,_trigger,_units,_debug,true] spawn AF_stratRemoveAI;
      waitUntil { sleep 5; scriptDone _script; };
      _marker setMarkerAlpha 1;
      AF_cMaxKill = AF_cMaxKill + 5;
      AF_pMaxDT = AF_pMaxDT + 20;
      deleteVehicle _trigger;
      [[AF_cDeads,AF_cMaxKill,5],[AF_pDT,AF_pMaxDT,20],AF_cacheCount] remoteExec ['AF_statIGUI',-2];
      if (_debug) then { private _markerDeb = format["%1_debug",_marker]; _markerDeb setMarkerText format["Зона захвачена, триггер удалён.  || Зона: ""%1""",_marker]; };
   };
};

// Уничтожен стратегический объект
AF_stratObjKilled =
{
   private ["_obj"];

   private _object 			   = _this;
   private _objHandler			= _object getVariable "handler";
   private _trigger			   = _object getVariable "trigger";
   private _marker				= _trigger getVariable "mrkr";
   private _stratObjects		= _trigger getVariable "stratObjects";
   { _x removeEventHandler ["Killed",(_x getVariable "handler")]; } forEach _stratObjects;
   _stratObjects = _stratObjects - [_object];

   for "_i" from 1 to (count _stratObjects) do
   {
      sleep selectMax [0.5,( 4 - 0.5 * _i )];
      _obj = _stratObjects deleteAt floor random count _stratObjects;
      _obj setDamage 1;
      // и сюда эффекты пихать будем
   };
   _trigger setVariable ["stObjectsDestroyed",true];
};

// уничтожен стратегический объект - фейл
AF_stratObjectFail =
{
	private _marker			   = _this select 0;
	private _trigger			   = _this select 1;
	private _units				   = _this select 2;
	private _debug				   = _this select 3;
	_marker setMarkerColor "ColorBlack";
   _marker setMarkerBrush "DiagGrid";
	[selectRandom AF_musicZoneCaptured,
   {
      playMusic _this;
      ["pictures\hint_pic\explosion.paa",format[
         "<t size='1.2' color='#99ffffff' align='center'>%1</t><br/><t size='1.2' color='#8B0000' align='center'>%2</t><br/><t size='1.2' color='#99ffffff' align='center'>%3</t>",
         localize "AF_stratZone",localize "AF_stratZoneFail",localize "AF_stratZoneFailDis"]] spawn AF_hintPicture;
   }] remoteExec ["spawn",-2];
	waitUntil { sleep 30; !(triggerActivated _trigger) };
	private _script = [_marker,_trigger,_units,_debug] spawn AF_stratRemoveAI;
	waitUntil { sleep 5; scriptDone _script; };
   _marker setMarkerAlpha 1;
	deleteVehicle _trigger;
};







////////////////////////////////////////////////////////////////////
///////                                                      ///////
///////                    Массивы данных                    ///////
///////                                                      ///////
////////////////////////////////////////////////////////////////////








AF_ActTrgrs = 0;
AF_ActStrat = 0;

// Навыки пехоты в зонах
inf_skill = [
   0.30,        // aimingAccuracy
   0.45,        // aimingShake
   .7,        // aimingSpeed
   1,         // spotDistance
   .5,        // spotTime
   1,        // courage
   1,        // reloadSpeed
   1,        // commanding
   1        // general
];

AF_InfMarkers = [  // !!!!!! тут указываются маркера, в которых спавнятся юниты !!!!!!!!
   "mk",
   "mk_1",
   "mk_2",
   "mk_3",
   "mk_4",
   "mk_5",
   "mk_6",
   "mk_7",
   "mk_8",
   "mk_9",
   "mk_10",
   "mk_11",
   "mk_12",
   "mk_13",
   "mk_14",
   "mk_15",
   "mk_16",
   "mk_17",
   "mk_18",
   "mk_19",
   "mk_20",
   "mk_21",
   "mk_22",
   "mk_23",
   "mk_24",
   "mk_25",
   "mk_26",
   "mk_27",
   "mk_28",
   "mk_29",
   "mk_30",
   "mk_31",
   "mk_32",
   "mk_33",
   "mk_34",
   "mk_35",
   "mk_36",
   "mk_37",
   "mk_38",
   "mk_39",
   "mk_40",
   "mk_41",
   "mk_42",
   "mk_43",
   "mk_44",
   "mk_45",
   "mk_46",
   "mk_47"
];

// Стратегические маркеры: ["marker_name",TYPE OF ZONE];

AF_stratMrkrs =
[
   "mk_strat_1",
   "mk_strat_2",
   "mk_strat_3",
   "mk_strat_4",
   "mk_strat_5",
   "mk_strat_6",
   "mk_strat_7",
   "mk_strat_8",
   "mk_strat_9",
   "mk_strat_10",
   "mk_strat_11",
   "mk_strat_12",
   "mk_strat_13",
   "mk_strat_14"
];
publicVariable "AF_stratMrkrs";

AF_stratObjectsTypes =
[
   "Land_TTowerBig_2_F",
   "Land_Ss_hangar",
   "Land_A_Castle_Bergfrit",
   "Land_A_Castle_Donjon",
   "Land_A_Castle_Gate",
   "Land_A_Office01",
   "Land_Ind_SawMill",
   "Land_Ind_Pec_02",
   "Land_A_BuildingWIP",
   "Land_ind_silomale",
   "Land_Ind_Pec_03b",
   "Land_Ind_Vysypka"
];


