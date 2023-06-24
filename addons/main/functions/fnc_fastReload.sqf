#include "script_component.hpp"
/*
 * Author: DiGii
 * Drop current weapon magazine on the ground and reload from inventory
 *
 * Arguments:
 * 0: Player <OBJECT>
 * 1: Weapon <STRING>
 * 2: Muzzle (optional, default: Weapon)<STRING>
 * 3: Ammo count (optional, default: ammo currentMuzzle Player) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
* [ACE_player, currentWeapon ACE_player, currentMuzzle ACE_player, 23] call digii_main_fnc_fastReload;
 *
 * Public: No
 */


params ["_unit", "_weapon", ["_muzzle", _weapon], ["_ammoCount", _unit ammo _muzzle ]];

private _delay = 2;
[_unit, "ReloadMagazine", 1] call ACEFUNC(common,doGesture);

[{
    params ["_unit", "_weapon", "_ammoCount", "_muzzle"];

    // remove weapon item
    private _magazineClass = currentMagazine _unit;

    switch true do {
        case (_weapon == primaryWeapon _unit): {
            _unit removePrimaryWeaponItem _magazineClass;
        };
        case (_weapon == handgunWeapon _unit): {
            _unit removeHandgunItem _magazineClass;
        };
        case (_weapon == secondaryWeapon _unit): {
            _unit removeSecondaryWeaponItem _magazineClass;
        };
    };

	private _weaponHolder = createVehicle ["Weapon_Empty", getPosATL _unit, [], 0, "CAN_COLLIDE"];
	_weaponHolder addMagazineAmmoCargo [_magazineClass, 1, _ammoCount];
	

	private _currentMagazines = magazinesAmmo _unit;
	private _compatibleMagazines = compatibleMagazines _weapon;

    // Load new magazine from inventory
	{
		if ((_x select 0) in _compatibleMagazines) exitWith
		{
			_unit addWeaponItem [_weapon, [_x select 0, _x select 1, _muzzle], true];
			_unit removeMagazineGlobal (_x select 0);
		}
	} forEach _currentMagazines

}, [_unit, _weapon, _ammoCount, _muzzle], _delay] call CBA_fnc_waitAndExecute;

