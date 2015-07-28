private ["_unit"];
_unit = _this select 0;
{
	(_this select 0) setSkill [_x,0.3];
} forEach ['aimingAccuracy','aimingShake','aimingSpeed','endurance','spotDistance','spotTime','courage','reloadSpeed','commanding','general'];