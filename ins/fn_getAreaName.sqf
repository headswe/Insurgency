private ["_obj","_locs","_text","_type","_word"];
_obj = _this select 0;

_locs = nearestlocations [position _obj,["nameVillage","nameCity","nameCityCapital","NameLocal"],10000];
_text = text (_locs select 0);


_type = switch (typeof _obj) do {
    case "LocationBase_F": {
    	_locs = nearestlocations [position _obj,["nameVillage","nameCity","nameCityCapital"],10000];
		_text = text (_locs select 0);
    	format ["%1 Base", _text]
    };
    case "LocationCamp_F": {
    	_word = (1 max floor random 10) call BIS_fnc_phoneticalWord;
    	format ["%1 Camp", _word]
    };
    case "LocationArea_F": {
    };
    case "LocationCityCapital_F": {
    	format ["%1 Occupation Zone", _text]
    };
    case "LocationEvacPoint_F": {
    };
    case "LocationFOB_F": {
    	_word = (1 max floor random 10) call BIS_fnc_phoneticalWord;
    	format ["%1 Foward Outpost", _text,_word]
    };
    case "LocationOutpost_F": {
    	format ["%1 Outpost",_text]
    };
    case "LocationResupplyPoint_F": {
        	format ["%1 Ammo Dump", _text]
    };
    case "LocationCity_F": {
        	format ["%1 Occupation Zone", _text]
    };
    case "LocationVillage_F": {
        	format ["%1 Occupation Zone", _text]
    };
    default {
    };
};
_type