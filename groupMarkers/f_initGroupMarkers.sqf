private ["_unitfaction","_style"];

// ====================================================================================

// MAKE SURE THE PLAYER INITIALIZES PROPERLY

if (!isDedicated && (isNull player)) then
{
    waitUntil {sleep 0.1; !isNull player};
};

// ====================================================================================
// init
if(isNil "f_grpMkr_groups") then
{
    f_grpMkr_groups = [];
    f_grpMkr_data = [];
    f_grpMkr_id = 0;
    f_grpMkr_delay = 3;
};

// ====================================================================================
// Actively monitor reported displays, such that all BIS displays function properly.

[] spawn {
    f_groupMarkersActiveMapControls = [];
    while {true} do
    {
        disableSerialization;
        {
            _display = _x;
            {
                if (ctrlMapScale _x != 0) then {
                    if !(_x in f_groupMarkersActiveMapControls ) then {
                        f_groupMarkersActiveMapControls pushBack _x;
                        _x ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
                    };
                };
            } forEach allControls _display;
        } forEach allDisplays;

        {
            _display = _x;
            {
                if (ctrlMapScale _x != 0) then {
                    if !(_x in f_groupMarkersActiveMapControls ) then {
                        f_groupMarkersActiveMapControls pushBack _x;
                        _x ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
                    };
                };
            } forEach allControls _display;
        } forEach (uiNameSpace getVariable "igui_displays");
        sleep 1;
        //Garbage collect old controls.
        f_groupMarkersActiveMapControls = f_groupMarkersActiveMapControls - [controlNull];
    };
};

// Displays that are not created using createDialog, are not easily trackable such as tao's folding map.
// Below is code to support Tao's folding map.

[] spawn {
	while {true} do
	{
		disableSerialization;
		waitUntil {sleep 1;!isNull (uiNamespace getVariable "tao_foldmap")};
		_control1 = ((uiNamespace getVariable "tao_foldmap") displayctrl 40);
		((uiNamespace getVariable "tao_foldmap") displayctrl 40) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
		((uiNamespace getVariable "tao_foldmap") displayctrl 41) ctrlAddEventHandler ["draw",{_this call F_fnc_drawGroupMarkers}];
		waitUntil{sleep 1;isNull _control1};
	};
};
