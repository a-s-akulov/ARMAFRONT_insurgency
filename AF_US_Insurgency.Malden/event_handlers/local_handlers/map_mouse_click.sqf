waitUntil {!isNull(findDisplay 12)};
_display		= findDisplay 12;
_control		= _display displayCtrl 51;


if (side group player isEqualTo AF_sideEnemy) then
{
	_control ctrlAddEventHandler ["MouseButtonClick",
	{
		if (!alive player || !isObjectHidden player) exitWith {};

		private _position = findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld getMousePosition;
		private _marker			= AF_activatedMrkrs findIf { _position inArea _x };
		if !(_marker isEqualTo -1) then
		{
			_marker				= AF_activatedMrkrs select _marker;
			if !AF_ss_respAllow exitWith { ["","AF_ssr_notNow"] spawn AF_hintPicture; };
			if (AF_ss_respTime > 0) exitWith { ["",["AF_ssr_fewSeconds_1",str AF_ss_respTime,"AF_ssr_fewSeconds_2"]] spawn AF_hintPicture; };

			private _units		= allUnits - allPlayers - allDead;
			_units				= _units select { _x inArea _marker && AF_sideEnemy isEqualTo side group _x && ( isNull objectParent _x || (!(isNull objectParent _x) &&
					_x isEqualTo (leader group _x) && (count crew vehicle _x) > 1 ) ) };

			if ((count _units) isEqualTo 0) exitWith { ["","AF_ssr_noUnitsAvailable"] spawn AF_hintPicture; };
			_units				= selectRandom _units;
			private _p			= player;
			["AF_sSide_openMap","onEachFrame"] call BIS_fnc_removeStackedEventHandler;
			selectPlayer _units;
			deleteVehicle _p;
			openMap false;
			AF_ss_respTime = 30; // тут - время возрождения, без штрафов
			
			// тут можно какие-нибудь эффекты камеры прикрутить (к примеру: как в гта 5 (как бы я ее ни не любил))

		};
	}];
};