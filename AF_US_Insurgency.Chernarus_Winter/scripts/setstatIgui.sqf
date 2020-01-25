if (!hasInterface) exitWith {};

disableSerialization;

private _c			= _this select 0;
private _p			= _this select 1;
private _cDead 		= _c select 0;
private _pDead 		= _p select 0;
private _caches		= _this select 2;
private _firstRun	= _this select 3;

private _cMax		= _c select 1;
private _pMax		= _p select 1;

private _cPlus		= _c select 2;
private _pPlus		= _p select 2;

private _cacheCount	= "AF_cacheCount" call BIS_fnc_getParamValue;
private _display 	= uiNameSpace getVariable "AFPoints";

if (!isNil "_firstRun" && ( { (_caches == 1) || ((_pMax - _pDead) < 16) || ((_cMax - _cDead) < 6) })) then { ['playMusic',['LeadTrack01_F']] spawn BIS_fnc_jukebox; };

private _str		= "<t shadow='2'>%1 ";
_str 				= _str + (["%2/%3 </t>","</t><t shadow='2' color='#FF0000'>%2</t><t shadow='2'>/%3 </t>"] select ((_cMax - _cDead) < 6));
_str				= _str + (["<t color='#32CD32' shadow='2'>(+%10)</t><t shadow='2'> || %4 ","<t shadow='2'>|| %4 "] select (_cPlus isEqualTo 0));
_str 				= _str + (["%5/%6 ","</t><t shadow='2' color='#FF0000'>%5</t><t shadow='2'>/%6 "] select ((_pMax - _pDead) < 16));
_str				= _str + (["<t color='#32CD32' shadow='2'>(+%11)</t><t shadow='2'> || %7 ","<t shadow='2'>|| %7 "] select (_pPlus isEqualTo 0));
_str 				= _str + (["%8/%9</t>","</t><t shadow='2' color='#800080'>%8</t><t shadow='2'>/%9</t>"] select (_caches == 1));

if (isNil "_display") exitWith {};
_setText = _display displayCtrl 1001;

private _text = format[_str,localize "AF_iguiCIVs", _cDead,[_cMax,localize "STR_AF_par_unlimited"] select (_cMax > 999998),localize "AF_iguiPs",_pDead,[_pMax,localize "STR_AF_par_unlimited"] select (_pMax > 999998),localize "AF_iguiCaches",(_cacheCount - _caches),_cacheCount,[_cPlus,""] select (_cPlus isEqualTo 0),[_pPlus,""] select (_pPlus isEqualTo 0)];

_setText ctrlSetStructuredText (parseText _text);
_setText ctrlCommit 0;

// Потери гражданских: 0/30 || Потери армии США: 0/50