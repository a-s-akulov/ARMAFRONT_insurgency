[] execVM "scripts\veh_rules\check_vehicle.sqf"; // Информационная табличка

// Правила для пилота при посадке в технику

if (pRole isEqualTo 9) then 
{
    private _id = [];

    // Садится в технику 

    _id pushBack (player addEventHandler ["GetInMan","
        private _vehicle = _this select 0;
        if ((vehicle _vehicle isKindOf 'Air') && ((player == driver vehicle _vehicle) || (player == vehicle _vehicle turretUnit [0]) || (player == commander vehicle _vehicle))) then
        {
            [] execVM 'scripts\veh_rules\veh_rules.sqf';
        };
    "]);

    // Пересаживается на другое место в технике

    _id pushBack (player addEventHandler ["SeatSwitchedMan","
        private _vehicle = _this select 2;
        if ((vehicle _vehicle isKindOf 'Air') && ((player == driver vehicle _vehicle) || (player == vehicle _vehicle turretUnit [0]) || (player == commander vehicle _vehicle))) then
        {
            [] execVM 'scripts\veh_rules\veh_rules.sqf';
        };
    "]);
    player setVariable ["VR_id",_id];
};

// Правила для танкиста при посадке в технику

if (pRole isEqualTo 8) then
{
    private _id = [];

    // Садится в технику

    _id pushBack (player addEventHandler ["GetInMan","
        private _vehicle = _this select 0;
        if ((vehicle _vehicle isKindOf ""Tank"" || vehicle _vehicle isKindOf ""Wheeled_APC_F"") && ((player == driver vehicle _vehicle) || (player == vehicle _vehicle turretUnit [0]) || (player == commander vehicle _vehicle))) then
        {
            [] execVM 'scripts\veh_rules\veh_rules.sqf';
        };
    "]);

    // Пересаживается на другое место в технике

    _id pushBack (player addEventHandler ["SeatSwitchedMan","
        private _vehicle = _this select 2;
        if ((vehicle _vehicle isKindOf ""Tank"" || vehicle _vehicle isKindOf ""Wheeled_APC_F"") && ((player == driver vehicle _vehicle) || (player == vehicle _vehicle turretUnit [0]) || (player == commander vehicle _vehicle))) then
        {
            [] execVM 'scripts\veh_rules\veh_rules.sqf';
        };
    "]);
    player setVariable ["VR_id",_id];
};