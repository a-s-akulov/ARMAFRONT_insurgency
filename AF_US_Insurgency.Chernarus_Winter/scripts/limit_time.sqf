//by KOKaKOJIbKA
private "_timeL";
_timeL = _this select 0;
[_timeL] spawn {
	private "_timeL";
	_timeL = _this select 0;
	_sleep = _timeL;
	sleep _sleep;
	if (AF_cacheCount > 0) exitWith {
		[["task_0","FAILED"],"BIS_fnc_taskSetState",true,false] call BIS_fnc_MP;
		sleep 5;
		["Time_Out",false] remoteExec ["BIS_fnc_endMission",AF_sidePlayer];
		"Time_Out_ss" remoteExec ["BIS_fnc_endMission",AF_sideEnemy];
	};
}