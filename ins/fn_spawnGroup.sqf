private ["_pos","_side","_chars","_charsType","_types","_azimuth","_azimuthREL","_dirs","_positions","_ranks","_item","_multiplyMatrixFunc","_array1","_array2","_result","_grp","_vehicles","_isMan","_type","_posX","_posY","_unit","_itemPos","_relPos","_rotMatrix","_newRelPos","_newPos","_z","_input"];
/*
	File: spawnGroup.sqf
	Author: Joris-Jan van 't Land, modified by Thomas Ryan

	Description:
	Function which handles the spawning of a dynamic group of characters.
	The composition of the group can be passed to the function.
	Alternatively a number can be passed and the function will spawn that
	amount of characters with a random type.

	Parameter(s):
	_this select 0: the group's starting position (Array)
	_this select 1: the group's side (Side)
	_this select 2: can be three different types:
		- list of character types (Array)
		- amount of characters (Number)
		- CfgGroups entry (Config)
	_this select 3: (optional) list of relative positions (Array)
	_this select 4: (optional) list of ranks (Array)
	_this select 5: (optional) skill range (Array)
	_this select 6: (optional) ammunition count range (Array)
	_this select 7: (optional) randomization controls (Array)
		0: amount of mandatory units (Number)
		1: spawn chance for the remaining units (Number)
	_this select 8: (optional) azimuth (Number)
	_this select 9: (optional) force precise position (Bool, default: true).
	_this select 10: (optional) max. number of vehicles (Number, default: 10e10).

	Returns:
	The group (Group)
*/

//Validate parameter count
if ((count _this) < 3) exitWith {debugLog "Log: [spawnGroup] Function requires at leat 3 parameters!"; grpNull};

private ["_pos", "_side"];
_pos = [_this, 0, [], [[]]] call BIS_fnc_param;
_side = [_this, 1, sideUnknown, [sideUnknown]] call BIS_fnc_param;

private ["_chars", "_charsType", "_types"];
_chars = [_this, 2, [], [[], 0, configFile]] call BIS_fnc_param;
_charsType = typeName _chars;
if (_charsType == (typeName [])) then
{
	_types = _chars;
}
else
{
	if (_charsType == (typeName 0)) then
	{
		//Only a count was given, so ask this function for a good composition.
		_types = [_side, _chars] call BIS_fnc_returnGroupComposition;
	}
	else
	{
		if (_charsType == (typeName configFile)) then
		{
			_types = [];
		};
	};
};




private ["_azimuth"];
_azimuthREL = [_this, 3, 0, [0]] call BIS_fnc_param;
_azimuth = 0;
//Check parameter validity.
//TODO: Check for valid skill and ammo ranges?
if ((typeName _pos) != (typeName [])) exitWith {debugLog "Log: [spawnGroup] Position (0) should be an Array!"; grpNull};
if ((count _pos) < 2) exitWith {debugLog "Log: [spawnGroup] Position (0) should contain at least 2 elements!"; grpNull};
if ((typeName _side) != (typeName sideEnemy)) exitWith {debugLog "Log: [spawnGroup] Side (1) should be of type Side!"; grpNull};
if ((typeName _azimuth) != (typeName 0)) exitWith {debugLog "Log: [spawnGroup] Azimuth (8) should be a Number!"; grpNull};

_dirs = [];
_positions = [];
//Convert a CfgGroups entry to types, positions and ranks.
if (_charsType == (typeName configFile)) then
{
	_ranks = [];
	_positions = [];

	for "_i" from 0 to ((count _chars) - 1) do
	{
		private ["_item"];
		_item = _chars select _i;

		if (isClass _item) then
		{
			_types = _types + [getText(_item >> "vehicle")];
			_dirs = _dirs + [getNumber(_item >> "dir")];
			_positions = _positions + [getArray(_item >> "position")];
		};
	};
};
_multiplyMatrixFunc =
{
	private ["_array1", "_array2", "_result"];
	_array1 = _this select 0;
	_array2 = _this select 1;

	_result =
	[
		(((_array1 select 0) select 0) * (_array2 select 0)) + (((_array1 select 0) select 1) * (_array2 select 1)),
		(((_array1 select 1) select 0) * (_array2 select 0)) + (((_array1 select 1) select 1) * (_array2 select 1))
	];

	_result
};


private ["_grp","_vehicles","_isMan","_type"];
_vehicles = [];		//spawned vehicles count
_posX = _pos select 0;
_posY = _pos select 1;
//Create the units according to the selected types.
for "_i" from 0 to ((count _types) - 1) do
{
	_type = _types select _i;
	private ["_unit"];

	//If given, use relative position.
	private ["_itemPos","_relPos"];

	_relPos = _positions select _i;
	_azimuth = _dirs select _i;

	//Rotate the relative position using a rotation matrix
	private ["_rotMatrix", "_newRelPos", "_newPos"];
	_rotMatrix =
	[
		[cos _azimuthREL, sin _azimuthREL],
		[-(sin _azimuthREL), cos _azimuthREL]
	];
	_newRelPos = [_rotMatrix, _relPos] call _multiplyMatrixFunc;


	//Backwards compatability causes for height to be optional
	private ["_z"];
	if ((count _relPos) > 2) then {_z = _relPos select 2} else {_z = 0};
	//systemChat format ["%1", _azimuth];
	_newPos = [_posX + (_newRelPos select 0), _posY + (_newRelPos select 1), 0];
	_unit = _type createVehicle _newPos;
	_unit setpos _newPos;
	_unit setDir (_azimuthREL + _azimuth);
	_unit setpos _newPos;
	_vehicles pushBack _unit;
};
_input = [];

_vehicles