/*
	author: DEXTER
	description: none
	returns: nothing
*/
disableSerialization;
private ["_veh","_magsCurrent","_typeVeh","_allPylonsNames","_counPylons","_equipedMag","_i","_ctrl"];
waitUntil{!isnull (findDisplay 456963);};
_veh = zlo_VehicleClass;
_typeVeh = (typeOf _veh);

_magsCurrent = getPylonMagazines (_veh);
_allPylonsNames = (configProperties [configFile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons"]) apply {configName _x};
_counPylons = count _allPylonsNames;
_i = 0;
//configfile >> "CfgVehicles" >> "B_Plane_CAS_01_dynamicLoadout_F" >> "Components" >> "TransportPylonsComponent" >> "uiPicture"

_crew = crew (vehicle player); 
_driver = driver (vehicle player); 
{ 
 if!(_x isEqualTo _driver)then 
 { 
  //remoteExec["moveOut",_x,false]; 
  //[[_x], "moveOut", false, false] call BIS_fnc_MP; 
  moveOut _x; 
 } 
} forEach _crew;

_ctrl = (findDisplay 456963) displayCtrl (_i+2101); 
_magTurret = [];
{
	_array =  getArray(configfile >> "CfgVehicles" >> _typeVeh >> "Components" >> "TransportPylonsComponent" >> "Pylons" >> _x >> "turret");;
	_magTurret pushBack _array;
	//systemChat format ["%1",_array];

}forEach _allPylonsNames;
_needChange = 0;

_pylonWeaponsBefore =[];
{
	_pylonWeaponsBefore pushBack	getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon");
} forEach _magsCurrent;
//systemChat format ["%1 - Пополнение БК : Завершена", getText (configfile >> "CfgVehicles" >> typeOf _veh >> "displayName")];
while{_i < _counPylons} do
{
	_avaiableMags = _veh getCompatiblePylonMagazines _i+1;
	_ctrl = (findDisplay 456963) displayCtrl (_i+2101);
	_indexPylon = lbCurSel _ctrl;
	_c = 0;
	if(_indexPylon != 0)then
	{
//configfile >> "CfgVehicles" >> "rhs_mig29s_base" >> "icon"
//configfile >> "CfgVehicles" >> "rhs_mig29s_base" >> "Attributes" >> "rhs_decalNoseArt" >> "expression"
	    {
	        //configfile >> "CfgVehicles" >> "CUP_O_SU34_RU" >> "Components" >> "TransportPylonsComponent" >> "pylons" >> "pylons1" >> "turret"
    	    if(_indexPylon == _c+1) then
    		{
				if!(getText(configFile >> "CfgMagazines" >> _magsCurrent select _i >> "displayName") isEqualTo (_ctrl lbText _c+1))then
				{
					if(ZLO_W_Slot select _i isEqualTo -1)then
					{
						_veh setPylonLoadOut [_allPylonsNames select _i,_x,false,[]];

					};
					if(ZLO_W_Slot select _i isEqualTo 0)then
					{
						_veh setPylonLoadOut [_allPylonsNames select _i,_x,false,[0]];
					};
					_veh setAmmoOnPylon [_i-1,getNumber (configfile >> "CfgMagazines" >> _x >> "count")];
					
					_needChange = _needChange + 1;
				};
    		};
    		_c = _c + 1;
    	}forEach _avaiableMags;
	};
	if(_indexPylon == 0)then
	{
		if(ZLO_W_Slot select _i isEqualTo -1)then
		{
			_veh setPylonLoadOut [_allPylonsNames select _i,"",false,[]];
		};
			if(ZLO_W_Slot select _i isEqualTo 0)then
		{
			_veh setPylonLoadOut [_allPylonsNames select _i,"",false,[0]];
		};
	};
	_i = _i + 1;
};



/*
if({_x ==  _pylonWeapons select _i} count _pylonWeapons < 1)then
		{
					systemChat format ["del 1%1",_pylonWeapons select _i];
			_veh removeWeaponGlobal (getText (configFile >> "CfgMagazines" >> _pylonWeapons select _i >> "pylonWeapon"));
					systemChat format ["delted 1%1",_pylonWeapons select _i];
		};


_pylonWeapons = _magsCurrent apply {getText ((configfile >> "CfgMagazines" >> _x >> "pylonWeapon"))};

{
	_veh removeWeaponGlobal getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon");
} forEach _magsCurrent;
systemChat format ["weapons : %1",_pylonWeapons];
*/
//#############
//skin
//#############
//<img image='%1' />      getText (configfile >> "CfgVehicles" >> typeOf _veh >> "icon")
//#########
//#Refuel/Repair/ammo
//#########
/*
(findDisplay 456963) displayCtrl(2800) - fuel 30
(findDisplay 456963) displayCtrl(2801) - repair 60
(findDisplay 456963) displayCtrl(2802) - ammo 30
                                             60
*/
//30-3
_timeFuel = TIME_TO_FUEL;//30
_timeRepair = TIME_TO_REPAIR;//60
_timeAmmo = TIME_TO_AMMO;//30
_timePylons = TIME_FOR_PYLON;//30
_timeSkin = TIME_FOR_SKIN;
_tTime = 0;
zlo_VehicleInAsisstance = false;
_refuel = cbChecked ((findDisplay 456963) displayCtrl(2800));
_repair =cbChecked ((findDisplay 456963) displayCtrl(2801));
_ammo =cbChecked ((findDisplay 456963) displayCtrl(2802));
_ctrl = (findDisplay 456963) displayCtrl 2100;
_selCamo = lbCurSel _ctrl;

closeDialog 0;
if((alive _veh) isEqualTo true)then
{		
	
		
	if((_refuel)isequalto true)then
	{
		_tTime = _tTime + _timeFuel;
		zlo_VehicleInAsisstance = true;
	};
	if((_repair)isequalto true)then
	{
		_tTime = _tTime + _timeRepair;
		zlo_VehicleInAsisstance = true;
	};
	if((_ammo)isequalto true)then
	{
		_veh setVehicleAmmo 0;
		_tTime = _tTime + _timeAmmo;
		zlo_VehicleInAsisstance = true;
	};
	if(_needChange > 0)then
	{
		_tTime = _tTime + _timePylons;
		zlo_VehicleInAsisstance = true;
	};
	if(_needChange > 1)then
	{
		_tTime = _tTime + _timePylons;
		zlo_VehicleInAsisstance = true;
	};
	if(_needChange > 2)then
	{
		_tTime = _tTime + _timePylons;
		zlo_VehicleInAsisstance = true;
	};
	if(_needChange > 3)then
	{
		_tTime = _tTime + _timePylons;
		zlo_VehicleInAsisstance = true;
	};
	if(_needChange > 4)then
	{
		_tTime = _tTime + _timePylons;
		zlo_VehicleInAsisstance = true;
	};
	if(_needChange > 5)then
	{
		_tTime = _tTime + _timePylons;
		zlo_VehicleInAsisstance = true;
	};
	if(_selCamo > 0)then
	{
		_tTime = _tTime + _timeSkin;
		zlo_VehicleInAsisstance = true;
	};
	//maitenance on start
	//hint parseText format["<br /><img image='ZLoad\img\wr.jpg' /><br />%1 :<t color='#FF0000'>%2</t> %3<br /> <br /> ",localize "zlo_wait_text",_tTime,localize"zlo_sec_text"];	
	zlo_enableaction = false ;
	if(TIME_TESTING_MOD isEqualTo true)then
	{
		_tTime = 2;
	};
	[_tTime]spawn zlo_fnc_hideACT;
	while {_tTime > 0} do {
		uiSleep 1;
		//hintSilent parseText format["<br /><img image='ZLoad\img\wr.jpg' /><br />%1 :<t color='#FF0000'>%2</t> %3<br /> <br /> ",localize "zlo_wait_text",_tTime,localize"zlo_sec_text"];
		_tTime = _tTime - 1;
	};
	zlo_enableaction = true ;
	hint parseText format["<br /><img image='ZLoad\img\wr.jpg' /><br /><t color='#1f8636'>%1</t><br /> <br /> ",localize "zlo_serviceeeady_text"];
	if((_repair)isequalto true)then
		{
				_veh setDamage 0;
		zlo_VehicleInAsisstance = true;
		};
		if((_ammo)isEqualTo true) then
		{	


				_magsCurrent = getPylonMagazines _veh;

_pylonWeapons =[];
_counterzx = 1;

	if(ZLO_W_Slot select _counterzx isEqualTo -1)then
	{
		_veh setPylonLoadOut [_counterzx,"",false,[]];
		uiSleep 0.5;
		_veh setPylonLoadOut [_counterzx,(_magsCurrent select _counterzx),false,[]];
	};
	if(ZLO_W_Slot select _counterzx isEqualTo 0)then
	{
		_veh setPylonLoadOut [_counterzx,"",false,[0]];
		uiSleep 0.5;
		_veh setPylonLoadOut [_counterzx,(_magsCurrent select _counterzx),false,[0]];
	};

sleep 0.5;

			[[_veh,ZLO_W_Slot],"Zload\fn_setammoMP.sqf"] remoteExec ["execVM", 0, false];
		zlo_VehicleInAsisstance = true;
		};
		if(_needChange > 6)then
		{

				_magsCurrent = getPylonMagazines _veh;

_pylonWeapons =[];
_counterzx = 1;

	if(ZLO_W_Slot select _counterzx isEqualTo -1)then
	{
		_veh setPylonLoadOut [_counterzx,"",false,[]];
		uiSleep 0.5;
		_veh setPylonLoadOut [_counterzx,(_magsCurrent select _counterzx),false,[]];
	};
	if(ZLO_W_Slot select _counterzx isEqualTo 0)then
	{
		_veh setPylonLoadOut [_counterzx,"",false,[0]];
		uiSleep 0.5;
		_veh setPylonLoadOut [_counterzx,(_magsCurrent select _counterzx),false,[0]];
	};

sleep 0.5;
			//[1, "setVehicleAmmo", _veh, false, false] call BIS_fnc_MP;
		[[_veh,ZLO_W_Slot],"Zload\fn_setammoMP.sqf"] remoteExec ["execVM", 0, false];
		zlo_VehicleInAsisstance = true;

			//systemChat format ["ПРИКОЛ"];
		};
	if((_refuel)isequalto true)then
		{
			_veh setFuel 1;
		}else
		{
			_veh setFuel zlo_VehicleFuel;
		};
		zlo_VehicleInAsisstance = false;
};

_pylonWeapons =[];		
{
		_pylonWeapons pushBack	getText (configFile >> "CfgMagazines" >> _x >> "pylonWeapon");
} forEach _magsCurrent;

{
	if((_pylonWeapons find _x) isEqualTo -1)then
	{
		_veh removeWeaponGlobal _x;
	};
}forEach _pylonWeaponsBefore;
	
_veh setVariable["ZLO_W_SLOT",ZLO_W_Slot];
_InfoMagazines = magazinesAllTurrets _veh;
_camoCountSources = "true" configClasses (configfile >> "CfgVehicles" >> _typeVeh >> "textureSources");
_camoTextures = [""];
_camoNames = [""];
_i = 0;
if (_selCamo > -1) then
{
	if(count _camoCountSources > 0) then
	{
		{
			_camoTextures pushback (getArray (configfile >> "CfgVehicles" >> _typeVeh >> "textureSources" >> configName _x >> "textures"))
		}forEach _camoCountSources;

		{
			_index = (_camoTextures select _selCamo+1) find _x;
			_veh setObjectTextureGlobal [_index, (_camoTextures select _selCamo+1) select _index];
			_parents = [];
			_inherit = (configfile >> "CfgVehicles" >> _typeVeh);
			while{!isNull _inherit}do
			{
			    _parents pushBack configName _inherit;
			    _inherit = inheritsFrom _inherit;
			};
			{
			    if("CUP_AV8B_Base" isEqualTo _x)then
			    {
			        _veh setObjectTextureGlobal [_index+1, (_camoTextures select _selCamo+1) select _index];
			    };
			}forEach _parents;
			//textures[] = {"cup\airvehicles\cup_airvehicles_av8b\data\texture\CUP_av8b_aaf_1_co.paa","cup\airvehicles\cup_airvehicles_av8b\data\texture\CUP_av8b_aaf_1_co.paa","#(argb,512,512,1)r2t(rendertarget0,1.0)"};
		} foreach (_camoTextures select _selCamo+1);
	};
};
			