/*
    GTA SA:MP RL Account System
    MySQL R41-4 mit bcrypt Verschlüsselung
*/
#include <a_samp>
#include <a_mysql>
#include <bcrypt>

// MySQL Verbindung
new MySQL:dbHandle;

// Dialog IDs
#define DIALOG_NOREGISTER       1000
#define DIALOG_OTP_INPUT        1001
#define DIALOG_NEW_PASSWORD     1002
#define DIALOG_CONFIRM_PASSWORD 1003
#define DIALOG_LOGIN            1004

// Maximale Versuche
#define MAX_LOGIN_ATTEMPTS      3
#define MAX_OTP_ATTEMPTS        3

// Delay für Account-Prüfung (in Millisekunden)
#define ACCOUNT_CHECK_DELAY     10000


#define MAX_HOUSES 500


// Spieler Enum
enum E_PLAYER_DATA
{
    pID,                    // Datenbank ID
    pName[MAX_PLAYER_NAME], // Spielername
    pPassword[65],          // Gehashtes Passwort (bcrypt)
    pOTP[16],               // One Time Password
    pFirstLogin,            // 0 = bereits eingeloggt, 1 = Erstlogin
    pLevel,                 // Level
    pMoney,                 // Geld
    pAdmin,                 // Admin Level
    pLoginAttempts,         // Login Versuche
    pOTPAttempts,           // OTP Versuche
    pLoggedIn,              // Eingeloggt Status
    Float:pPosX,            // Position X
    Float:pPosY,            // Position Y
    Float:pPosZ,            // Position Z
    Float:pPosA,            // Rotation
    pInterior,              // Interior
    pVirtualWorld,          // Virtual World
    pSkin,                  // Skin ID
    Float:pHealth,          // Gesundheit
    Float:pArmour,          // Rüstung
    pBankMoney,             // Bank Geld
    pPlayedHours,           // Gespielte Stunden
    pRegisterDate[32],      // Registrierungsdatum
    pLastLogin[32]          // Letzter Login
}

enum E_HOUSE_DATA
{
    hID,                        // Datenbank ID
    hExists,                    // Existiert das Haus? (0/1)
    hOwned,                     // Ist das Haus gekauft? (0/1)
    hOwnerName[MAX_PLAYER_NAME], // Besitzer Name
    hOwnerID,                   // Besitzer Account ID
    Float:hEnterX,              // Eingang Position X
    Float:hEnterY,              // Eingang Position Y
    Float:hEnterZ,              // Eingang Position Z
    Float:hExitX,               // Ausgang Position X (Interior)
    Float:hExitY,               // Ausgang Position Y (Interior)
    Float:hExitZ,               // Ausgang Position Z (Interior)
    hInterior,                  // Interior ID
    hVirtualWorld,              // Virtual World (meist House ID)
    hPrice,                     // Kaufpreis
    hRentPrice,                 // Mietpreis
    hLevel,                     // Benötigtes Level zum Kauf
    hLocked,                    // Verschlossen? (0/1)
    hRentable,                  // Vermietbar? (0/1)
    hType,                      // Haustyp (0=Klein, 1=Mittel, 2=Groß, 3=Villa, 4=Apartment)
    hWeapons[10],               // Gespeicherte Waffen
    hWeaponAmmo[10],            // Munition der Waffen
    hMoney,                     // Geld im Haus-Safe
    hDrugs,                     // Drogen im Haus
    hMaterials,                 // Materialien im Haus
    hAlarm,                     // Alarm System (0/1)
    hAlarmActive,               // Alarm aktiviert? (0/1)
    Text3D:hLabel,              // 3D Text Label
    hPickup,                    // Pickup ID
    hMapIcon,                   // Map Icon ID
    hRentedBy[MAX_PLAYER_NAME], // Gemietet von (Name)
    hRentedByID,                // Gemietet von (Account ID)
    hCreatedDate[32],           // Erstellungsdatum
    hLastEntered[32]            // Zuletzt betreten
}
new HouseData[MAX_HOUSES][E_HOUSE_DATA];
new PlayerData[MAX_PLAYERS][E_PLAYER_DATA];

// Temporäre Variable für neues Passwort
new TempPassword[MAX_PLAYERS][65];

/*
    MySQL Verbindung herstellen
*/
stock MySQL_Connect()
{
    // Konfiguration - Bitte anpassen!
    new const DB_HOST[] = "localhost";
    new const DB_USER[] = "root";
    new const DB_PASS[] = "password";
    new const DB_NAME[] = "samp_database";
    
    mysql_log(ALL);
    
    dbHandle = mysql_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    
    if(dbHandle == MYSQL_INVALID_HANDLE || mysql_errno(dbHandle) != 0)
    {
        print("[MySQL] Fehler: Verbindung zur Datenbank konnte nicht hergestellt werden!");
        SendRconCommand("exit");
        return 0;
    }
    
    print("[MySQL] Verbindung zur Datenbank erfolgreich hergestellt!");
    MySQL_CreateTables();
    return 1;
}

/*
    Tabellen erstellen
*/
stock MySQL_CreateTables()
{
    mysql_tquery(dbHandle, "CREATE TABLE IF NOT EXISTS `accounts` (\
            `id` INT(11) NOT NULL AUTO_INCREMENT,\
            `username` VARCHAR(24) NOT NULL,\
            `password` VARCHAR(65) NOT NULL DEFAULT '',\
            `otp` VARCHAR(16) NOT NULL DEFAULT '',\
            `first_login` TINYINT(1) NOT NULL DEFAULT 1,\
            `level` INT(11) NOT NULL DEFAULT 1,\
            `money` INT(11) NOT NULL DEFAULT 0,\
            `bank_money` INT(11) NOT NULL DEFAULT 0,\
            `admin` INT(11) NOT NULL DEFAULT 0,\
            `pos_x` FLOAT NOT NULL DEFAULT 0.0,\
            `pos_y` FLOAT NOT NULL DEFAULT 0.0,\
            `pos_z` FLOAT NOT NULL DEFAULT 0.0,\
            `pos_a` FLOAT NOT NULL DEFAULT 0.0,\
            `interior` INT(11) NOT NULL DEFAULT 0,\
            `virtual_world` INT(11) NOT NULL DEFAULT 0,\
            `skin` INT(11) NOT NULL DEFAULT 0,\
            `health` FLOAT NOT NULL DEFAULT 100.0,\
            `armour` FLOAT NOT NULL DEFAULT 0.0,\
            `played_hours` INT(11) NOT NULL DEFAULT 0,\
            `register_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,\
            `last_login` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,\
            PRIMARY KEY (`id`),\
            UNIQUE KEY `username` (`username`)\
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;"
    );
    
mysql_tquery(dbHandle, "CREATE TABLE IF NOT EXISTS `houses` (\
            `id` INT(11) NOT NULL AUTO_INCREMENT,\
            `exists` TINYINT(1) NOT NULL DEFAULT 1,\
            `owned` TINYINT(1) NOT NULL DEFAULT 0,\
            `owner_name` VARCHAR(24) NOT NULL DEFAULT 'Niemand',\
            `owner_id` INT(11) NOT NULL DEFAULT 0,\
            `enter_x` FLOAT NOT NULL DEFAULT 0.0,\
            `enter_y` FLOAT NOT NULL DEFAULT 0.0,\
            `enter_z` FLOAT NOT NULL DEFAULT 0.0,\
            `exit_x` FLOAT NOT NULL DEFAULT 0.0,\
            `exit_y` FLOAT NOT NULL DEFAULT 0.0,\
            `exit_z` FLOAT NOT NULL DEFAULT 0.0,\
            `interior` INT(11) NOT NULL DEFAULT 0,\
            `virtual_world` INT(11) NOT NULL DEFAULT 0,\
            `price` INT(11) NOT NULL DEFAULT 50000,\
            `rent_price` INT(11) NOT NULL DEFAULT 500,\
            `level` INT(11) NOT NULL DEFAULT 1,\
            `locked` TINYINT(1) NOT NULL DEFAULT 0,\
            `rentable` TINYINT(1) NOT NULL DEFAULT 0,\
            `type` TINYINT(1) NOT NULL DEFAULT 0,\
            `weapon_1` INT(11) NOT NULL DEFAULT 0,\
            `weapon_2` INT(11) NOT NULL DEFAULT 0,\
            `weapon_3` INT(11) NOT NULL DEFAULT 0,\
            `weapon_4` INT(11) NOT NULL DEFAULT 0,\
            `weapon_5` INT(11) NOT NULL DEFAULT 0,\
            `weapon_6` INT(11) NOT NULL DEFAULT 0,\
            `weapon_7` INT(11) NOT NULL DEFAULT 0,\
            `weapon_8` INT(11) NOT NULL DEFAULT 0,\
            `weapon_9` INT(11) NOT NULL DEFAULT 0,\
            `weapon_10` INT(11) NOT NULL DEFAULT 0,\
            `ammo_1` INT(11) NOT NULL DEFAULT 0,\
            `ammo_2` INT(11) NOT NULL DEFAULT 0,\
            `ammo_3` INT(11) NOT NULL DEFAULT 0,\
            `ammo_4` INT(11) NOT NULL DEFAULT 0,\
            `ammo_5` INT(11) NOT NULL DEFAULT 0,\
            `ammo_6` INT(11) NOT NULL DEFAULT 0,\
            `ammo_7` INT(11) NOT NULL DEFAULT 0,\
            `ammo_8` INT(11) NOT NULL DEFAULT 0,\
            `ammo_9` INT(11) NOT NULL DEFAULT 0,\
            `ammo_10` INT(11) NOT NULL DEFAULT 0,\
            `money` INT(11) NOT NULL DEFAULT 0,\
            `drugs` INT(11) NOT NULL DEFAULT 0,\
            `materials` INT(11) NOT NULL DEFAULT 0,\
            `alarm` TINYINT(1) NOT NULL DEFAULT 0,\
            `alarm_active` TINYINT(1) NOT NULL DEFAULT 0,\
            `rented_by` VARCHAR(24) NOT NULL DEFAULT 'Niemand',\
            `rented_by_id` INT(11) NOT NULL DEFAULT 0,\
            `created_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,\
            `last_entered` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,\
            PRIMARY KEY (`id`),\
            KEY `owner_id` (`owner_id`),\
            KEY `owned` (`owned`)\
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;"
    );


    print("[MySQL] Tabellen wurden ueberprueft/erstellt.");
}

/*
    Account Check Timer Callback
*/
forward CheckAccountTimer(playerid);
public CheckAccountTimer(playerid)
{
    if(!IsPlayerConnected(playerid))
        return 0;
    
    GameTextForPlayer(playerid, "~w~Account wird geprueft...", 3000, 3);
    
    new query[256], name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    mysql_format(dbHandle, query, sizeof(query), "SELECT `id`, `password`, `otp`, `first_login` FROM `accounts` WHERE `username` = '%e' LIMIT 1", name);
    mysql_tquery(dbHandle, query, "OnAccountCheck", "i", playerid);
    return 1;
}

/*
    Account Check Callback
*/
forward OnAccountCheck(playerid);
public OnAccountCheck(playerid)
{
    if(!IsPlayerConnected(playerid))
        return 0;
    
    new rows;
    cache_get_row_count(rows);
    
    if(rows == 0)
    {
        // Kein Account gefunden
        new string[256];
        format(string, sizeof(string), "{FFFFFF}Willkommen auf {FF6347}unserem Server{FFFFFF}!\n\n\{FF6347}Dein Account wurde nicht gefunden!{FFFFFF}\n\n\Bitte registriere dich zuerst im Forum:\n\{FFD700}www.dein-server.de/forum{FFFFFF}\n\nNach der Registrierung erhaeltst du dein OTP per E-Mail.");
        
        ShowPlayerDialog(playerid, DIALOG_NOREGISTER, DIALOG_STYLE_MSGBOX, "{FF6347}Account nicht gefunden", string, "OK", "");
        SetTimerEx("KickPlayer", 500, false, "i", playerid);
        return 0;
    }
    
    // Account gefunden - Daten laden
    cache_get_value_name_int(0, "id", PlayerData[playerid][pID]);
    cache_get_value_name(0, "password", PlayerData[playerid][pPassword], 65);
    cache_get_value_name(0, "otp", PlayerData[playerid][pOTP],16);
    cache_get_value_name_int(0, "first_login", PlayerData[playerid][pFirstLogin]);
    
    // Sicherheit: Prüfen ob OTP vorhanden ist bei Erstlogin
    if(PlayerData[playerid][pFirstLogin] == 1)
    {
        if(strlen(PlayerData[playerid][pOTP]) < 4)
        {
            SendClientMessage(playerid, 0xFF6347FF, "[FEHLER] Dein OTP ist nicht gesetzt. Kontaktiere einen Administrator!");
            SetTimerEx("KickPlayer", 500, false, "i", playerid);
            return 0;
        }
        
        // Erstlogin - OTP Dialog zeigen
        ShowPlayerDialog(playerid, DIALOG_OTP_INPUT, DIALOG_STYLE_PASSWORD,
            "{FFD700}Erstlogin - OTP Eingabe",
            "{FFFFFF}Willkommen auf dem Server!\n\n\
            Dies ist dein {FF6347}erster Login{FFFFFF}.\n\
            Bitte gib das {FFD700}One-Time-Password (OTP){FFFFFF} ein,\n\
            das du per E-Mail erhalten hast.\n\n\
            {FF6347}Achtung:{FFFFFF} Nach 3 falschen Versuchen wirst du gekickt!",
            "Weiter", "Abbrechen"
        );
    }
    else
    {
        // Normaler Login
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,
            "{FFD700}Login",
            "{FFFFFF}Willkommen zurueck!\n\n\
            Bitte gib dein {FFD700}Passwort{FFFFFF} ein:\n\n\
            {FF6347}Achtung:{FFFFFF} Nach 3 falschen Versuchen wirst du gekickt!",
            "Login", "Abbrechen"
        );
    }
    
    return 1;
}

/*
    Passwort Validierung
*/
stock IsValidPassword(const password[])
{
    new len = strlen(password);
    
    // Mindestens 8 Zeichen
    if(len < 8)
        return 0;
    
    new hasUpper = 0, hasNumber = 0, hasSpecial = 0;
    
    for(new i = 0; i < len; i++)
    {
        if(password[i] >= 'A' && password[i] <= 'Z')
            hasUpper = 1;
        else if(password[i] >= '0' && password[i] <= '9')
            hasNumber = 1;
        else if(password[i] == '!' || password[i] == '@' || password[i] == '#' || 
                password[i] == '$' || password[i] == '%' || password[i] == '&' || 
                password[i] == '*' || password[i] == '?' || password[i] == '_' ||
                password[i] == '-' || password[i] == '+' || password[i] == '=')
            hasSpecial = 1;
    }
    
    return (hasUpper && hasNumber && hasSpecial);
}

/*
    Spieler kicken (mit Delay)
*/
forward KickPlayer(playerid);
public KickPlayer(playerid)
{
    Kick(playerid);
}

/*
    Spielerdaten laden
*/
stock LoadPlayerData(playerid)
{
    new query[256];
    mysql_format(dbHandle, query, sizeof(query),
        "SELECT * FROM `accounts` WHERE `username` = '%e' LIMIT 1",
        PlayerData[playerid][pName]
    );
    mysql_tquery(dbHandle, query, "OnPlayerDataLoaded", "i", playerid);
}

forward OnPlayerDataLoaded(playerid);
public OnPlayerDataLoaded(playerid)
{
    if(!IsPlayerConnected(playerid))
        return 0;
    
    new rows;
    cache_get_row_count(rows);
    
    if(rows == 0)
        return 0;
    
    cache_get_value_name_int(0, "id", PlayerData[playerid][pID]);
    cache_get_value_name(0, "password", PlayerData[playerid][pPassword],65);
    cache_get_value_name_int(0, "level", PlayerData[playerid][pLevel]);
    cache_get_value_name_int(0, "money", PlayerData[playerid][pMoney]);
    cache_get_value_name_int(0, "bank_money", PlayerData[playerid][pBankMoney]);
    cache_get_value_name_int(0, "admin", PlayerData[playerid][pAdmin]);
    cache_get_value_name_float(0, "pos_x", PlayerData[playerid][pPosX]);
    cache_get_value_name_float(0, "pos_y", PlayerData[playerid][pPosY]);
    cache_get_value_name_float(0, "pos_z", PlayerData[playerid][pPosZ]);
    cache_get_value_name_float(0, "pos_a", PlayerData[playerid][pPosA]);
    cache_get_value_name_int(0, "interior", PlayerData[playerid][pInterior]);
    cache_get_value_name_int(0, "virtual_world", PlayerData[playerid][pVirtualWorld]);
    cache_get_value_name_int(0, "skin", PlayerData[playerid][pSkin]);
    cache_get_value_name_float (0, "health", PlayerData[playerid][pHealth]);
    cache_get_value_name_float (0, "armour", PlayerData[playerid][pArmour]);
    cache_get_value_name_int(0, "played_hours", PlayerData[playerid][pPlayedHours]);
    cache_get_value_name(0, "register_date", PlayerData[playerid][pRegisterDate],  32);
    cache_get_value_name(0, "last_login", PlayerData[playerid][pLastLogin], 32);
    
    PlayerData[playerid][pLoggedIn] = 1;
    
    // Spieler spawnen
    SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], 
        PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ], 
        PlayerData[playerid][pPosA], 0, 0, 0, 0, 0, 0
    );
    SpawnPlayer(playerid);
    
    SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
    SetPlayerVirtualWorld(playerid, PlayerData[playerid][pVirtualWorld]);
    SetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
    SetPlayerArmour(playerid, PlayerData[playerid][pArmour]);
    GivePlayerMoney(playerid, PlayerData[playerid][pMoney]);
    
    TogglePlayerSpectating(playerid, 0);
    
    SendClientMessage(playerid, 0x00FF00FF, "[SUCCESS] Du wurdest erfolgreich eingeloggt!");
    
    return 1;
}

/*
    Spielerdaten speichern
*/
stock SavePlayerData(playerid)
{
    if(!PlayerData[playerid][pLoggedIn])
        return 0;
    
    GetPlayerPos(playerid, PlayerData[playerid][pPosX], PlayerData[playerid][pPosY], PlayerData[playerid][pPosZ]);
    GetPlayerFacingAngle(playerid, PlayerData[playerid][pPosA]);
    GetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
    GetPlayerArmour(playerid, PlayerData[playerid][pArmour]);
    PlayerData[playerid][pInterior] = GetPlayerInterior(playerid);
    PlayerData[playerid][pVirtualWorld] = GetPlayerVirtualWorld(playerid);
    PlayerData[playerid][pSkin] = GetPlayerSkin(playerid);
    PlayerData[playerid][pMoney] = GetPlayerMoney(playerid);
    
    new query[1024];
    mysql_format(dbHandle, query, sizeof(query),
        "UPDATE `accounts` SET \
        `password` = '%e', \
        `level` = %d, \
        `money` = %d, \
        `bank_money` = %d, \
        `admin` = %d, \
        `pos_x` = %f, \
        `pos_y` = %f, \
        `pos_z` = %f, \
        `pos_a` = %f, \
        `interior` = %d, \
        `virtual_world` = %d, \
        `skin` = %d, \
        `health` = %f, \
        `armour` = %f, \
        `played_hours` = %d \
        WHERE `id` = %d",
        PlayerData[playerid][pPassword],
        PlayerData[playerid][pLevel],
        PlayerData[playerid][pMoney],
        PlayerData[playerid][pBankMoney],
        PlayerData[playerid][pAdmin],
        PlayerData[playerid][pPosX],
        PlayerData[playerid][pPosY],
        PlayerData[playerid][pPosZ],
        PlayerData[playerid][pPosA],
        PlayerData[playerid][pInterior],
        PlayerData[playerid][pVirtualWorld],
        PlayerData[playerid][pSkin],
        PlayerData[playerid][pHealth],
        PlayerData[playerid][pArmour],
        PlayerData[playerid][pPlayedHours],
        PlayerData[playerid][pID]
    );
    
    mysql_tquery(dbHandle, query);
    return 1;
}

/*
    Spielerdaten zurücksetzen
*/
stock ResetPlayerData(playerid)
{
    PlayerData[playerid][pID] = 0;
    PlayerData[playerid][pName][0] = EOS;
    PlayerData[playerid][pPassword][0] = EOS;
    PlayerData[playerid][pOTP][0] = EOS;
    PlayerData[playerid][pFirstLogin] = 0;
    PlayerData[playerid][pLevel] = 1;
    PlayerData[playerid][pMoney] = 0;
    PlayerData[playerid][pAdmin] = 0;
    PlayerData[playerid][pLoginAttempts] = 0;
    PlayerData[playerid][pOTPAttempts] = 0;
    PlayerData[playerid][pLoggedIn] = 0;
    PlayerData[playerid][pPosX] = 0.0;
    PlayerData[playerid][pPosY] = 0.0;
    PlayerData[playerid][pPosZ] = 0.0;
    PlayerData[playerid][pPosA] = 0.0;
    PlayerData[playerid][pInterior] = 0;
    PlayerData[playerid][pVirtualWorld] = 0;
    PlayerData[playerid][pSkin] = 0;
    PlayerData[playerid][pHealth] = 100.0;
    PlayerData[playerid][pArmour] = 0.0;
    PlayerData[playerid][pBankMoney] = 0;
    PlayerData[playerid][pPlayedHours] = 0;
    PlayerData[playerid][pRegisterDate][0] = EOS;
    PlayerData[playerid][pLastLogin][0] = EOS;
    
    TempPassword[playerid][0] = EOS;
}

/*
    ===================
    SAMP CALLBACKS
    ===================
*/

public OnGameModeInit()
{
    MySQL_Connect();
    SetGameModeText("RL-Roleplay v1.0");
    return 1;
}

public OnGameModeExit()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i))
            SavePlayerData(i);
    }
    mysql_close(dbHandle);
    return 1;
}

public OnPlayerConnect(playerid)
{
    ResetPlayerData(playerid);
    GetPlayerName(playerid, PlayerData[playerid][pName], MAX_PLAYER_NAME);
    TogglePlayerSpectating(playerid, 1);
    
    SendClientMessage(playerid, 0xFFFFFFFF, " ");
    SendClientMessage(playerid, 0xFFD700FF, "===============================================");
    SendClientMessage(playerid, 0xFFFFFFFF, "Willkommen auf unserem Server!");
    SendClientMessage(playerid, 0xFFFFFFFF, "Dein Account wird ueberprueft...");
    SendClientMessage(playerid, 0xFFD700FF, "===============================================");
    SendClientMessage(playerid, 0xFFFFFFFF, " ");
    
    SetTimerEx("CheckAccountTimer", ACCOUNT_CHECK_DELAY, false, "i", playerid);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    SavePlayerData(playerid);
    ResetPlayerData(playerid);
    return 1;
}

forward OnPasswordHashed(playerid, const hash[]);
public OnPasswordHashed(playerid, const hash[])
{
    if(!IsPlayerConnected(playerid))
        return 0;
    
    format(PlayerData[playerid][pPassword], 65, "%s", hash);
    new query[256];
    mysql_format(dbHandle, query, sizeof(query),"UPDATE `accounts` SET `password` = '%e', `first_login` = 0 WHERE `id` = %d",PlayerData[playerid][pPassword],PlayerData[playerid][pID]);
    mysql_tquery(dbHandle, query);
    PlayerData[playerid][pFirstLogin] = 0;
    SendClientMessage(playerid, 0x00FF00FF, "[SUCCESS] Dein Passwort wurde erfolgreich gesetzt!");
    SendClientMessage(playerid, 0xFFFFFFFF, "Du wirst nun eingeloggt...");
    
    LoadPlayerData(playerid);
    return 1;
}

forward OnPasswordChecked(playerid, bool:success);
public OnPasswordChecked(playerid, bool:success)
{
    if(!IsPlayerConnected(playerid))
        return 0;
    
    new match = _:success;
    
    if(match)
    {
        SendClientMessage(playerid, 0x00FF00FF, "[SUCCESS] Login erfolgreich!");
        LoadPlayerData(playerid);
    }
    else
    {
        PlayerData[playerid][pLoginAttempts]++;
        
        if(PlayerData[playerid][pLoginAttempts] >= MAX_LOGIN_ATTEMPTS)
        {
            SendClientMessage(playerid, 0xFF6347FF, "[FEHLER] Zu viele falsche Login-Versuche!");
            SetTimerEx("KickPlayer", 500, false, "i", playerid);
            return 0;
        }
        
        new string[256];
        format(string, sizeof(string),"{FFFFFF}Willkommen zurueck!\n\n\{FF6347}Falsches Passwort!{FFFFFF}\nVersuche: {FF6347}%d{FFFFFF}/{FF6347}%d{FFFFFF}\n\nBitte gib dein {FFD700}Passwort{FFFFFF} ein:",PlayerData[playerid][pLoginAttempts], MAX_LOGIN_ATTEMPTS);
        
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD,"{FFD700}Login", string, "Login", "Abbrechen");
    }
    return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case DIALOG_NOREGISTER:
        {
            SetTimerEx("KickPlayer", 500, false, "i", playerid);
            return 1;
        }
        
        case DIALOG_OTP_INPUT:
        {
            if(!response)
            {
                SendClientMessage(playerid, 0xFF6347FF, "Login abgebrochen.");
                SetTimerEx("KickPlayer", 500, false, "i", playerid);
                return 1;
            }
            
            if(strlen(inputtext) < 4)
            {
                SendClientMessage(playerid, 0xFF6347FF, "[FEHLER] Ungueltiges OTP!");
                ShowPlayerDialog(playerid, DIALOG_OTP_INPUT, DIALOG_STYLE_PASSWORD,
                    "{FFD700}Erstlogin - OTP Eingabe",
                    "{FFFFFF}Willkommen auf dem Server!\n\n\
                    Dies ist dein {FF6347}erster Login{FFFFFF}.\n\
                    Bitte gib das {FFD700}One-Time-Password (OTP){FFFFFF} ein,\n\
                    das du per E-Mail erhalten hast.\n\n\
                    {FF6347}Achtung:{FFFFFF} Nach 3 falschen Versuchen wirst du gekickt!",
                    "Weiter", "Abbrechen"
                );
                return 1;
            }
            
            if(strcmp(inputtext, PlayerData[playerid][pOTP], false) != 0)
            {
                PlayerData[playerid][pOTPAttempts]++;
                
                if(PlayerData[playerid][pOTPAttempts] >= MAX_OTP_ATTEMPTS)
                {
                    SendClientMessage(playerid, 0xFF6347FF, "[FEHLER] Zu viele falsche OTP-Versuche!");
                    SetTimerEx("KickPlayer", 500, false, "i", playerid);
                    return 1;
                }
                
                new string[512];
                format(string, sizeof(string),
                    "{FFFFFF}Willkommen auf dem Server!\n\n\
                    Dies ist dein {FF6347}erster Login{FFFFFF}.\n\
                    {FF6347}Falsches OTP!{FFFFFF}\n\
                    Versuche: {FF6347}%d{FFFFFF}/{FF6347}%d{FFFFFF}\n\n\
                    Bitte gib das {FFD700}One-Time-Password (OTP){FFFFFF} ein,\n\
                    das du per E-Mail erhalten hast.",
                    PlayerData[playerid][pOTPAttempts], MAX_OTP_ATTEMPTS
                );
                
                ShowPlayerDialog(playerid, DIALOG_OTP_INPUT, DIALOG_STYLE_PASSWORD,
                    "{FFD700}Erstlogin - OTP Eingabe", string, "Weiter", "Abbrechen"
                );
                return 1;
            }
            
            ShowPlayerDialog(playerid, DIALOG_NEW_PASSWORD, DIALOG_STYLE_PASSWORD,
                "{FFD700}Neues Passwort",
                "{FFFFFF}OTP bestaetigt!\n\n\
                Bitte waehle ein {FFD700}sicheres Passwort{FFFFFF}:\n\n\
                Anforderungen:\n\
                {FFD700}*{FFFFFF} Mindestens 8 Zeichen\n\
                {FFD700}*{FFFFFF} Mindestens 1 Grossbuchstabe\n\
                {FFD700}*{FFFFFF} Mindestens 1 Zahl\n\
                {FFD700}*{FFFFFF} Mindestens 1 Sonderzeichen (!@#$%&*?_-+=)",
                "Weiter", "Abbrechen"
            );
            return 1;
        }
        
        case DIALOG_NEW_PASSWORD:
        {
            if(!response)
            {
                SendClientMessage(playerid, 0xFF6347FF, "Login abgebrochen.");
                SetTimerEx("KickPlayer", 500, false, "i", playerid);
                return 1;
            }
            
            if(!IsValidPassword(inputtext))
            {
                SendClientMessage(playerid, 0xFF6347FF, "[FEHLER] Passwort erfuellt nicht die Anforderungen!");
                ShowPlayerDialog(playerid, DIALOG_NEW_PASSWORD, DIALOG_STYLE_PASSWORD,
                    "{FFD700}Neues Passwort",
                    "{FFFFFF}OTP bestaetigt!\n\n\
                    {FF6347}Passwort ungueltig!{FFFFFF}\n\n\
                    Bitte waehle ein {FFD700}sicheres Passwort{FFFFFF}:\n\n\
                    Anforderungen:\n\
                    {FFD700}*{FFFFFF} Mindestens 8 Zeichen\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Grossbuchstabe\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Zahl\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Sonderzeichen (!@#$%&*?_-+=)",
                    "Weiter", "Abbrechen"
                );
                return 1;
            }
            
            format(TempPassword[playerid], 65, "%s", inputtext);
            
            ShowPlayerDialog(playerid, DIALOG_CONFIRM_PASSWORD, DIALOG_STYLE_PASSWORD,
                "{FFD700}Passwort bestaetigen",
                "{FFFFFF}Bitte gib dein Passwort {FFD700}erneut{FFFFFF} ein,\n\
                um es zu bestaetigen:",
                "Bestaetigen", "Zurueck"
            );
            return 1;
        }
        
        case DIALOG_CONFIRM_PASSWORD:
        {
            if(!response)
            {
                TempPassword[playerid][0] = EOS;
                ShowPlayerDialog(playerid, DIALOG_NEW_PASSWORD, DIALOG_STYLE_PASSWORD,
                    "{FFD700}Neues Passwort",
                    "{FFFFFF}OTP bestaetigt!\n\n\
                    Bitte waehle ein {FFD700}sicheres Passwort{FFFFFF}:\n\n\
                    Anforderungen:\n\
                    {FFD700}*{FFFFFF} Mindestens 8 Zeichen\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Grossbuchstabe\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Zahl\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Sonderzeichen (!@#$%&*?_-+=)",
                    "Weiter", "Abbrechen"
                );
                return 1;
            }
            
            if(strcmp(inputtext, TempPassword[playerid], false) != 0)
            {
                SendClientMessage(playerid, 0xFF6347FF, "[FEHLER] Passwoerter stimmen nicht ueberein!");
                TempPassword[playerid][0] = EOS;
                ShowPlayerDialog(playerid, DIALOG_NEW_PASSWORD, DIALOG_STYLE_PASSWORD,
                    "{FFD700}Neues Passwort",
                    "{FFFFFF}OTP bestaetigt!\n\n\
                    {FF6347}Passwoerter stimmen nicht ueberein!{FFFFFF}\n\n\
                    Bitte waehle ein {FFD700}sicheres Passwort{FFFFFF}:\n\n\
                    Anforderungen:\n\
                    {FFD700}*{FFFFFF} Mindestens 8 Zeichen\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Grossbuchstabe\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Zahl\n\
                    {FFD700}*{FFFFFF} Mindestens 1 Sonderzeichen (!@#$%&*?_-+=)",
                    "Weiter", "Abbrechen"
                );
                return 1;
            }
            
            // Passwort hashen mit bcrypt
            SendClientMessage(playerid, 0xFFFFFFFF, "Passwort wird gesichert...");
            bcrypt_hash(playerid, "OnPasswordHashed", TempPassword[playerid], 12);
            TempPassword[playerid][0] = EOS;
            
            return 1;
        }
        
        case DIALOG_LOGIN:
        {
            if(!response)
            {
                SendClientMessage(playerid, 0xFF6347FF, "Login abgebrochen.");
                SetTimerEx("KickPlayer", 500, false, "i", playerid);
                return 1;
            }
            
            // Eingabe validieren
            if(strlen(inputtext) < 1)
            {
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{FFD700}Login","{FFFFFF}Willkommen zurueck!\n\n\{FF6347}Bitte gib ein Passwort ein!{FFFFFF}\n\n\Bitte gib dein {FFD700}Passwort{FFFFFF} ein:","Login", "Abbrechen");
                return 1;
            }
            // Passwort mit bcrypt überprüfen
            bcrypt_verify(playerid, "OnPasswordChecked", inputtext, PlayerData[playerid][pPassword]);
            
            return 1;
        }
    }
    
    return 0;
}

stock LoadAllHouses()
{
    mysql_tquery(dbHandle, "SELECT * FROM `houses` WHERE `exists` = 1", "OnHousesLoaded", "");
}


forward OnHousesLoaded();
public OnHousesLoaded()
{
    new rows = cache_num_rows();
    
    if(rows == 0)
    {
        print("[HOUSES] Keine Haeuser in der Datenbank gefunden.");
        return 0;
    }
    
    new loaded = 0;
    
    for(new i = 0; i < rows; i++)
    {
        if(i >= MAX_HOUSES)
        {
            printf("[HOUSES] WARNUNG: Maximale Anzahl an Haeusern erreicht! (%d/%d)", MAX_HOUSES, rows);
            break;
        }
        
        cache_get_value_name_int(i, "id", HouseData[i][hID]);
        cache_get_value_name_int(i, "exists", HouseData[i][hExists]);
        cache_get_value_name_int(i, "owned", HouseData[i][hOwned]);
        cache_get_value_name(i, "owner_name", HouseData[i][hOwnerName], MAX_PLAYER_NAME);
        cache_get_value_name_int(i, "owner_id", HouseData[i][hOwnerID]);
        cache_get_value_name_float(i, "enter_x", HouseData[i][hEnterX]);
        cache_get_value_name_float(i, "enter_y", HouseData[i][hEnterY]);
        cache_get_value_name_float(i, "enter_z", HouseData[i][hEnterZ]);
        cache_get_value_name_float(i, "exit_x", HouseData[i][hExitX]);
        cache_get_value_name_float(i, "exit_y", HouseData[i][hExitY]);
        cache_get_value_name_float(i, "exit_z", HouseData[i][hExitZ]);
        cache_get_value_name_int(i, "interior", HouseData[i][hInterior]);
        cache_get_value_name_int(i, "virtual_world", HouseData[i][hVirtualWorld]);
        cache_get_value_name_int(i, "price", HouseData[i][hPrice]);
        cache_get_value_name_int(i, "rent_price", HouseData[i][hRentPrice]);
        cache_get_value_name_int(i, "level", HouseData[i][hLevel]);
        cache_get_value_name_int(i, "locked", HouseData[i][hLocked]);
        cache_get_value_name_int(i, "rentable", HouseData[i][hRentable]);
        cache_get_value_name_int(i, "type", HouseData[i][hType]);
        
        // Waffen laden
        cache_get_value_name_int(i, "weapon_1", HouseData[i][hWeapons][0]);
        cache_get_value_name_int(i, "weapon_2", HouseData[i][hWeapons][1]);
        cache_get_value_name_int(i, "weapon_3", HouseData[i][hWeapons][2]);
        cache_get_value_name_int(i, "weapon_4", HouseData[i][hWeapons][3]);
        cache_get_value_name_int(i, "weapon_5", HouseData[i][hWeapons][4]);
        cache_get_value_name_int(i, "weapon_6", HouseData[i][hWeapons][5]);
        cache_get_value_name_int(i, "weapon_7", HouseData[i][hWeapons][6]);
        cache_get_value_name_int(i, "weapon_8", HouseData[i][hWeapons][7]);
        cache_get_value_name_int(i, "weapon_9", HouseData[i][hWeapons][8]);
        cache_get_value_name_int(i, "weapon_10", HouseData[i][hWeapons][9]);
        
        // Munition laden
        cache_get_value_name_int(i, "ammo_1", HouseData[i][hWeaponAmmo][0]);
        cache_get_value_name_int(i, "ammo_2", HouseData[i][hWeaponAmmo][1]);
        cache_get_value_name_int(i, "ammo_3", HouseData[i][hWeaponAmmo][2]);
        cache_get_value_name_int(i, "ammo_4", HouseData[i][hWeaponAmmo][3]);
        cache_get_value_name_int(i, "ammo_5", HouseData[i][hWeaponAmmo][4]);
        cache_get_value_name_int(i, "ammo_6", HouseData[i][hWeaponAmmo][5]);
        cache_get_value_name_int(i, "ammo_7", HouseData[i][hWeaponAmmo][6]);
        cache_get_value_name_int(i, "ammo_8", HouseData[i][hWeaponAmmo][7]);
        cache_get_value_name_int(i, "ammo_9", HouseData[i][hWeaponAmmo][8]);
        cache_get_value_name_int(i, "ammo_10", HouseData[i][hWeaponAmmo][9]);
        
        cache_get_value_name_int(i, "money", HouseData[i][hMoney]);
        cache_get_value_name_int(i, "drugs", HouseData[i][hDrugs]);
        cache_get_value_name_int(i, "materials", HouseData[i][hMaterials]);
        cache_get_value_name_int(i, "alarm", HouseData[i][hAlarm]);
        cache_get_value_name_int(i, "alarm_active", HouseData[i][hAlarmActive]);
        cache_get_value_name(i, "rented_by", HouseData[i][hRentedBy], MAX_PLAYER_NAME);
        cache_get_value_name_int(i, "rented_by_id", HouseData[i][hRentedByID]);
        cache_get_value_name(i, "created_date", HouseData[i][hCreatedDate], 32);
        cache_get_value_name(i, "last_entered", HouseData[i][hLastEntered], 32);
        
        // 3D Label & Pickup erstellen
        UpdateHouseLabel(i);
        
        loaded++;
    }
    
    printf("[HOUSES] %d Haeuser erfolgreich geladen.", loaded);
    return 1;
}

/*
    Haus Label aktualisieren
*/
stock UpdateHouseLabel(houseid)
{
    if(houseid < 0 || houseid >= MAX_HOUSES)
        return 0;
    
    if(!HouseData[houseid][hExists])
        return 0;
    
    // Altes Label löschen
    if(HouseData[houseid][hLabel] != Text3D:INVALID_3DTEXT_ID)
        Delete3DTextLabel(HouseData[houseid][hLabel]);
    
    if(HouseData[houseid][hPickup] != 0)
        DestroyPickup(HouseData[houseid][hPickup]);
    
    if(HouseData[houseid][hMapIcon] != 0)
        DestroyDynamicMapIcon(HouseData[houseid][hMapIcon]);
    
    new label_text[256], type_name[32];
    
    // Haustyp bestimmen
    switch(HouseData[houseid][hType])
    {
        case 0: type_name = "Kleines Haus";
        case 1: type_name = "Mittleres Haus";
        case 2: type_name = "Grosses Haus";
        case 3: type_name = "Villa";
        case 4: type_name = "Apartment";
        default: type_name = "Unbekannt";
    }
    
    if(HouseData[houseid][hOwned])
    {
        // Haus ist gekauft
        format(label_text, sizeof(label_text), 
            "{FFD700}%s (ID: %d){FFFFFF}\n\
            Besitzer: {00FF00}%s{FFFFFF}\n\
            Preis: {00FF00}$%d{FFFFFF}\n\
            Status: {FF6347}Gekauft{FFFFFF}\n\
            %s\n\
            Druecke {FFD700}F{FFFFFF} oder {FFD700}/enter{FFFFFF}",
            type_name,
            houseid,
            HouseData[houseid][hOwnerName],
            HouseData[houseid][hPrice],
            HouseData[houseid][hLocked] ? ("{FF6347}Verschlossen") : ("{00FF00}Offen")
        );
        
        HouseData[houseid][hPickup] = CreatePickup(1272, 1, HouseData[houseid][hEnterX], HouseData[houseid][hEnterY], HouseData[houseid][hEnterZ], -1);
        HouseData[houseid][hMapIcon] = CreateDynamicMapIcon(HouseData[houseid][hEnterX], HouseData[houseid][hEnterY], HouseData[houseid][hEnterZ], 32, 0, -1, -1, -1, 500.0);
    }
    else
    {
        // Haus ist zu verkaufen
        format(label_text, sizeof(label_text), 
            "{FFD700}%s (ID: %d){FFFFFF}\n\
            Preis: {00FF00}$%d{FFFFFF}\n\
            Level: {FFD700}%d{FFFFFF}\n\
            Status: {00FF00}Zu verkaufen{FFFFFF}\n\
            Druecke {FFD700}F{FFFFFF} oder {FFD700}/buyhouse{FFFFFF}",
            type_name,
            houseid,
            HouseData[houseid][hPrice],
            HouseData[houseid][hLevel]
        );
        
        HouseData[houseid][hPickup] = CreatePickup(1273, 1, HouseData[houseid][hEnterX], HouseData[houseid][hEnterY], HouseData[houseid][hEnterZ], -1);
        HouseData[houseid][hMapIcon] = CreateDynamicMapIcon(HouseData[houseid][hEnterX], HouseData[houseid][hEnterY], HouseData[houseid][hEnterZ], 31, 0, -1, -1, -1, 500.0);
    }
    
    HouseData[houseid][hLabel] = Create3DTextLabel(label_text, 0xFFFFFFFF, HouseData[houseid][hEnterX], HouseData[houseid][hEnterY], HouseData[houseid][hEnterZ], 20.0, 0, 1);
    
    return 1;
}


stock SaveHouse(houseid)
{
    if(houseid < 0 || houseid >= MAX_HOUSES)
        return 0;
    
    if(!HouseData[houseid][hExists])
        return 0;
    
    new query[2048];
    mysql_format(dbHandle, query, sizeof(query),
        "UPDATE `houses` SET \
        `owned` = %d, \
        `owner_name` = '%e', \
        `owner_id` = %d, \
        `enter_x` = %f, \
        `enter_y` = %f, \
        `enter_z` = %f, \
        `exit_x` = %f, \
        `exit_y` = %f, \
        `exit_z` = %f, \
        `interior` = %d, \
        `virtual_world` = %d, \
        `price` = %d, \
        `rent_price` = %d, \
        `level` = %d, \
        `locked` = %d, \
        `rentable` = %d, \
        `type` = %d, \
        `weapon_1` = %d, `weapon_2` = %d, `weapon_3` = %d, `weapon_4` = %d, `weapon_5` = %d, \
        `weapon_6` = %d, `weapon_7` = %d, `weapon_8` = %d, `weapon_9` = %d, `weapon_10` = %d, \
        `ammo_1` = %d, `ammo_2` = %d, `ammo_3` = %d, `ammo_4` = %d, `ammo_5` = %d, \
        `ammo_6` = %d, `ammo_7` = %d, `ammo_8` = %d, `ammo_9` = %d, `ammo_10` = %d, \
        `money` = %d, \
        `drugs` = %d, \
        `materials` = %d, \
        `alarm` = %d, \
        `alarm_active` = %d, \
        `rented_by` = '%e', \
        `rented_by_id` = %d \
        WHERE `id` = %d",
        HouseData[houseid][hOwned],
        HouseData[houseid][hOwnerName],
        HouseData[houseid][hOwnerID],
        HouseData[houseid][hEnterX],
        HouseData[houseid][hEnterY],
        HouseData[houseid][hEnterZ],
        HouseData[houseid][hExitX],
        HouseData[houseid][hExitY],
        HouseData[houseid][hExitZ],
        HouseData[houseid][hInterior],
        HouseData[houseid][hVirtualWorld],
        HouseData[houseid][hPrice],
        HouseData[houseid][hRentPrice],
        HouseData[houseid][hLevel],
        HouseData[houseid][hLocked],
        HouseData[houseid][hRentable],
        HouseData[houseid][hType],
        HouseData[houseid][hWeapons][0], HouseData[houseid][hWeapons][1], HouseData[houseid][hWeapons][2],
        HouseData[houseid][hWeapons][3], HouseData[houseid][hWeapons][4], HouseData[houseid][hWeapons][5],
        HouseData[houseid][hWeapons][6], HouseData[houseid][hWeapons][7], HouseData[houseid][hWeapons][8],
        HouseData[houseid][hWeapons][9],
        HouseData[houseid][hWeaponAmmo][0], HouseData[houseid][hWeaponAmmo][1], HouseData[houseid][hWeaponAmmo][2],
        HouseData[houseid][hWeaponAmmo][3], HouseData[houseid][hWeaponAmmo][4], HouseData[houseid][hWeaponAmmo][5],
        HouseData[houseid][hWeaponAmmo][6], HouseData[houseid][hWeaponAmmo][7], HouseData[houseid][hWeaponAmmo][8],
        HouseData[houseid][hWeaponAmmo][9],
        HouseData[houseid][hMoney],
        HouseData[houseid][hDrugs],
        HouseData[houseid][hMaterials],
        HouseData[houseid][hAlarm],
        HouseData[houseid][hAlarmActive],
        HouseData[houseid][hRentedBy],
        HouseData[houseid][hRentedByID],
        HouseData[houseid][hID]
    );
    
    mysql_tquery(dbHandle, query);
    return 1;
}

stock ResetHouseData(houseid)
{
    if(houseid < 0 || houseid >= MAX_HOUSES)
        return 0;
    
    HouseData[houseid][hID] = 0;
    HouseData[houseid][hExists] = 0;
    HouseData[houseid][hOwned] = 0;
    HouseData[houseid][hOwnerName][0] = EOS;
    HouseData[houseid][hOwnerID] = 0;
    HouseData[houseid][hEnterX] = 0.0;
    HouseData[houseid][hEnterY] = 0.0;
    HouseData[houseid][hEnterZ] = 0.0;
    HouseData[houseid][hExitX] = 0.0;
    HouseData[houseid][hExitY] = 0.0;
    HouseData[houseid][hExitZ] = 0.0;
    HouseData[houseid][hInterior] = 0;
    HouseData[houseid][hVirtualWorld] = 0;
    HouseData[houseid][hPrice] = 0;
    HouseData[houseid][hRentPrice] = 0;
    HouseData[houseid][hLevel] = 0;
    HouseData[houseid][hLocked] = 0;
    HouseData[houseid][hRentable] = 0;
    HouseData[houseid][hType] = 0;
    
    for(new i = 0; i < 10; i++)
    {
        HouseData[houseid][hWeapons][i] = 0;
        HouseData[houseid][hWeaponAmmo][i] = 0;
    }
    
    HouseData[houseid][hMoney] = 0;
    HouseData[houseid][hDrugs] = 0;
    HouseData[houseid][hMaterials] = 0;
    HouseData[houseid][hAlarm] = 0;
    HouseData[houseid][hAlarmActive] = 0;
    HouseData[houseid][hRentedBy][0] = EOS;
    HouseData[houseid][hRentedByID] = 0;
    HouseData[houseid][hCreatedDate][0] = EOS;
    HouseData[houseid][hLastEntered][0] = EOS;
    
    if(HouseData[houseid][hLabel] != Text3D:INVALID_3DTEXT_ID)
    {
        Delete3DTextLabel(HouseData[houseid][hLabel]);
        HouseData[houseid][hLabel] = Text3D:INVALID_3DTEXT_ID;
    }
    
    if(HouseData[houseid][hPickup] != 0)
    {
        DestroyPickup(HouseData[houseid][hPickup]);
        HouseData[houseid][hPickup] = 0;
    }
    
    if(HouseData[houseid][hMapIcon] != 0)
    {
        DestroyDynamicMapIcon(HouseData[houseid][hMapIcon]);
        HouseData[houseid][hMapIcon] = 0;
    }
    
    return 1;
}

/*
    HINWEISE ZUR INTEGRATION:
    
    1. Füge in MySQL_CreateTables() hinzu:
       MySQL_CreateHouseTable();
    
    2. Füge in OnGameModeInit() hinzu:
       LoadAllHouses();
    
    3. Benötigte Includes:
       - Streamer Plugin für CreateDynamicMapIcon (optional)
       - Falls nicht vorhanden, ersetze durch CreateMapIcon
    
    4. Haustypen:
       0 = Kleines Haus (z.B. 1-Zimmer)
       1 = Mittleres Haus (z.B. 2-3 Zimmer)
       2 = Grosses Haus (z.B. 4+ Zimmer)
       3 = Villa (Luxus-Haus)
       4 = Apartment (Wohnung)
    
    5. Features:
       - Waffen-Lagerung (10 Slots)
       - Geld-Safe
       - Drogen & Materialien Lagerung
       - Alarm-System
       - Vermietungs-System
       - Level-Requirement
       - Verschließbar
       - 3D Labels & Pickups
       - Map Icons
*/