//Katletka did this ;D

disableSerialization;	
_a = 0 call AF_Slots_Switcher;
CreateDialog "af_MainSlots";
WaitUntil { !isNull (findDisplay 456965) };
ctrlSetText [999444,localize "SlotsInBattle"];
ctrlSetText [999555,localize "SlotsCancel"];
ctrlSetText [999666,localize "SlotsBackToRoleSwitch"];
ctrlEnable [4567654, false];
private _control = findDisplay 456965;
_control = _control displayCtrl 999777;
_control ctrlSetStructuredText parseText format ["<t align='center' color='#ff1500'>%1 %2%3 %4 %5",localize "SlotsFirstMessage1",_a select 0,localize "SlotsFirstMessage2",(count _a - 2),localize "SlotsFirstMessage3"];
_control = findDisplay 456965;
_control = _control displayCtrl 999778;
_control ctrlSetStructuredText parseText format["<t color='#000000'>%1</t>",(_a select 1)];
for "_i" from 999100 to 999110 do { ctrlEnable [_i, false]; };
for "_i" from 2 to (count _a - 1) do
{
	ctrlSetText [(_i + 998999),_a select _i];
	ctrlEnable [(_i + 999099), true];
	buttonSetAction [(_i + 999099), format [
	"
		private _idc_frame = %2 + 100;
		for ""_i"" from 999200 to 999210 do {_control = findDisplay 456965; _control = _control displayCtrl _i; _control ctrlSetTextColor [0,0.8,0,0]; };
		_control = findDisplay 456965;
		private _control_dis = _control displayCtrl 999333;
		_control = _control displayCtrl _idc_frame;
		_control ctrlSetTextColor [0,0.8,0,1];
		_control_dis ctrlSetStructuredText parseText (format [""Discription_%1"",""%1""] call AF_Slots_Switcher);
		buttonSetAction [999444,""[] execVM (%1 call AF_Slots_Switcher); private _control = findDisplay 456965; _control closeDisplay 0;""];
	",(_i-1),(_i + 999099)]];	
};