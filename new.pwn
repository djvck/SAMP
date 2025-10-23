#include <a_samp>
#include <a_mysql>



main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}


#define MAX_HOUSES 100
#define MAX_BUSINESSES 100

enum E_PLAYER
{
    pID,                        // Datenbank-ID
    pLogged,                    // 0 = nicht eingeloggt, 1 = eingeloggt
    pName[MAX_PLAYER_NAME],     // Spielername
    pPassword[128],
    pOTP[64],   
    pFirstLogin,           
    pMoney,                     // Gesamtgeld (wird mit DB synchronisiert)
    pScore,                     // Level / Punkte
    pAdmin,                     // Admin-Level
    pVIP,                       // VIP-Level
    pHouse,                     // Haus-ID (-1 = keins)
    pRentHouse,                 // Miet-Haus-ID (-1 = keins)
    Float:pPosX,                // Letzte gespeicherte Position
    Float:pPosY,
    Float:pPosZ,
    pInterior,
    pVirtualWorld,
    pSkin,
    pWantedLevel,
    Float:pHealth,
    Float:pArmor,
    pHours,                     // Spielzeit in Stunden
    pKills,
    pDeaths,
    pBanned,                    // 0 = frei, 1 = gebannt
    pMute,                      // 0 = frei, 1 = gemuted
    pRegIP[16],                 // IP bei Registrierung
    pLastIP[16],                // IP beim letzten Login
    pLastLogin[32],             // Letzter Login-Zeitstempel
    pOnlineTime                 // Minuten der aktuellen Session
};


enum E_HOUSE
{
    hID,                        // Datenbank-ID
    bool:hExists,               // Ob das Haus geladen/aktiv ist
    hOwner[MAX_PLAYER_NAME],    // Besitzername ("Keiner" wenn frei)
    hPrice,                     // Kaufpreis
    hInterior,                  // Interior-ID
    hWorld,                     // Virtual World
    Float:hEnterX,              // Eingang X
    Float:hEnterY,              // Eingang Y
    Float:hEnterZ,              // Eingang Z
    Float:hExitX,               // Ausgang X (Innen)
    Float:hExitY,
    Float:hExitZ,
    bool:hLocked,               // 1 = abgeschlossen
    hPickup,                    // Pickup-ID
    hIcon,                      // Map Icon ID
    bool:hRentable,             // 1 = mietbar
    hRentPrice,                 // Mietpreis
    hSafeMoney,                 // Geld im Safe
    hSafeDrugs,                 // Drogen im Safe
    hSafeWeapons[5],            // Waffen im Safe (IDs)
    hSafeAmmo[5]                // Munition für Waffen
};

enum E_BUSINESS
{
    bID,                    // Datenbank-ID
    bool:bExists,           // Ob Business geladen/aktiv
    bOwner[MAX_PLAYER_NAME],// Besitzername ("Keiner" = frei)
    bName[64],              // Name des Businesses
    bPrice,                 // Kaufpreis
    bType[32],              // Business-Typ (z.?B. Shop, Bank, Fraktion)
    Float:bEntranceX,       // Eingang X
    Float:bEntranceY,       // Eingang Y
    Float:bEntranceZ,       // Eingang Z
    Float:bExitX,           // Exit X (Teleport-Ziel beim Betreten)
    Float:bExitY,           // Exit Y
    Float:bExitZ,           // Exit Z
    bInterior,              // Interior
    bWorld,                 // Virtual World
    bool:bLocked,           // 1 = abgeschlossen
    bPickup,                // Pickup-ID
    bIcon                   // Map Icon
};

new BizInfo[MAX_BUSINESSES][E_BUSINESS];
new HouseInfo[MAX_HOUSES][E_HOUSE];
new PlayerInfo[MAX_PLAYERS][E_PLAYER];


#define MYSQL_HOST "127.0.0.1"
#define MYSQL_USER "gta"
#define MYSQL_PASSWORD "Hallo123"
#define MYSQL_DB "gta"
new MySQL:mysql;


forward MySQLConnect();
forward MySQLCreateTables();
forward MySQLLoadBusinesses();


public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
    MySQLConnect();
    MySQLCreateTables();
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public MySQLConnect()
{
    print("[MySQL] Verbindungsaufbau...");
    mysql_log(ALL);

    mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB);

    if (mysql_errno(mysql) != 0)
    {
            print("[MySQL] Es konnte keine Verbindung zur Datenbank hergestellt werden.");
            print("[MySQL] Bitte prüfen Sie die Verbindungsdaten.");
            print("[MySQL] Der Server wird heruntergefahren.");
            return SendRconCommand("exit");
    }
    printf("[MySQL] Die Verbindung zur Datenbank wurde erfolgreich hergestellt! Handle: %d", _:mysql);
    return 1;
}

public MySQLCreateTables()
{
    new query[2048];
    query[0] = '\0';
    strcat(query, "CREATE TABLE IF NOT EXISTS `players` (");
    strcat(query, "`id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,");
    strcat(query, "`name` VARCHAR(24) NOT NULL UNIQUE,");
    strcat(query, "`password` VARCHAR(128) NOT NULL,");
    strcat(query, "`otp` VARCHAR(64) DEFAULT '',");
    strcat(query, "`first_login` INT(11) DEFAULT 0,");
    strcat(query, "`money` INT(11) DEFAULT 0,");
    strcat(query, "`score` INT(11) DEFAULT 0,");
    strcat(query, "`admin` INT(11) DEFAULT 0,");
    strcat(query, "`vip` INT(11) DEFAULT 0,");
    strcat(query, "`house` INT(11) DEFAULT -1,");
    strcat(query, "`rent_house` INT(11) DEFAULT -1,");
    strcat(query, "`pos_x` FLOAT DEFAULT 0.0,");
    strcat(query, "`pos_y` FLOAT DEFAULT 0.0,");
    strcat(query, "`pos_z` FLOAT DEFAULT 0.0,");
    strcat(query, "`interior` INT(11) DEFAULT 0,");
    strcat(query, "`virtual_world` INT(11) DEFAULT 0,");
    strcat(query, "`skin` INT(11) DEFAULT 0,");
    strcat(query, "`wanted_level` INT(11) DEFAULT 0,");
    strcat(query, "`health` FLOAT DEFAULT 100.0,");
    strcat(query, "`armor` FLOAT DEFAULT 0.0,");
    strcat(query, "`hours` INT(11) DEFAULT 0,");
    strcat(query, "`kills` INT(11) DEFAULT 0,");
    strcat(query, "`deaths` INT(11) DEFAULT 0,");
    strcat(query, "`banned` INT(11) DEFAULT 0,");
    strcat(query, "`mute` INT(11) DEFAULT 0,");
    strcat(query, "`reg_ip` VARCHAR(16) DEFAULT '',");
    strcat(query, "`last_ip` VARCHAR(16) DEFAULT '',");
    strcat(query, "`last_login` VARCHAR(32) DEFAULT '',");
    strcat(query, "`online_time` INT(11) DEFAULT 0");
    strcat(query, ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;");
    
    mysql_tquery(mysql, query, "", "");
    
    printf("[MySQL] Tabelle 'players' wurde erstellt/überprüft.");

    query[0] = '\0'; // Wichtig – String leeren, bevor strcat genutzt wird

    strcat(query, "CREATE TABLE IF NOT EXISTS `houses` (");
    strcat(query, "`id` INT(11) NOT NULL AUTO_INCREMENT,");
    strcat(query, "`owner` VARCHAR(24) DEFAULT 'Keiner',");
    strcat(query, "`price` INT(11) DEFAULT 0,");
    strcat(query, "`interior` INT(11) DEFAULT 0,");
    strcat(query, "`world` INT(11) DEFAULT 0,");
    strcat(query, "`enter_x` FLOAT DEFAULT 0,");
    strcat(query, "`enter_y` FLOAT DEFAULT 0,");
    strcat(query, "`enter_z` FLOAT DEFAULT 0,");
    strcat(query, "`exit_x` FLOAT DEFAULT 0,");
    strcat(query, "`exit_y` FLOAT DEFAULT 0,");
    strcat(query, "`exit_z` FLOAT DEFAULT 0,");
    strcat(query, "`locked` TINYINT(1) DEFAULT 0,");
    strcat(query, "`rentable` TINYINT(1) DEFAULT 0,");
    strcat(query, "`rent_price` INT(11) DEFAULT 0,");
    strcat(query, "`safe_money` INT(11) DEFAULT 0,");
    strcat(query, "`safe_drugs` INT(11) DEFAULT 0,");
    strcat(query, "`safe_weapon1` INT(11) DEFAULT 0,");
    strcat(query, "`safe_weapon2` INT(11) DEFAULT 0,");
    strcat(query, "`safe_weapon3` INT(11) DEFAULT 0,");
    strcat(query, "`safe_weapon4` INT(11) DEFAULT 0,");
    strcat(query, "`safe_weapon5` INT(11) DEFAULT 0,");
    strcat(query, "`safe_ammo1` INT(11) DEFAULT 0,");
    strcat(query, "`safe_ammo2` INT(11) DEFAULT 0,");
    strcat(query, "`safe_ammo3` INT(11) DEFAULT 0,");
    strcat(query, "`safe_ammo4` INT(11) DEFAULT 0,");
    strcat(query, "`safe_ammo5` INT(11) DEFAULT 0,");
    strcat(query, "PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");
    mysql_tquery(mysql, query);
    printf("[MYSQL] Tabelle `houses` überprüft/erstellt.");


    query[0] = '\0';

    strcat(query, "CREATE TABLE IF NOT EXISTS `businesses` (");
    strcat(query, "`id` INT(11) NOT NULL AUTO_INCREMENT,");
    strcat(query, "`owner` VARCHAR(24) DEFAULT 'Keiner',");
    strcat(query, "`name` VARCHAR(64) DEFAULT '',");
    strcat(query, "`price` INT(11) DEFAULT 0,");
    strcat(query, "`type` VARCHAR(32) DEFAULT '',");
    strcat(query, "`entrance_x` FLOAT DEFAULT 0,");
    strcat(query, "`entrance_y` FLOAT DEFAULT 0,");
    strcat(query, "`entrance_z` FLOAT DEFAULT 0,");
    strcat(query, "`exit_x` FLOAT DEFAULT 0,");
    strcat(query, "`exit_y` FLOAT DEFAULT 0,");
    strcat(query, "`exit_z` FLOAT DEFAULT 0,");
    strcat(query, "`interior` INT(11) DEFAULT 0,");
    strcat(query, "`world` INT(11) DEFAULT 0,");
    strcat(query, "`locked` TINYINT(1) DEFAULT 0,");
    strcat(query, "PRIMARY KEY (`id`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;");

    mysql_tquery(mysql, query);
    printf("[MYSQL] Tabelle `businesses` überprüft/erstellt.");

    return 1;
}


public MySQLLoadBusinesses()
{
    new Cache:result, rows;
    result = mysql_query(mysql, "SELECT * FROM businesses");
    rows = cache_num_rows();

    if (rows == 0)
    {
        printf("[BUSINESS] Keine Businesses in der Datenbank gefunden.");
        cache_delete(result);
        return 0;
    }

    for (new i = 0; i < rows && i < MAX_BUSINESSES; i++)
    {
        BizInfo[i][bExists] = true;
        BizInfo[i][bID] = cache_get_field_content_int(i, "id");
        cache_get_field_content(i, "owner", BizInfo[i][bOwner], MAX_PLAYER_NAME);
        cache_get_field_content(i, "name", BizInfo[i][bName], 64);
        cache_get_field_content(i, "type", BizInfo[i][bType], 32);



        BizInfo[i][bPrice] = cache_get_field_content_int(i, "price");
        BizInfo[i][bEntranceX] = cache_get_field_content_float(i, "entrance_x");
        BizInfo[i][bEntranceY] = cache_get_field_content_float(i, "entrance_y");
        BizInfo[i][bEntranceZ] = cache_get_field_content_float(i, "entrance_z");
        BizInfo[i][bExitX] = cache_get_field_content_float(i, "exit_x");
        BizInfo[i][bExitY] = cache_get_field_content_float(i, "exit_y");
        BizInfo[i][bExitZ] = cache_get_field_content_float(i, "exit_z");
        BizInfo[i][bInterior] = cache_get_field_content_int(i, "interior");
        BizInfo[i][bWorld] = cache_get_field_content_int(i, "world");
        BizInfo[i][bLocked] = cache_get_field_content_int(i, "locked");

        // Pickup & Map-Icon erstellen
        BizInfo[i][bPickup] = CreatePickup(1273, 1, BizInfo[i][bEntranceX], BizInfo[i][bEntranceY], BizInfo[i][bEntranceZ]);
        BizInfo[i][bIcon] = CreateDynamicMapIcon(BizInfo[i][bEntranceX], BizInfo[i][bEntranceY], BizInfo[i][bEntranceZ], 52, 0.9, 0xFFFF00FF);
    }

    cache_delete(result);
    printf("[BUSINESS] %d Businesses geladen.", rows);
    return 1;
}
