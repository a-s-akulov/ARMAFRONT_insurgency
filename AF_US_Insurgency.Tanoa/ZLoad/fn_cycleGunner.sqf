
_btindx = _this select 0;//1608
_selIndx = ((ctrlIDC _btindx) - 1608);
_picCtrlIndx = (1201 + _selIndx);
_array = ZLO_W_Slot;

_ctrlx = (findDisplay 456963) displayCtrl(_picCtrlIndx);
switch (_array select _selIndx) do {
	case -1: {
		_ctrlx ctrlsettext "\a3\Ui_f\data\IGUI\Cfg\CommandBar\imageGunner_ca.paa";
		_array set[_selIndx,0];
	 };
	case 0: {
		_ctrlx ctrlsettext "\a3\Ui_f\data\IGUI\Cfg\CommandBar\imageDriver_ca.paa";
		_array set[_selIndx,-1];
	 };
	default { };
};
ZLO_W_Slot = _array;
_ctrlx ctrlCommit 0;