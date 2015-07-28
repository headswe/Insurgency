private ["_side","_faction","_groups","_infantryGroups","_motorizedGroups","_mechanizedGroups","_airborneGroups","_all","_aliveCategory","_soldiers"];
_side =  (_this select 0);
_faction = _this select 1;






_groups = "true" configClasses (configFile >> "CfgGroups" >> format ["%1", _side] >> _faction);


_infantryGroups = [];
_motorizedGroups = [];
_mechanizedGroups = [];
_airborneGroups = [];
_all = [];
{
	_aliveCategory = getText(_x >> "aliveCategory");
	switch (_aliveCategory) do {
	    case "Infantry": {
	    	{
	    		_infantryGroups pushBack _x;
	    		_all pushBack _x;
	    	} forEach ("true" configClasses (_x));

	    };
	    case "Motorized": {
	    	{
	    		_motorizedGroups pushBack _x;
	    		_all pushBack _x;
	    	} forEach ("true" configClasses (_x));
	    };
	    case "Mechanized": {
	    	{
	    		_mechanizedGroups pushBack _x;
	    		_all pushBack _x;
	    	} forEach ("true" configClasses (_x));
	    };
	    case "Airborne": {
	    	{
	    		_airborneGroups pushBack _x;
	    		_all pushBack _x;
	    	} forEach ("true" configClasses (_x));
	    };
	};
} forEach _groups;


_soldiers = [];
{
	_soldiers pushBack getText(_x >> "vehicle");
} foreach ("true" configClasses (_infantryGroups select 1));
he_soldiers = _soldiers;
he_infantryGroups = _infantryGroups;
he_motorizedGroups = _motorizedGroups;
he_mechanizedGroups = _mechanizedGroups;
he_airborneGroups = _airborneGroups;
he_allGroups = _all;
[_soldiers,_infantryGroups,_motorizedGroups,_mechanizedGroups,_airborneGroups,_all]