disableSerialization;
[] spawn zlo_fnc_setting;
_player = _this select 0;
zrange = _this select 2;
zmarker = _this select 1;
zlo_VehicleInAsisstance = false;
TIME_TESTING_MOD = _this select 3;
zlo_enableaction = true;
ZLO_UAV_INDX = 0;
ZLO_CHECK_ACTION = {
	_zm = zmarker;
	_zr = zrange;
	//systemChat format ["%1", typeName zmarker];
	_ret = false;
	if(!isNull objectParent player)then
	{
		if(typeName _zm isEqualTo "ARRAY")then
		{
			{
			if(Player distance (getMarkerPos _x) < _zr) then
			{
				if(((vehicle player)isKindOf "AIR")isEqualTo true and (alive (vehicle player)isEqualTo true))then
				{
					if(driver (vehicle player) isEqualTo player)then
					{
						_ret = true;
					};
				};
			};
			
			}forEach _zm;
		}else{
			if(Player distance (getMarkerPos _zm) < _zr) then
			{
				if(((vehicle player)isKindOf "AIR")isEqualTo true and (alive (vehicle player)isEqualTo true))then
				{
					if(driver (vehicle player) isEqualTo player)then
					{
						_ret = true;
					};
				};
			};
		}
	}else
	{//(getConnectedUAV player) isKindOf 'air' and ((getConnectedUAV player) distance getMarkerPos ('%1')) < %2 and alive getConnectedUAV player) and zlo_enableaction isEqualTo true
		if(typeName _zm isEqualTo "ARRAY")then
		{
			{
				_conUAV = (getConnectedUAV player);
				if(_conUAV isKindOf "AIR")then
				{
					if((_conUAV distance _x) < _zr)then
					{
						if(alive _conUAV)then
						{
							_ret = true;
						};
					};
				};
			}forEach _zm;
		}else{
			_conUAV = (getConnectedUAV player);
				if(_conUAV isKindOf "AIR")then
				{
					if((_conUAV distance _zm) < _zr)then
					{
						if(alive _conUAV)then
						{
							_ret = true;
						};
					};
				};
		};
	};
	_ret
	/*else
	{
		if((getConnectedUAV player)isKindOf "AIR" isEqualTo true)then
		{
			if(((getConnectedUAV player) distance (getMarkerPos(_x)) < _zrange))then
			{
				if(alive getConnectedUAV player) then
				{
					true	//
				}else
				{
					false
				}
			};
		};
	};*/
};
ZLO_INDX = _player addAction [format["%2<t color='#ff0000'>%1",localize "zlo_service_name",""],"ZLoad\fn_showDialog.sqf",nil,12,true,true,"",

	//((vehicle player != player and (player distance getMarkerPos ('%1')) < %2 and vehicle player isKindOf 'Air' and alive vehicle player and alive player and driver (vehicle player) isEqualTo player) or 
	//(getConnectedUAV player) isKindOf 'air' and ((getConnectedUAV player) distance getMarkerPos ('%1')) < %2 and alive getConnectedUAV player) and zlo_enableaction isEqualTo true
	format["(([] call ZLO_CHECK_ACTION) isEqualTo true) and (zlo_enableaction isEqualTo true)"]
,
			//	format["((vehicle player != player and (player distance getMarkerPos ('%1')) < %2 and vehicle player isKindOf 'Air' and alive vehicle player and alive player and driver (vehicle player) isEqualTo player) or (getConnectedUAV player) isKindOf 'air' and ((getConnectedUAV player) distance getMarkerPos ('%1')) < %2 and alive getConnectedUAV player) and zlo_enableaction isEqualTo true",_this select 1,_this select 2],
				-1,false,""];







