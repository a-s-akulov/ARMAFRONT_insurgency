private _picture		= _this select 0;
private _str			= _this select 1;

private _hull			= ["<br/><img size='3' color='#595923' align='center' image='%1' /><br/><br/><t size='1.2' color='#99ffffff' >%2</t><br/><br/>",
								"<t size='1.2' color='#99ffffff' >%1</t><br/>"] select (_picture isEqualTo "");

call
{
	if ((typeName _str) isEqualTo "STRING") exitWith
	{
		_str = localize (_this select 1);
		if (_str isEqualTo "") then { _str = _this select 1; };
	};
	if ((typeName _str) isEqualTo "ARRAY") exitWith
	{
		private _arr	= [];
		private 		"_temp";
		{
			_temp		= localize _x;
			if (_temp isEqualTo "") then { _temp = _x; };
			_arr		pushBack _temp;
		} forEach _str;
		if !(_str isEqualTo []) then { _str = _arr joinString ""; } else { _str = "HINT_WITH_PICTURE - LOCALIZE ARRAY ERROR"; };
	};
};

if !(_picture isEqualTo "") then
{
	hint parseText format[_hull,_picture,_str];
} else
{
	hint parseText format[_hull,_str];
};