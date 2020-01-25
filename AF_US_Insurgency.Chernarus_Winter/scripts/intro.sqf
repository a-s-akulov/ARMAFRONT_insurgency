waitUntil {!isNull(findDisplay 46)};
0 fadeSound 0;
0 fadeMusic 0;
_script = [
	arsenal_box,	// Цель ( для маркера markerPos "Имя маркера";)
	localize "IntroMessage",	// Текст
	50,						// Высота
	200,					// Радиус
	270,					// Угол
	1					// По часовой 1, 0 против
] spawn BIS_fnc_establishingShot;
waitUntil { scriptDone _script };
enableSaving [false,false];
if (side group player isEqualTo AF_sideEnemy) then { [] spawn AF_Sside_pRespawn; };
5 fadeSound 1;
5 fadeMusic 1;
sleep 5;
AF_firestResawn = nil;
[parseText "<t font='PuristaBold' size='4'>AF Insurgency</t><br />By armafront.com", [0,0,1,1], 10, 7, [2,2], 0] spawn BIS_fnc_textTiles;


[localize "AF_welcome",name player] spawn BIS_fnc_infoText;