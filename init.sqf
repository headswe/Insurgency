enableSaving [false,false];

sfpDebugLoadout = 0; // TODO : rename

execVM "groupMarkers\f_initGroupMarkers.sqf";
ammobox addAction ["Save Loadout",{[player] call he_fnc_saveloadout;["LoadoutSaved"] call bis_fnc_showNotification}];

he_errors = [];

if(isServer) then {
	systemChat "Running server";
	[viewDistance+200,1,6] call ws_fnc_cInit;
	[] spawn he_fnc_start;
};

[west, (getmarkerpos "Base")] call BIS_fnc_addRespawnPosition;
[west, respawnTruck] call BIS_fnc_addRespawnPosition;


_loadout = profileNamespace getVariable  ["he_playerloadout",[]];
if(count _loadout > 0) then
{
	[player,_loadout] call he_fnc_loadLoadout;
};