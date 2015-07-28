_ourSide = opfor;
_faction = "rhs_faction_vdv";







_objectives = (units MasterMilitary) - [MasterMilitary];
_bases = [];
{if(typeOf _x == "LocationBase_F")then{_bases pushBack _x}} foreach _objectives;
_ourBase = [_bases] call ws_fnc_selectRandom;
_addionalObjectives = [(_objectives - [_ourBase]),[_ourBase],{_input0 distance _x}] call bis_fnc_sortBy;

[_ourBase,250,_ourSide,20 max floor(random 40),0.6,] call ws_fnc_createGarrison
OurBase = _ourBase;
AddObjectives = _addionalObjectives;