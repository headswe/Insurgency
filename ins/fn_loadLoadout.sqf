private ["_unit","_data","_mags","_items","_primWeapon","_primWeaAcc","_secWeapon","_secWeaAcc","_handgun","_handgunAcc","_assItems","_head","_vest","_uniform","_backpack"];
_unit = _this select 0;
_data = _this select 1;
_mags = _data select 0;
_items = _data select 1;
_primWeapon = _data select 2;
_primWeaAcc = _data select 3;
_secWeapon = _data select 4;
_secWeaAcc = _data select 5;
_handgun = _data select 6;
_handgunAcc = _data select 7;
_assItems = _data select 8;
_head = _data select 9;
_vest = _data select 10;
_uniform = _data select 11;
_backpack =_data select 12;
removeAllItems _unit;
{player removeMagazine _x} forEach magazines _unit;
removeAllAssignedItems _unit;
removeBackpack _unit;
if(sfpDebugLoadout == 1) then
{
	diag_log format["KUK:%1,%2,%3,%4,%5,%6,%7,%8,%9,%10,%11,%12,%13",_mags,_items,_primWeapon,_primWeaAcc,_secWeapon,_secWeaAcc,_handgun,_handgunAcc,_assItems,_head,_vest,_uniform,_backpack];
};
if(_head != "") then {_unit addHeadgear _head;} else {_x = headgear _unit;_unit unassignitem _x;_unit removeItem _x;};
if(_uniform != "") then {_unit addUniform _uniform;} else {_x = uniform _unit;_unit unassignitem _x;_unit removeItem _x;};
if(_vest != "") then {_unit addvest _vest;} else {_x = vest _unit;_unit unassignitem _x;_unit removeItem _x;};
if(_backpack != "") then {_unit addBackpack _backpack;} else {_x = backpack _unit;_unit unassignitem _x;_unit removeItem _x;};
{
	_unit addmagazine _x;
} foreach _mags;
{
	_unit additem _x;
} foreach _items;
// ####### Primary Weapon
if(_primWeapon != "") then
{
	_unit addWeapon _primWeapon;
	{
		_unit removePrimaryWeaponItem  _x;
	} foreach primaryWeaponItems  _unit;
	{
		if(_x != "") then
		{
		_unit addPrimaryWeaponItem _x;
		};
	} foreach _primWeaAcc;
}
else
{
	_unit removeWeapon primaryWeapon _unit;
};
// ####### secondaryWeapon
if(_secWeapon != "") then
{
	_unit addWeapon _secWeapon;
	{
		if(_x != "") then
		{
		_unit addSecondaryWeaponItem _x;
		};
	} foreach _secWeaAcc;
}
else
{
	_unit removeWeapon secondaryWeapon _unit;
};
// #### handgun
if(_handgun != "") then
{
	_unit addWeapon _handgun;
	{
		if(_x != "") then
		{
		_unit addHandgunItem  _x;
		};
	} foreach _handgunAcc;
}
else
{
	_unit removeweapon handgunWeapon _unit;
};
/// #### assigneditems
{
	if("binocular" in ([(configfile >> "CfgWeapons" >> _x),true] call BIS_fnc_returnParents)) then
	{
		_unit additem _x;
	}
	else
	{
		_unit addweapon _x;
	};
	_unit assignItem _x;
} foreach _assItems;
