_sec		= missionNamespace getVariable (_this select 0);
_display	= _this select 1;
if (_sec isEqualTo 0) exitWith {};

AF_timer_var = _this select 0;

_action = switch _display do
{
	case "cutText" : 
	{ 
		{
			private _sec		= missionNamespace getVariable AF_timer_var;
			'normal' cutText [format['<t color="#ff0000" size="5">%1</t>',[_sec,'MM:SS'] call BIS_fnc_secondsToString], 'PLAIN DOWN', -1, true, true];
			missionNamespace setVariable [AF_timer_var,_sec - 1];
		}
	};
};

["itemAdd", ["AF_timer", _action, 1, "seconds", { true }, { (missionNamespace getVariable AF_timer_var) < 0 }]] call BIS_fnc_loop;