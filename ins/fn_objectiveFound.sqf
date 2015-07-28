private [];
_name = _this select 0;
_objective = _this select 1;
if(!hasInterface || isServer) then
{
	[_objective, _name, "\A3\ui_f\data\map\mapcontrol\Bunker_CA.paa",[1,0,0,1],[24,24]] call F_fnc_addGroupMarker;
	[format ["%1_task", _name], true, [format ["Clear the %1", _name],_name,"hd_objective"], _objective, "AUTOASSIGNED", 0, false, true , "", true ] call BIS_fnc_setTask;
	_objective setVariable ["task",format ["%1_task", _name]];
	publicVariable "f_grpMkr_groups";
	publicVariable "f_grpMkr_data";
	publicVariable "f_grpMkr_id";
	publicVariable "f_grpMkr_delay";
};
if(hasInterface) then {
	["ObjectiveFound",[_name]] spawn BIS_fnc_showNotification;
};