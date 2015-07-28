private ["_obj","_clear","_data"];
_obj = _this select 0;
_clear = _this select 1;

_id = [_obj] call F_fnc_findGroupMarkerID;
if(count _id <= 0) exitWith {};
_data = f_grpMkr_data select (_id select 0);
if(_clear) then
{
	[["ObjectiveDestroyed",[_name]],"BIS_fnc_showNotification",true] call bis_fnc_MP;
	_data set [2,"\A3\ui_f\data\map\markers\military\objective_CA.paa"]
}
else
{
	[["ObjectiveRecaptured",[_name]],"BIS_fnc_showNotification",true] call bis_fnc_MP;
	_data set [2,"\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa"]
};

publicVariable "f_grpMkr_groups";
publicVariable "f_grpMkr_data";
publicVariable "f_grpMkr_id";
publicVariable "f_grpMkr_delay";
