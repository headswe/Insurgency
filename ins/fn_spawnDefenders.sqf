private ["_object","_patrol","_garrsion","_arr","_grps","_grpPos","_guardGrp","_spawnpos","_minDist","_patrolGrps","_patrolGrp","_trg"];
_object = _this select 0;
_patrol = 0;
_garrsion = 0;




switch (typeOf _object) do {
    case "LocationBase_F": {
    	_patrol = 5;
    	_garrsion = round random 35;
    };
    case "LocationCamp_F": {
        _arr = ((getpos _object) findEmptyPosition [0,150,"B_Boat_Armed_01_minigun_F"]);
        if(count _arr > 0) then {_object setpos _arr;systemChat "found empty pos";};
    	_grps = "true" configClasses (configfile >> "CfgGroups" >> "Empty" >> "Guerrilla" >> "Camps");
		[getpos _object, sideUnknown,_grps call ws_fnc_selectRandom] spawn he_fnc_spawnGroup;
    	_patrol = 1;
    };
    case "LocationArea_F": {
    	/* STATEMENT */
    };
    case "LocationCityCapital_F": {
    	/* STATEMENT */
    };
    case "LocationEvacPoint_F": {
    	/* STATEMENT */
    };
    case "LocationFOB_F": {
    	_grps = "true" configClasses (configfile >> "CfgGroups" >> "Empty" >> "Military" >> "Outposts");
		[getpos _object, sideUnknown,_grps call ws_fnc_selectRandom] spawn he_fnc_spawnGroup;
    	_patrol = 2;
    	_garrsion = round random 25;
    };
    case "LocationOutpost_F": {
        _patrol = 2;
        _garrsion = round random 35;
    };
    case "LocationResupplyPoint_F": {
    	/* STATEMENT */
    };
    case "LocationCity_F": {
    	_patrol = 3;
    	_garrsion = round random 50;
    };
    case "LocationVillage_F": {
        _patrol = 1;
        _garrsion = round random 30;
    };
    default {
     	/* STATEMENT */
    };
};




if(_garrsion > 0) then
{
    _crated = [_object,250,he_side,_garrsion,0.7,he_soldiers] call ws_fnc_createGarrison;
    if(!isNil "_crated") then
    {    (group (_crated select 0)) spawn ws_fnc_gCache; };
};






_grpPos = ((getpos _object) findEmptyPosition [0,50,"B_Boat_Armed_01_minigun_F"]);
if(count _grpPos <= 1) then {_grpPos = getPos _object};
_guardGrp = [_grpPos, he_side, (he_infantryGroups) call ws_fnc_selectRandom] call BIS_fnc_spawnGroup;
[_guardGrp,_grpPos] spawn BIS_fnc_taskDefend;


(_guardGrp) spawn ws_fnc_gCache;


_patrol = 1 max (round (random _patrol));



_spawnpos = getpos _object;
_minDist = 25;
for "_i" from 1 to _patrol do {
    _spawnpos = [_spawnpos,400, _minDist] call ws_fnc_getPos;

    _patrolGrps = [];
    _minDist = _minDist + random 25;

    if(random 1 < 0.2) then
    {
        _patrolGrps = he_motorizedGroups;
        _patrolGrps append (he_mechanizedGroups);
    }
    else
    {
        _patrolGrps = he_infantryGroups;
        _patrolGrps append (he_motorizedGroups);
    };




    _arr = ((_spawnpos) findEmptyPosition [0,50,"B_Boat_Armed_01_minigun_F"]);
    if(count _arr > 0) then {_spawnpos = _arr;systemChat "found empty pos";};
    _patrolGrp = [_spawnpos, he_side, (_patrolGrps) call ws_fnc_selectRandom] call BIS_fnc_spawnGroup;
    [_patrolGrp, getpos _object, 100, 7, "MOVE", "SAFE", "YELLOW", "FULL", "STAG COLUMN", "", [3,6,9]] spawn CBA_fnc_taskPatrol;
    (_patrolGrp) spawn ws_fnc_gCache;
    systemChat "patrol created";
};




_trg=createTrigger["EmptyDetector",getPos _object,false];
_object setVariable ["trigger",_trg];
_trg setVariable ["owner",_object];
_trg setTriggerArea [1000,1000,0,false];
_trg setTriggerActivation["WEST","PRESENT",false];
_trg setTriggerStatements ["this", '_name = [(thisTrigger getVariable "owner")] call he_fnc_getAreaName;[[_name,(thisTrigger getVariable "owner")],"he_fnc_objectiveFound",true] call bis_fnc_MP;', ""];
/*
_trg=createTrigger["EmptyDetector",getPos _object];
_trg setVariable ["owner",_object];
_trg setTriggerArea [200,200,0,false];
_trg setTriggerActivation["EAST","NOT PRESENT",true];
_trg setTriggerStatements ["this", "[(thisTrigger getVariable 'owner'),true] call he_fnc_objectiveClear", "[(thisTrigger getVariable 'owner'),false] call he_fnc_objectiveClear"];
*/
systemChat "done";