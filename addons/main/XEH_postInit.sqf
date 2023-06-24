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
    if !([ACE_player, objNull, ["isNotInside"]] call ACEFUNC(common,canInteractWith)) exitWith {false};

    private _currentWeapon = currentWeapon ACE_player;
    if !(_currentWeapon != primaryWeapon _unit && {_currentWeapon != handgunWeapon _unit} && {_currentWeapon != secondaryWeapon _unit}) exitWith {false};

    private _currentMuzzle = currentMuzzle ACE_player;
	private _currentAmmoCount = ACE_player ammo _currentMuzzle;
	if (_currentAmmoCount < 1) exitWith {false};

    // Statement:
    [ACE_player, _currentWeapon, _currentMuzzle, _currentAmmoCount] call FUNC(fastReload);
    true
}, {false}, [DIK_R, [true, false, false], true]] call CBA_fnc_addKeybind; //Shift + R Key