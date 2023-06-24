#include "script_component.hpp"
/*
* Author: DiGii
*
* Arguments:
* 0: player <Object>
*
* Return Value:
* NONE
*
* Example:
* [] call digii_main_fnc_init;
*
* Public: No
*/

params ["_unit", ["_isRespawn", true]];

if (!local _unit) exitWith {};
