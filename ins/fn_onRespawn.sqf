private ["_loadout"];
_loadout = profileNamespace getVariable  ["he_playerloadout",[]];
if(count _loadout > 0) then
{
	[player,_loadout] call he_fnc_loadLoadout;
};
