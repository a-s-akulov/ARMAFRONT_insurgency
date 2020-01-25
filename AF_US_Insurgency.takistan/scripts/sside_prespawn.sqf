player allowDamage false;
player enableSimulation false;
openMap true;
["AF_sSide_openMap","onEachFrame",
{
	if !visibleMap then
	{
		openMap true;
		if (isNull findDisplay 49) then { (findDisplay 46) createDisplay "RscDisplayMPInterrupt"; };
	};
}] call BIS_fnc_addStackedEventHandler;
player remoteExec ["hideObjectGlobal",2];
if (AF_ss_respTime > 0) then
{
	["AF_ss_respTime", "cutText"] spawn AF_timer;
};