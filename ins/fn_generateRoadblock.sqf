private ["_objs","_objA","_objB","_avgpos","_grps","_road","_connectedRoad","_guardGrp","_patrol","_spawnpos","_arr","_patrolGrp"];
_objs = _this select 0;



_objA = _objs call ws_fnc_selectRandom;
_objs = _objs - [_objA];
_objB = _objs call ws_fnc_selectRandom;
_avgpos = (getposATL _objA) vectorAdd (getPosATL _objB);
_avgpos = _avgpos vectorMultiply 0.5;
systemChat "roadblock";

_avgpos = [_avgpos] call ws_fnc_NearestRoadPos;

_grps = "true" configClasses (configfile >> "CfgGroups" >> "Ares" >> "Ares_MilitaryStructures" >> "Ares_MilitaryStructures_RoadCheckpoints");

_road = (_avgpos nearRoads 10) select 0;
if(isnil "_road") exitWith {};
_connectedRoad = (roadsConnectedTo _road) select 0;


[_avgpos, sideUnknown,_grps call ws_fnc_selectRandom,[_avgpos, getpos _connectedRoad] call BIS_fnc_dirTo] call he_fnc_spawnGroup;


_guardGrp = [_avgpos, he_side, he_infantryGroups call ws_fnc_selectRandom] call BIS_fnc_spawnGroup;

[_guardGrp,_avgpos,100] call BIS_fnc_taskDefend;


_guardGrp spawn ws_fnc_gCache;

[_avgpos,50,he_side,10,0.9,he_soldiers] spawn ws_fnc_createGarrison;

_patrol = 1 max floor(random 2);
_spawnpos = _avgpos;
for "_i" from 1 to _patrol do {
    _spawnpos = [_spawnpos,250, 25] call ws_fnc_getPos;
    _arr = ((_spawnpos) findEmptyPosition [0,50,"B_Boat_Armed_01_minigun_F"]);
    if(count _arr > 0) then {_spawnpos = _arr;systemChat "found empty pos";};
	_patrolGrp = [_spawnpos, he_side, (he_infantryGroups) call ws_fnc_selectRandom] call BIS_fnc_spawnGroup;
	[_patrolGrp, _avgpos, 100, 7, "MOVE", "SAFE", "YELLOW", "FULL", "STAG COLUMN", "", [3,6,9]] spawn CBA_fnc_taskPatrol;
	_patrolGrp spawn ws_fnc_gCache;
};
he_roadblocks pushBack _avgpos;