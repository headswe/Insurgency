_mapControl = _this select 0;
{
	_data = _x;
	if(count _data >= 7) then
	{
		_entity = _data select 0;
		_text = _data select 1;
		_texture = _data select 2;
		_color = _data select 3;
		_size = _data select 4;
		_pos = _data select 5;
		_time = _data select 6;


		if((time - _time) > f_grpMkr_delay) then {
			if(typeName _entity == "GROUP" && {!isNull (_entity)}) then {_pos = getpos leader _entity};
			if(typeName _entity == "OBJECT" && {!isNull (_entity)}) then {_pos = getpos _entity};
			_time = time;
		};
		_data set [5,_pos];
		_data set [6,_time];
		_sizeX = _size select 0;
		_sizeY = _size select 1;
		_textsize = 0.05;
		if((ctrlMapScale _mapControl) > 0.1) then {_textsize = 0};
		_mapControl drawIcon [_texture,_color,_pos,_sizeX,_sizeY,0,_text,1,_textsize,'TahomaB',"right"];
	};
} foreach f_grpMkr_data;
_units = units player;
{
	_textsize = 0.05;
	_color = [0,0,1,1];
	if((ctrlMapScale _mapControl) > 0.1) then {_textsize = 0};
	if(_x in _units) then {_color = [0,1,0,1]};
	_mapControl drawIcon ["\A3\ui_f\data\map\markers\military\triangle_CA.paa",_color,getpos _x,12,12,getdir _x,name _x,0,_textsize,'TahomaB',"right"]
} forEach ([] call ws_fnc_listPlayers);