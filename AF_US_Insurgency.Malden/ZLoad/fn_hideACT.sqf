_Ttime = _this select 0;

player removeAction ZLO_INDX;
ZLO_INDX = player addaction ["",{},nil,12,true,true,"",format["(zlo_enableaction isEqualTo false)"],-1,false,""];
while{_Ttime > 0}do
{
	player setUserActionText [
	ZLO_INDX, 
	format["%2<t color='#ff0000'>%1",localize "zlo_service_name","",_Ttime], 
	"", 
	format["<br /><img image='ZLoad\img\wr.jpg' /><br />%1 :<t color='#FF0000'>%2</t> %3<br /> <br /> ",localize "zlo_wait_text",_tTime,localize"zlo_sec_text"]
	
];
_Ttime = _Ttime - 1;
uiSleep 1;
};
player removeAction ZLO_INDX;
ZLO_INDX = player addAction [format["%2<t color='#ff0000'>%1",localize "zlo_service_name",""],"ZLoad\fn_showDialog.sqf",nil,12,true,true,"",

	//((vehicle player != player and (player distance getMarkerPos ('%1')) < %2 and vehicle player isKindOf 'Air' and alive vehicle player and alive player and driver (vehicle player) isEqualTo player) or 
	//(getConnectedUAV player) isKindOf 'air' and ((getConnectedUAV player) distance getMarkerPos ('%1')) < %2 and alive getConnectedUAV player) and zlo_enableaction isEqualTo true
	format["(([] call ZLO_CHECK_ACTION) isEqualTo true) and (zlo_enableaction isEqualTo true)"]
,
			//	format["((vehicle player != player and (player distance getMarkerPos ('%1')) < %2 and vehicle player isKindOf 'Air' and alive vehicle player and alive player and driver (vehicle player) isEqualTo player) or (getConnectedUAV player) isKindOf 'air' and ((getConnectedUAV player) distance getMarkerPos ('%1')) < %2 and alive getConnectedUAV player) and zlo_enableaction isEqualTo true",_this select 1,_this select 2],
				-1,false,""];