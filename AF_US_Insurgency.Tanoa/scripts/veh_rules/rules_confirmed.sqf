private _string = _this select 0;
private _sound = _this select 1;
private _p = player;
private _text = switch _string do 
{
	case "confirmed" : {"VR_Confirmed"};
	case "out" : {"VR_Out"};
};

	private _class = switch pRole do {
		case 9 : {"VR_Pilot"};
		case 8 : {"VR_Crewman"};
	};
	
	[[[_class,(name player),_text,_sound],{
		hintSilent parseText format [
			"<br/><img size='4' color='#595923' image='pictures\rules\tasks_ca.paa' align='center'/><br/><br/>
			<t size='1.2' color='#99ffffff' align='center'>%1</t><br/>
			<t size='1.2' color='#99ffffff' align='center'>%2</t><br/>
			<t size='1.2' color='#99ffffff' align='center'>%3 %4</t><br/><br/>",
			localize (_this select 0),
			(_this select 1),
			localize (_this select 2),
			localize "VR_Rules"
		];
		playSound (_this select 3);
	}],"spawn"] spawn BIS_fnc_MP;