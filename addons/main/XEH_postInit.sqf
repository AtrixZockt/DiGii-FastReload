#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineDIKCodes.inc"

//////////////////////////////////////////////////
// CBA key input handling
//////////////////////////////////////////////////

//Device Handler:
GVAR(deviceKeyHandlingArray) = [];
GVAR(deviceKeyCurrentIndex) = -1;

// Register localizations for the Keybinding categories
["DiGii Reload", "DIGII - FastReload"] call CBA_fnc_registerKeybindModPrettyName;

["DiGii Reload", QGVAR(unloadWeapon), "Fast Reload", {
    // Conditions:

    private _allowedWeapons = ['AssaultRifle', 'Handgun', 'Rifle', 'SubmachineGun', 'SniperRifle'];
    private _currentWeapon = currentWeapon player;
    private _currentWeaponType = _currentWeapon call BIS_fnc_itemType;
    if !(_currentWeapon != primaryWeapon _unit && {_currentWeapon != handgunWeapon _unit} && {_currentWeapon != secondaryWeapon _unit}) exitWith {false};

    if (!((_currentWeaponType select 1) in _allowedWeapons) && !(missionNamespace getVariable [QGVAR(allowAllWeapons), false])) exitWith {false};

    private _currentMuzzle = currentMuzzle player;
	private _currentAmmoCount = player ammo _currentMuzzle;
	if (_currentAmmoCount < 1) exitWith {false};

    // Statement:
    [player, _currentWeapon, _currentMuzzle, _currentAmmoCount] call FUNC(fastReload);
    true
}, {false}, [DIK_R, [true, false, false], true]] call CBA_fnc_addKeybind; //Shift + R Key