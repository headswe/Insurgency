private ["_unit","_mags","_items","_primWeapon","_primWeaAcc","_secWeapon","_secWeaAcc","_handgun","_handgunAcc","_assItems","_head","_vest","_uniform","_backpack","_data"];
_unit = _this select 0;
_mags = magazines _unit;
_items = items _unit;
{ _items = _items - [_x] } foreach magazines _unit;
_primWeapon = primaryWeapon _unit;
_primWeaAcc = primaryWeaponItems _unit;
_secWeapon = secondaryWeapon _unit;
_secWeaAcc = secondaryWeaponItems _unit;
_handgun = handgunWeapon _unit;
_handgunAcc = handgunItems _unit;
_assItems = assignedItems _unit;
_head = headgear _unit;
_vest = vest _unit;
_uniform = uniform _unit;
_backpack = backpack _unit;
_data = [_mags,_items,_primWeapon,_primWeaAcc,_secWeapon,_secWeaAcc,_handgun,_handgunAcc,_assItems,_head,_vest,_uniform,_backpack];
if(sfpDebugLoadout == 1) then
{
	diag_log format["%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13",_mags,_items,_primWeapon,_primWeaAcc,_secWeapon,_secWeaAcc,_handgun,_handgunAcc,_assItems,_head,_vest,_uniform,_backpack];
	hint format["%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13",_mags,_items,_primWeapon,_primWeaAcc,_secWeapon,_secWeaAcc,_handgun,_handgunAcc,_assItems,_head,_vest,_uniform,_backpack];
	player sidechat format["%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13",_mags,_items,_primWeapon,_primWeaAcc,_secWeapon,_secWeaAcc,_handgun,_handgunAcc,_assItems,_head,_vest,_uniform,_backpack];
};
profileNamespace setVariable ["he_playerloadout",_data];
_data

