waitUntil {!isNull(findDisplay 12)};
_display		= findDisplay 12;
_control		= _display displayCtrl 51;

if (side group player isEqualTo AF_sideEnemy) then
{
	_control ctrlAddEventHandler ["Draw", 
	{
		if ( isObjectHidden player && { alive player } ) then
		{
			private _position		= findDisplay 12 displayCtrl 51 ctrlMapScreenToWorld getMousePosition;
			private _marker			= AF_activatedMrkrs findIf { _position inArea _x };
			if !(_marker isEqualTo -1) then
			{
				_marker				= AF_activatedMrkrs select _marker;
				_position			= [getMarkerPos _marker];
				_position			appEnd [(getMarkerSize _marker) select 0, (getMarkerSize _marker) select 1, markerDir _marker, [1,1,1,1], "#(rgb,8,8,3)color(0.25,0.8,0,0.4)"];
				switch (markerShape _marker) do
				{
					case "RECTANGLE" : { (findDisplay 12 displayCtrl 51) drawRectangle _position; };
					default	{ (findDisplay 12 displayCtrl 51) drawEllipse _position; };
				};
			};
		};
	}];
};