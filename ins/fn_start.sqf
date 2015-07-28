private ["_data","_objectives","_bases","_roadblocks","_objs"];
sleep 0.1;
if (!isServer) ExitWith {
};
he_side = opfor;
he_faction = "rhs_faction_vdv";
he_roadblocks = [];
he_objs = [];

_data = [he_side,he_faction] call he_fnc_getUnitsFromFaction;
_objectives = (units MasterMilitary) - [MasterMilitary];
_bases = [];
he_objs = _objectives;
///// Spawn Defenders and base equipment
{

	_trigger = createTrigger ["EmptyDetector",getpos _x,false];
	_trigger setVariable ["objective",_x];
	_trigger setTriggerArea [2500, 2500, 0, false];
	_trigger setTriggerActivation ["WEST","PRESENT",false];
	_trigger setTriggerStatements ["this","[thisTrigger getVariable 'objective'] spawn he_fnc_spawnDefenders",""];

} foreach _objectives;



_roadblocks = count (_objectives)/2;
_objs = he_objs;
for "_i" from 1 to _roadblocks do
{
	[_objs] spawn he_fnc_generateRoadblock;
};




sleep 30;


publicVariable "f_grpMkr_groups";
publicVariable "f_grpMkr_data";
publicVariable "f_grpMkr_id";
publicVariable "f_grpMkr_delay";


{deleteVehicle _x } foreach allDead;
[["Head's Insurgency","Ready to play!"],"ws_fnc_showIntro",true] call bis_fnc_MP;

