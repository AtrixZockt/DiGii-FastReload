#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#define CBA_SETTINGS_CHEM "DiGii - FastReload"

[
    QGVAR(allowAllWeapons),
    "CHECKBOX",
    ["Allow all Weapons","If enabled you can fast realod any weapon you can carry."],
    CBA_SETTINGS_CHEM,
    false,
    true,
    {
        missionNamespace setVariable [QGVAR(allowAllWeapons), _this, true];
    }
] call CBA_Settings_fnc_init;


ADDON = true;
