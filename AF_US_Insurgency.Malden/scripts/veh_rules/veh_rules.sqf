disableSerialization;
createDialog "KOKa_rules";


private _d = findDisplay 11400;
private _ek = _d displayAddEventHandler ["KeyDown", "true"];

ctrlSetText [11405,localize "VR_GUI_11405"];
ctrlSetText [11406,localize "VR_GUI_11406"];
for "_i" from 11407 to 11412 do
{
	_d displayCtrl _i ctrlSetStructuredText parseText localize format["VR_GUI_%1",_i];
};

waitUntil { !dialog };

_d displayRemoveEventHandler ["KeyDown", _ek];

cuttext ["","black in",5];