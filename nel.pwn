#include <a_samp>
#include <izcmd>
#include <a_mysql>
#include <streamer>
#include <sscanf2>
#include <banfix>


#define COLOR_WHITE        0xFFFFFFFF
#define COLOR_BLACK        0xFF000000
#define COLOR_RED          0xFFFF0000
#define COLOR_GREEN        0xFF00FF00
#define COLOR_BLUE         0xFF0000FF
#define COLOR_CYAN         0xFF00FFFF
#define COLOR_MAGENTA      0xFFFF00FF
#define COLOR_YELLOW       0xFFFFFF00
#define COLOR_ORANGE       0xFFFFA500
#define COLOR_PURPLE       0xFF800080
#define COLOR_GRAY         0x9c9ca1AA
#define COLOR_LIGHTGRAY    0xFFD3D3D3
#define COLOR_DARKRED      0xFF8B0000
#define COLOR_DARKGREEN    0xFF006400
#define COLOR_DARKBLUE     0xFF00008B
#define COLOR_DARKCYAN     0xFF008B8B
#define COLOR_DARKMAGENTA  0xFF8B008B
#define COLOR_DARKORANGE   0xFFFF8C00
#define COLOR_PINK         0xFFFFC0CB
#define COLOR_BROWN        0xFFA52A2A
#define COLOR_GOLD         0xFFFFD700
#define COLOR_SILVER       0xFFC0C0C0
#define COLOR_SKYBLUE      0xFF87CEEB
#define COLOR_LIME         0xFF00FF00
#define COLOR_INDIGO       0xFF4B0082
#define COLOR_VIOLET       0xFFEE82EE
#define COLOR_TURQUOISE    0xFF40E0D0
#define COLOR_NAVY         0xFF000080
#define COLOR_OLIVE        0xFF808000
#define COLOR_TEAL         0xFF008080
#define COLOR_MAROON       0xFF800000
#define COLOR_AQUA         0xFF00FFFF
#define COLOR_FUCHSIA      0xFFFF00FF
#define COLOR_BEIGE        0xFFF5F5DC
#define COLOR_CORAL        0xFFFF7F50
#define COLOR_CRIMSON      0xFFDC143C
#define COLOR_KHAKI        0xFFF0E68C
#define COLOR_LAVENDER     0xFFE6E6FA
#define COLOR_MINT         0xFF98FF98
#define COLOR_OLIVE_DRAB   0xFF6B8E23
#define COLOR_ORCHID       0xFFDA70D6
#define COLOR_SALMON       0xFFFA8072
#define COLOR_TOMATO       0xFFFF6347
#define COLOR_TURQUOISE2   0xFF00CED1
#define COLOR_VIOLET2      0xFF8A2BE2
#define COLOR_YELLOW2      0xFF9ACD32
#define COLOR_CHOCOLATE    0xFFD2691E
#define COLOR_CRIMSON2     0xFFB22222
#define COLOR_DARKGOLDEN   0xFFB8860B
#define COLOR_DARKGRAY     0xFFA9A9A9
#define COLOR_DARKKHAKI    0xFFBDB76B
#define COLOR_DARKMAGENTA2 0xFF8B008B
#define COLOR_DARKOLIVE    0xFF556B2F
#define COLOR_DARKORCHID   0xFF9932CC
#define COLOR_DARKSALMON   0xFFE9967A
#define COLOR_DARKSEAGREEN 0xFF8FBC8F
#define COLOR_DARKSLATE    0xFF2F4F4F
#define COLOR_DEEPPINK     0xFFFF1493
#define COLOR_DEEPSKYBLUE  0xFF00BFFF
#define COLOR_DIMGRAY      0xFF696969
#define COLOR_FIREBRICK    0xFFB22222
#define COLOR_FLORALWHITE  0xFFFFFAF0
#define COLOR_FORESTGREEN  0xFF228B22
#define COLOR_GAINSBORO    0xFFDCDCDC
#define COLOR_HOTPINK      0xFFFF69B4
#define COLOR_INDIGO2      0xFF4B0082
#define COLOR_IVORY        0xFFFFFFF0
#define COLOR_KHAKI2       0xFFF0E68C
#define COLOR_LAVENDERBLUSH 0xFFFFF0F5
#define COLOR_LEMONCHIFFON 0xFFFFFACD
#define COLOR_LIGHTBLUE    0xFFADD8E6
#define COLOR_LIGHTCORAL   0xFFF08080
#define COLOR_LIGHTCYAN    0xFFE0FFFF
#define COLOR_LIGHTGOLDEN  0xFFFAFAD2
#define COLOR_LIGHTGREEN   0xFF90EE90
#define COLOR_LIGHTPINK    0xFFFFB6C1
#define COLOR_LIGHTSALMON  0xFFFFA07A
#define COLOR_LIGHTSEAGREEN 0xFF20B2AA
#define COLOR_LIGHTSKYBLUE 0xFF87CEFA
#define COLOR_LIGHTSLATE   0xFF778899
#define COLOR_LIGHTSTEEL   0xFFB0C4DE
#define COLOR_LIGHTYELLOW  0xFFFFFFE0
#define COLOR_MEDIUMAQUA   0xFF66CDAA
#define COLOR_MEDIUMBLUE   0xFF0000CD
#define COLOR_MEDIUMORCHID 0xFFBA55D3
#define COLOR_MEDIUMPURPLE 0xFF9370DB
#define COLOR_MEDIUMSEAGREEN 0xFF3CB371
#define COLOR_MEDIUMSLATE  0xFF7B68EE
#define COLOR_MEDIUMSPRING 0xFF00FA9A
#define COLOR_MEDIUMTURQ   0xFF48D1CC
#define COLOR_MEDIUMVIOLET 0xFFC71585
#define COLOR_MIDNIGHTBLUE 0xFF191970
#define COLOR_MINTCREAM    0xFFF5FFFA
#define COLOR_MISTYROSE    0xFFFFE4E1
#define COLOR_MOCCASIN     0xFFFFE4B5
#define COLOR_NAVAJOWHITE  0xFFFFDEAD
#define COLOR_OLDLACE      0xFFFDF5E6
#define COLOR_OLIVEDRAB2   0xFF6B8E23
#define COLOR_ORANGERED    0xFFFF4500
#define COLOR_PALEGREEN    0xFF98FB98
#define COLOR_PALETURQUOISE 0xFFAFEEEE
#define COLOR_PALEVIOLET   0xFFDB7093
#define COLOR_PAPAYA       0xFFFFEFD5
#define COLOR_PEACHPUFF    0xFFFFDAB9
#define COLOR_PERU         0xFFCD853F
#define COLOR_PINK2        0xFFFFC0CB
#define COLOR_PLUM         0xFFDDA0DD
#define COLOR_POWDERBLUE   0xFFB0E0E6
#define COLOR_PURPLE2      0xC2A2DAAA
#define COLOR_REBECCAPURPLE 0xFF663399
#define COLOR_ROSYBROWN    0xFFBC8F8F
#define COLOR_ROYALBLUE    0xFF4169E1
#define COLOR_SADDLEBROWN  0xFF8B4513
#define COLOR_SALMON2      0xFFFA8072
#define COLOR_SANDYBROWN   0xFFF4A460
#define COLOR_SEAGREEN     0xFF2E8B57
#define COLOR_SEASHELL     0xFFFFF5EE
#define COLOR_SIENNA       0xFFA0522D
#define COLOR_SILVER2      0xFFC0C0C0
#define COLOR_SKYBLUE2     0xFF87CEEB
#define COLOR_SLATEBLUE    0xFF6A5ACD
#define COLOR_SLATEGRAY    0xFF708090
#define COLOR_SNOW         0xFFFFFAFA
#define COLOR_SPRINGGREEN  0xFF00FF7F
#define COLOR_STEELBLUE    0xFF4682B4
#define COLOR_TAN          0xFFD2B48C
#define COLOR_TEAL2        0xFF008080
#define COLOR_THISTLE      0xFFD8BFD8
#define COLOR_TOMATO2      0xFFFF6347
#define COLOR_TURQUOISE3   0xFF40E0D0
#define COLOR_VIOLET3      0xFFEE82EE
#define COLOR_WHEAT        0xFFF5DEB3
#define COLOR_YELLOW3      0xFFFFFF00
#define SAMP_COLOR         0xA9C4E4FF
#define SAMP_RED           0xF88379AA
#define COLOR_ME           0xC2A2DAAA
#define COLOR_DO           0xC2A2DAAA


#define DIALOGGRAY         "{D3D3D3}"
#define DIALOGGREEN        "{90EE90}"

#define BABY_BLUE          0x709dffAA

#define PICKUP_SOLD        1272
#define PICKUP_FORSALE     1273

#define SERVERNAME "Neverland e-Life"
#define GAMEVERSION "v0.2 R2-1"
#define GAMEMODE "Reallife"

#define MYSQL_HOST "127.0.0.1"
#define MYSQL_USER "gta"
#define MYSQL_PASSWORD "Hallo123"
#define MYSQL_DB "gta"

#define MAX_HOUSES 150
#define MAX_BIZ    200

new MySQL:mysql;


forward MySQLCreatePlayerTable();
forward CreateHouseTable();
forward MySQLLoadHouses();
forward OnHousesLoaded();
forward LoadBizz();
forward OnBizLoaded();
forward SaveHouse(id);
forward OnHouseCreated(houseid);

#define TALK_RADIUS 20.0
#define MAX_LINE_LENGTH 75
#define COLOR_TALK 0xE6E6E6FF

enum
{
    DIALOG_NOACC,
    DIALOG_LOGIN,
    DIALOG_FIRST_LOGIN,
    DIALOG_RULES,
    DIALOG_SETPASS,
    DIALOG_PASSWORD_CONFIRM

}

enum pData
{
    p_id,
    bool:pLoggedIn,
    pName[MAX_PLAYER_NAME + 1],
    pPassword[128],
    pOTP[128],
    pFirstTime,
    pLoginTries,
    pAdmin,
    pLevel,
    pMoney,
    pKills,
    pDeaths,
    bool:pGender,
    pAge,
    Float:pPosX,
    Float:pPosY,
    Float:pPosZ,
    Float:pPosA,
    pSkin,
    pInterior,
    pVirtualW
}

enum E_HOUSE
{
    hID,
    bool:hExists,
    hOwner[MAX_PLAYER_NAME],
    hAddress[40],
    hPrice,
    hInterior,
    hWorld,
    Float:hEnterX,
    Float:hEnterY,
    Float:hEnterZ,
    Float:hExitX,
    Float:hExitY,
    Float:hExitZ,
    bool:hLocked,
    hPickup,
    hIcon,
    Text3D:hText,
    bool:hRentable,
    hRentPrice,
    hSafeMoney,
    hSafeDrugs,
    hSafeWeapons[5],
    hSafeAmmo[5]
}



enum E_BIZ
{
    bID,
    bName[30],
    bAddress[40],
    bPurchaseable,
    bPrice,
    bOwner[MAX_PLAYER_NAME],
    bCoOwner[MAX_PLAYER_NAME],
    bInterior,
    bWorld,
    Float:bEnterX,
    Float:bEnterY,
    Float:bEnterZ,
    Float:bExitX,
    Float:bExitY,
    Float:bExitZ,
    bPickup,
    Text3D:bLabel,
    bOpen,
    bOpeningHours[20],
    bMoney
}

new BizInfo[MAX_BIZ][E_BIZ];
new HouseInfo[MAX_HOUSES][E_HOUSE];
new player[MAX_PLAYERS][pData];


new ServerHour = 0;
new ServerMinute = 0;
new TimerUpdateTime;
new TimerUpdateTextdraw;
new ConnectTimer[MAX_PLAYERS];
new bool:MotorToggling[MAX_PLAYERS];


new Text:ServerClock;


new VehicleNames[212][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perennial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch",
    "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto",
    "Taxi", "Washington", "Bobcat", "Mr Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer", "Securicar", "Banshee",
    "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer 1", "Previon", "Coach", "Cabbie", "Stallion",
    "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram",
    "Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
    "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
    "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina",
    "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxville", "Benson",
    "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike",
    "Mountain Bike", "Beagle", "Cropdust", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal",
    "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck", "Fortune", "Cadrona", "FBI Truck", "Willard",
    "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex",
    "Vincent", "Bullet", "Clover", "Sadler", "Firetruck LA", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa",
    "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster A", "Monster B", "Uranus", "Jester",
    "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito", "Freight Flat",
    "Streak Carriage", "Kart", "Mower", "Duneride", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley",
    "Stafford", "BF-400", "Newsvan", "Tug", "Trailer 3", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Carriage", "Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LSPD)", "Police Car (SFPD)", "Police Car (LVPD)", "Police Ranger",
    "Picador", "S.W.A.T. Van", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer A", "Luggage Trailer B", "Stair Trailer", "Boxville",
    "Farm Plow", "Utility Trailer"
};

main()
{
    print("\n----------------------------------");
    print(" Neverland e-Life");
    print("----------------------------------\n");
}


public OnGameModeInit()
{

    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);
    ManualVehicleEngineAndLights();
    CreateClockTD();

    new hour;
    new minute;
    new second;
    gettime(hour, minute, second);

    ServerHour = hour;
    ServerMinute = minute;

    TimerUpdateTime = SetTimer("UpdateServerClock", 7500, true);
    //TimerUpdateTextdraw = SetTimer("UpdateClockTextdraw", 10000, true);
    SetWorldTime(ServerHour);

    UpdateDayNightCycle();


    MySQSL_Connection();
    MySQLCreatePlayerTable();
    CreateHouseTable();
    CreateBusinessTable();
    LoadBizz();
    MySQLLoadHouses();
    SetGameModeText("German Reallife");
    AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
    return 1;
}





public OnGameModeExit()
{
    mysql_close(mysql);
    return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    StartLoginCamera(playerid);
    SendClientMessage(playerid, SAMP_COLOR, "Herzlich willkommen auf Neverland e-Life.");
    SendClientMessage(playerid, SAMP_COLOR, "Die Spielwelt wird für dich aufgebaut, wir bitten um etwas Geduld ...");
    SendClientMessage(playerid, SAMP_COLOR, "Überprüfe Account ...");
    //SendClientMessage(playerid, -1, "{6b8bc2}INFO{FFFFFF}: Die Spielewelt wird aufgebaut, bitte um etwas Geduld ...");
    //SendClientMessage(playerid, -1, "{6b8bc2}INFO{FFFFFF}: Es wird Überprüft ob du einen Account hast ...");
    if (!player[playerid][pLoggedIn]) ConnectTimer[playerid] = SetTimerEx("ConnectDelay", 10000, false, "i", playerid);
    return 1;
}


forward ConnectDelay(playerid);
public ConnectDelay(playerid)
{
    new buffer[128];
    mysql_format(mysql, buffer, sizeof(buffer), "SELECT id, FirstLogin FROM players WHERE name = '%e'", player[playerid][pName]);
    mysql_pquery(mysql, buffer, "OnPlayerCheck", "d", playerid);
    return 1;
}


forward OnPlayerCheck(playerid);
public OnPlayerCheck(playerid)
{
    new r;
    new buf[600];
    cache_get_row_count(r);
    if (r == 0)
    {
        format(buf, sizeof(buf), "{90EE90}Willkommen auf Neverland e-Life.com!\n\n{D3D3D3}Es konnte kein Account unter dem Namen {4682B4}%s{D3D3D3} gefunden werden.\n\nUm auf unserem SA:MP Server spielen zu können, musst du dich zuerst im Forum registrieren.\nNach erfolgreicher Registration im Forum, kannst du einen Spieleraccount erstellen.\nSobald du einen Spieleraccount erstellt hast, kannst du dich\nmit unserem SA:MP Server verbinden und dein neues Abenteuer starten!\n\n{90EE90}Wir wünschen dir viel Spaß und freuen uns dich bald begrüßen zu dürfen!\n\n{4682B4}Forum: {FFFFFF}www.neverland-elife.com", player[playerid][pName]);
        ShowPlayerDialog(playerid, DIALOG_NOACC, DIALOG_STYLE_MSGBOX, "Registrierung erforderlich!", buf, "Verstanden", "");
        Kick(playerid);
    }
    else
    {
        cache_get_value_name_int(0, "FirstLogin", player[playerid][pFirstTime]);
        if (!player[playerid][pFirstTime])
        {
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Anmeldung", #DIALOGGRAY"Willkommen zurück!\n\nBitte trage dein Passwort unten in das Eingabefeld ein:\n\n{F88379}INFO: Bitte beachte, dass du 3 Versuche hast das Passwort korrekt einzugeben.", "Ok", "Abbrechen");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_FIRST_LOGIN, DIALOG_STYLE_PASSWORD, "Erste Anmeldung", #DIALOGGRAY"Herzlich Willkommen!\n\nBitte gib das Einmalpasswort ein welches du von einem Administrator erhalten hast:\n\n{F88379}Info: Im Anschluss wirst du gebeten ein neues Passwort einzugeben.", "Ok", "Abbrechen");
        }
    }
    return 1;
}

public OnPlayerConnect(playerid)
{
    for (new i = 0; i < 100; i++)
    {
        SendClientMessage(playerid, -1, "");
    }
    SetPlayerTime(playerid, ServerHour, ServerMinute);
    //SendClientMessage(playerid, -1, "Herzlich Willkommen auf {4169E1}Neverland e-Life{FFFFFF}. ({4169E1}www.neverland-elife.com{FFFFFF})");
    for (new i = 0; i < _:pData; i++)
    {
        player[playerid][pData:i] = 0;
    }
    player[playerid][pLoggedIn] = false;
    GetPlayerName(playerid, player[playerid][pName], MAX_PLAYER_NAME);

    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    KillTimer(ConnectTimer[playerid]);
    MySQL_SavePlayer(playerid);
    return 1;
}

public OnPlayerSpawn(playerid)
{
    TextDrawShowForPlayer(playerid, ServerClock);
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
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new len = strlen(text);

    if (len <= MAX_LINE_LENGTH)
    {
        // Text passt in eine Zeile
        new string[144];
        format(string, sizeof(string), "%s sagt: %s", name, text);
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, TALK_RADIUS, x, y, z))
            {
                SendClientMessage(i, COLOR_TALK, string);
            }
        }
    }
    else
    {
        // Text ist zu lang - teile ihn auf
        new part1[80], part2[80];
        new splitPos = MAX_LINE_LENGTH;

        // Suche letztes Leerzeichen
        for (new i = MAX_LINE_LENGTH - 1; i > 0; i--)
        {
            if (text[i] == ' ')
            {
                splitPos = i;
                break;
            }
        }

        // Kopiere ersten Teil
        for (new i = 0; i < splitPos; i++)
        {
            part1[i] = text[i];
        }
        part1[splitPos] = 0;

        // Kopiere zweiten Teil (berspringe Leerzeichen)
        new pos = 0;
        for (new i = splitPos + 1; i < len; i++)
        {
            part2[pos] = text[i];
            pos++;
        }
        part2[pos] = 0;

        // Sende beide Zeilen
        new string[144];
        format(string, sizeof(string), "%s sagt: %s", name, part1);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, TALK_RADIUS, x, y, z))
            {
                SendClientMessage(i, COLOR_TALK, string);

                format(string, sizeof(string), "... %s", part2);
                SendClientMessage(i, COLOR_TALK, string);
            }
        }
    }

    return 0;
}


public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new vid = GetPlayerVehicleID(playerid);
    new e, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, e, lights, alarm, doors, bonnet, boot, objective);

    if (e == 1)
    {
        SendClientMessage(playerid, -1, "[Debug:] Motor an");
    }
    else
    {
        SendClientMessage(playerid, -1, "[Debug:] Motor aus");
    }
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
    new buf[500];
    switch (dialogid)
    {
        case DIALOG_FIRST_LOGIN:
        {
            if (!response) return Kick(playerid);
            mysql_format(mysql, buf, sizeof(buf), "SELECT * FROM players WHERE name = '%e' AND otp = '%e'", player[playerid][pName], inputtext);
            mysql_pquery(mysql, buf, "OnPlayerLogin", "d", playerid);
            print(buf);
            return 1;
        }
        case DIALOG_LOGIN:
        {
            if (!response) return Kick(playerid);
            if (strlen(inputtext) < 3)
            {
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Anmeldung", #DIALOGGRAY"Bitte trage dein Passwort unten in das Eingabefeld ein:\n\n{AA3333}Du hast ein falsches Passwort eigegeben!", "Weiter", "Abbrechen");
            }
            mysql_format(mysql, buf, sizeof(buf), "SELECT * FROM players WHERE name = '%e' AND password = MD5('%e')", player[playerid][pName], inputtext);
            mysql_pquery(mysql, buf, "OnPlayerLogin", "d", playerid);
            print(buf);
            return 1;
        }
        case DIALOG_SETPASS:
        {
            // new pass
            if (!response) return Kick(playerid);
            if (strlen(inputtext) < 8)
            {
                ShowPlayerDialog(playerid, DIALOG_SETPASS, DIALOG_STYLE_PASSWORD, "Neues Passwort", #DIALOGGRAY"Das von dir eingegebene Passwort entspricht nicht den Mindestanforderungen.\n\nBitte gib ein sicheres Passwort ein:\n\n"#DIALOGGREEN"** Das Passwort muss mindestens 8 Zeichen lang sein\n** Das Passwort muss mindestens 1 Sonderzeichen enthalten\n** Das Passwort muss mindestens eine Zahl enthalten\n** Das Passwort muss mindestens einen Großbuchstaben enthalten\n\n"#DIALOGGRAY"Bitte merke dir dein Passwort.", "Weiter", "Abbrechen");
                return 1;
            }
            if (!IsPasswordValid(inputtext))
            {

                ShowPlayerDialog(playerid, DIALOG_SETPASS, DIALOG_STYLE_PASSWORD, "Neues Passwort", #DIALOGGRAY"Das von dir eingegebene Passwort entspricht nicht den Mindestanforderungen.\n\nBitte gib ein sicheres Passwort ein:\n\n"#DIALOGGREEN"** Das Passwort muss mindestens 8 Zeichen lang sein\n** Das Passwort muss mindestens 1 Sonderzeichen enthalten\n** Das Passwort muss mindestens eine Zahl enthalten\n\n** Das Passwort muss mindestens einen Großbuchstaben enthalten\n\n"#DIALOGGRAY"Bitte merke dir dein Passwort.", "Weiter", "Abbrechen");
                return 1;
            }
            format(player[playerid][pPassword], 128, "%s", inputtext);
            ShowPlayerDialog(playerid, DIALOG_PASSWORD_CONFIRM, DIALOG_STYLE_PASSWORD, "Neues Passwort", #DIALOGGRAY"Sehr gut! Bitte gib das Passwort, zur Bestätigung, erneut ein:", "Weiter", "Abbrechen");
            return 1;
        }
        case DIALOG_PASSWORD_CONFIRM:
        {
            if (!response) return Kick(playerid);
            if (strcmp(player[playerid][pPassword], inputtext))
            {
                ShowPlayerDialog(playerid, DIALOG_PASSWORD_CONFIRM, DIALOG_STYLE_PASSWORD, "Neues Passwort", #DIALOGGRAY"Bitte gib das Passwort, zur Bestätigung, erneut ein:\n\n{FF0000}Die Passwörter stimmen nicht überein. Bitte versuche es erneut!", "Weiter", "Abbrachen");
                return 1;
            }
            mysql_format(mysql, buf, sizeof(buf), "UPDATE players SET password = MD5('%e'), FirstLogin = 0 WHERE name = '%e'", player[playerid][pPassword], player[playerid][pName]);
            mysql_tquery(mysql, buf);
            MySQL_LoadPlayer(playerid);
        }

    }
    return 1;
}

forward OnPlayerLogin(playerid);
public OnPlayerLogin(playerid)
{
    new buf[128];
    new r;
    cache_get_row_count(r);
    //if (!player[playerid][pFirstTime])
    if (!r)
    {
        if (!player[playerid][pFirstTime])
        {
            player[playerid][pLoginTries]++;
            if (player[playerid][pLoginTries] >= 3) return Kick(playerid);
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Anmeldung", #DIALOGGRAY"Bitte trage dein Passwort unten in das Eingabefeld ein:\n\n{AA3333}Du hast ein falsches Passwort eigegeben!", "Weiter", "Abbrechen");
            format(buf, sizeof(buf), "{AA3333}ERROR{FFFFFF}: Falsches Passwort! Das ist der %d. Fehlversuch von 3.", player[playerid][pLoginTries]);
            SendClientMessage(playerid, -1, buf);
        }
        else
        {
            player[playerid][pLoginTries]++;
            if (player[playerid][pLoginTries] >= 3) return Kick(playerid);
            ShowPlayerDialog(playerid, DIALOG_FIRST_LOGIN, DIALOG_STYLE_PASSWORD, "Erste Anmeldung", "{FFFF00}Du hast das falsche Passwort eingegeben!"#DIALOGGRAY"\n\nBitte gib das Einmalpasswort ein welches du von einem Administrator erhalten hast:\n\n{F88379}Info: Im Anschluss wirst du gebeten ein neues Passwort einzugeben.", "Ok", "Abbrechen");
            format(buf, sizeof(buf), "{AA3333}ERROR{FFFFFF}: Falsches Passwort! Das ist der %d. Fehlversuch von 3.", player[playerid][pLoginTries]);
            SendClientMessage(playerid, -1, buf);
        }
    }
    else
    {
        if (!player[playerid][pFirstTime])
        {
            // load
            player[playerid][pLoginTries] = 0;
            MySQL_LoadPlayer(playerid);
        }
        else
        {
            //Neues Passwort vergeben
            player[playerid][pLoginTries] = 0;
            ShowPlayerDialog(playerid, DIALOG_SETPASS, DIALOG_STYLE_PASSWORD, "Neues Passwort", #DIALOGGRAY"Das Einmalpasswort wurde korrekt eingegeben.\n\nDu kannst nun dein eigenes Passwort vergeben.\n\n"#DIALOGGREEN"** Das Passwort muss mindestens 8 Zeichen lang sein\n** Das Passwort muss mindestens 1 Sonderzeichen enthalten\n** Das Passwort muss mindestens eine Zahl enthalten\n** Das Passwort muss mindestens einen Großbuchstaben enthalten\n\n"#DIALOGGRAY"Bitte merke dir dein Passwort.", "Weiter", "Abbrechen");

        }
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    return 1;
}


forward UpdateServerClock();

public UpdateServerClock()
{
    UpdateClockTextdraw();
    ServerMinute += 1;

    // Wenn 60 Minuten erreicht, zur nchsten Stunde
    if (ServerMinute >= 60)
    {
        ServerMinute = 0;
        ServerHour += 1;

        // Nach 24 Uhr wieder zu 0 Uhr
        if (ServerHour >= 24)
        {
            ServerHour = 0;
        }

        // Spielzeit fr alle Spieler aktualisieren
        SetWorldTime(ServerHour);

        // Tag/Nacht-Zyklus aktualisieren
        UpdateDayNightCycle();
    }
    return 1;
}

stock UpdateClockTextdraw()
{
    new string[16];
    format(string, sizeof(string), "%02d:%02d", ServerHour, ServerMinute);
    TextDrawSetString(ServerClock, string);
    return 1;  //
}

stock MySQSL_Connection(ttl = 3)
{
    print("[MySQL] Verbindungsaufbau...");
    mysql_log(ALL);

    mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB);

    if (mysql_errno(mysql) != 0)
    {
        if (ttl > 1)
        {
            print("[MySQL] Es konnte keine Verbindung zur Datenbank hergestellt werden.");
            printf("[MySQL] Starte neuen Verbindungsversuch (TTL: %d).", ttl - 1);
            return MySQSL_Connection(ttl - 1);
        }
        else
        {
            print("[MySQL] Es konnte keine Verbindung zur Datenbank hergestellt werden.");
            print("[MySQL] Bitte prfen Sie die Verbindungsdaten.");
            print("[MySQL] Der Server wird heruntergefahren.");
            return SendRconCommand("exit");
        }
    }
    printf("[MySQL] Die Verbindung zur Datenbank wurde erfolgreich hergestellt! Handle: %d", _:mysql);
    return 1;
}

stock CreateClockTD()
{
    ServerClock = TextDrawCreate(53.000000, 313.000000, "20:00");
    TextDrawFont(ServerClock, 2);
    TextDrawLetterSize(ServerClock, 0.262500, 1.450000);
    TextDrawTextSize(ServerClock, 400.000000, 17.000000);
    TextDrawSetOutline(ServerClock, 1);
    TextDrawSetShadow(ServerClock, 0);
    TextDrawAlignment(ServerClock, 1);
    TextDrawColor(ServerClock, 0x4682B4FF);
    TextDrawBackgroundColor(ServerClock, 255);
    TextDrawBoxColor(ServerClock, 50);
    TextDrawUseBox(ServerClock, 0);
    TextDrawSetProportional(ServerClock, 1);
    TextDrawSetSelectable(ServerClock, 0);
    return 1;
}
stock UpdateDayNightCycle()
{
    new weather;

    // Nacht (0-5 Uhr) - Dunkel
    if (ServerHour >= 0 && ServerHour < 5)
    {
        weather = 1; // Klare Nacht
    }
    // Morgendmmerung (5-7 Uhr) - Wird hell
    else if (ServerHour >= 5 && ServerHour < 7)
    {
        weather = 2; // Neblig/Dmmerung
    }
    // Morgen (7-11 Uhr) - Hell
    else if (ServerHour >= 7 && ServerHour < 11)
    {
        weather = 10; // Sonnig
    }
    // Mittag (11-15 Uhr) - Sehr hell
    else if (ServerHour >= 11 && ServerHour < 15)
    {
        weather = 17; // Hochsommer, sehr hell
    }
    // Nachmittag (15-18 Uhr) - Noch hell
    else if (ServerHour >= 15 && ServerHour < 18)
    {
        weather = 10; // Sonnig
    }
    // Abenddmmerung (18-20 Uhr) - Wird dunkel
    else if (ServerHour >= 18 && ServerHour < 20)
    {
        weather = 33; // Orange Himmel/Dmmerung
    }
    // Abend/Nacht (20-24 Uhr) - Dunkel
    else
    {
        weather = 1; // Klare Nacht
    }

    SetWeather(weather);

    return 1;
}
stock GetServerZeit(&h, &m)
{
    h = ServerHour;
    m = ServerMinute;
    return 1;
}


stock MySQL_SavePlayer(playerid)
{
    if (player[playerid][p_id] == 0) return 0;
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    player[playerid][pPosX] = x;
    player[playerid][pPosY] = y;
    player[playerid][pPosZ] = z;
    player[playerid][pPosA] = a;
    player[playerid][pInterior] = GetPlayerInterior(playerid);
    player[playerid][pVirtualW] = GetPlayerVirtualWorld(playerid);
    player[playerid][pSkin] = GetPlayerSkin(playerid);
    new buf[1000];
    mysql_format(mysql, buf, sizeof(buf), "UPDATE players SET level = %d, money = %d, kills = %d, deaths = %d, admin = %d, posx = %f, posy = %f, posz = %f, posa = %f, interior = %d, virtualw = %d, skin = %d WHERE name = '%e'", player[playerid][pLevel], player[playerid][pMoney], player[playerid][pKills], player[playerid][pDeaths], player[playerid][pAdmin], player[playerid][pPosX], player[playerid][pPosY], player[playerid][pPosZ], player[playerid][pPosA], player[playerid][pInterior], player[playerid][pVirtualW], player[playerid][pSkin], player[playerid][pName]);
    mysql_tquery(mysql, buf);
    print(buf);
    return 1;
}

stock MySQL_LoadPlayer(playerid)
{
    new buff[128];
    cache_get_value_name_int(0, "ID", player[playerid][p_id]);
    cache_get_value_name_int(0, "level", player[playerid][pLevel]);
    cache_get_value_name_int(0, "money", player[playerid][pMoney]);
    cache_get_value_name_int(0, "kills", player[playerid][pKills]);
    cache_get_value_name_int(0, "deaths", player[playerid][pDeaths]);
    cache_get_value_name_int(0, "admin", player[playerid][pAdmin]);
    cache_get_value_name_float(0, "posx", player[playerid][pPosX]);
    cache_get_value_name_float(0, "posy", player[playerid][pPosY]);
    cache_get_value_name_float(0, "posz", player[playerid][pPosZ]);
    cache_get_value_name_float(0, "posa", player[playerid][pPosA]);
    cache_get_value_name_int(0, "interior", player[playerid][pInterior]);
    cache_get_value_name_int(0, "virtualw", player[playerid][pVirtualW]);
    cache_get_value_name_int(0, "skin", player[playerid][pSkin]);
    player[playerid][pLoggedIn]  = true;
    GivePlayerMoney(playerid, player[playerid][pMoney]);

    if (player[playerid][pPosX] == 0.0 && player[playerid][pPosY] == 0.0 && player[playerid][pPosZ] == 0.0)
    {

        TogglePlayerSpectating(playerid, 0);
        SpawnPlayer(playerid);
        SetPlayerPos(playerid, 253.6335, -303.2893, 1.5781); // Beispiel-Koordinaten
        SetPlayerFacingAngle(playerid, 168.2152);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerSkin(playerid, player[playerid][pSkin]);
    }
    else
    {

        TogglePlayerSpectating(playerid, 0);
        SpawnPlayer(playerid);
        SetPlayerPos(playerid, player[playerid][pPosX], player[playerid][pPosY], player[playerid][pPosZ]);
        SetPlayerFacingAngle(playerid, player[playerid][pPosA]);
        SetPlayerInterior(playerid, player[playerid][pInterior]);
        SetPlayerVirtualWorld(playerid, player[playerid][pVirtualW]);
        SetPlayerSkin(playerid, player[playerid][pSkin])
    }
    for (new i = 0; i < 100; i++)
    {
        SendClientMessage(playerid, -1, "");
    }
    format(buff, sizeof(buff), "Herzlich willkommen zurück, %s!", player[playerid][pName]);
    SendClientMessage(playerid, SAMP_COLOR, buff);
    SendClientMessage(playerid, SAMP_COLOR, "Wir freuen uns, dich auf auf Neverland e-Life begrüßen zu dürfen.");
    SendClientMessage(playerid, SAMP_COLOR, "Viel Spaß!");
    switch (player[playerid][pAdmin])
    {
        case 1:
        {
            SendClientMessage(playerid, 0xAA3333AA, "Admin: Du bist als Supporter angemeldet.");
            return 1;
        }
        case 2:
        {
            SendClientMessage(playerid, 0xAA3333AA, "Admin: Du bist als Administrator Level 1 angemeldet.");
            return 1;
        }
        case 3:
        {
            SendClientMessage(playerid, 0xAA3333AA, "Admin: Du bist als Administrator Level 2 angemeldet.");
            return 1;
        }
        case 1337:
        {
            SendClientMessage(playerid, 0xAA3333AA, "Admin: Du bist als Administrator Level 1337 angemeldet.");
            return 1;
        }
    }

    return 1;
}

stock StartLoginCamera(playerid)
{
    TogglePlayerSpectating(playerid, 1);
    SetPlayerCameraPos(playerid, 1450.2847, 380.4921, 65.8906);
    SetPlayerCameraLookAt(playerid, 1200.5847, 180.2314, 19.5);

    InterpolateCameraPos(playerid, 1450.2847, 380.4921, 65.8906, 1320.6483, 280.1937, 45.7422, 25000);
    InterpolateCameraLookAt(playerid, 1200.5847, 180.2314, 19.5, 1180.3694, 160.8426, 20.5, 25000);

    return 1;
}

stock StopLoginCamera(playerid)
{
    PlayerInLoginCam[playerid] = false;
    TogglePlayerSpectating(playerid, 0);
    return 1;
}

stock IsPasswordValid(const password[])
{
    new len = strlen(password);

    // Mindestens 8 Zeichen
    if (len < 8)
        return 0;

    new hasUpper = 0, hasNumber = 0, hasSpecial = 0;

    for (new i = 0; i < len; i++)
    {
        if (password[i] >= 'A' && password[i] <= 'Z')
            hasUpper = 1;
        else if (password[i] >= '0' && password[i] <= '9')
            hasNumber = 1;
        else if (password[i] == '!' || password[i] == '@' || password[i] == '#' ||
                 password[i] == '$' || password[i] == '%' || password[i] == '&' ||
                 password[i] == '*' || password[i] == '?' || password[i] == '_' ||
                 password[i] == '-' || password[i] == '+' || password[i] == '=')
            hasSpecial = 1;
    }

    return (hasUpper && hasNumber && hasSpecial);
}

// Befehl zum Anzeigen der Zeit
CMD:zeit(playerid, params[])
{
    new string[128];
    new tageszeit[32];

    // Tageszeit bestimmen
    if (ServerHour >= 0 && ServerHour < 6) tageszeit = "Nacht";
    else if (ServerHour >= 6 && ServerHour < 12) tageszeit = "Morgen";
    else if (ServerHour >= 12 && ServerHour < 18) tageszeit = "Nachmittag";
    else if (ServerHour >= 18 && ServerHour < 22) tageszeit = "Abend";
    else tageszeit = "Nacht";

    format(string, sizeof(string), "Serverzeit: %02d:%02d Uhr (%s)", ServerHour, ServerMinute, tageszeit);
    SendClientMessage(playerid, 0xFFFFFFFF, string);
    return 1;
}



CMD:me(playerid, params[])
{
    if (isnull(params))
        return SendClientMessage(playerid, 0xFF0000FF, "Verwendung: /me [Aktion]");

    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new len = strlen(params);

    if (len <= MAX_LINE_LENGTH)
    {
        new string[144];
        format(string, sizeof(string), "* %s %s", name, params);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, TALK_RADIUS, x, y, z))
            {
                SendClientMessage(i, COLOR_ME, string);
            }
        }
    }
    else
    {
        new part1[80], part2[80];
        new splitPos = MAX_LINE_LENGTH;

        for (new i = MAX_LINE_LENGTH - 1; i > 0; i--)
        {
            if (params[i] == ' ')
            {
                splitPos = i;
                break;
            }
        }

        for (new i = 0; i < splitPos; i++)
        {
            part1[i] = params[i];
        }
        part1[splitPos] = 0;

        new pos = 0;
        for (new i = splitPos + 1; i < len; i++)
        {
            part2[pos] = params[i];
            pos++;
        }
        part2[pos] = 0;

        new string[144];
        format(string, sizeof(string), "* %s %s", name, part1);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, TALK_RADIUS, x, y, z))
            {
                SendClientMessage(i, COLOR_ME, string);

                format(string, sizeof(string), "* ... %s", part2);
                SendClientMessage(i, COLOR_ME, string);
            }
        }
    }

    return 1;
}

// ============================================================================
// /DO BEFEHL
// ============================================================================

CMD:do(playerid, params[])
{
    if (isnull(params))
        return SendClientMessage(playerid, 0xFF0000FF, "Verwendung: /do [Beschreibung]");

    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new len = strlen(params);

    if (len <= MAX_LINE_LENGTH)
    {
        new string[144];
        format(string, sizeof(string), "* %s (( %s ))", params, name);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, TALK_RADIUS, x, y, z))
            {
                SendClientMessage(i, COLOR_DO, string);
            }
        }
    }
    else
    {
        new part1[80], part2[80];
        new splitPos = MAX_LINE_LENGTH;

        for (new i = MAX_LINE_LENGTH - 1; i > 0; i--)
        {
            if (params[i] == ' ')
            {
                splitPos = i;
                break;
            }
        }

        for (new i = 0; i < splitPos; i++)
        {
            part1[i] = params[i];
        }
        part1[splitPos] = 0;

        new pos = 0;
        for (new i = splitPos + 1; i < len; i++)
        {
            part2[pos] = params[i];
            pos++;
        }
        part2[pos] = 0;

        new string[144];
        format(string, sizeof(string), "* %s", part1);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, TALK_RADIUS, x, y, z))
            {
                SendClientMessage(i, COLOR_DO, string);

                format(string, sizeof(string), "* ... %s (( %s ))", part2, name);
                SendClientMessage(i, COLOR_DO, string);
            }
        }
    }

    return 1;
}


stock GetVehicleName(vehicleid)
{
    new vehiclename[32];

    // Überprüfen ob das Fahrzeug existiert


    new modelid = GetVehicleModel(vehicleid);
    format(vehiclename, sizeof(vehiclename), "%s", VehicleNames[modelid - 400]);
    return vehiclename;
}


/* ------------------ USER COMMANDS ----------------------- */


CMD:motor(playerid, params[])
{
    new vid = GetPlayerVehicleID(playerid);
    new buf[128];
    if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GRAY, "   Du bist in keinem Fahrzeug.");
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_GRAY, "    Du bist nicht der Fahrer dieses Fahrzeugs.");

    new e, l, a, d, b, boot, o;
    GetVehicleParamsEx(vid, e, l, a, d, b, boot, o);
    if (e == 1)
    {
        SetVehicleParamsEx(vid, 0, 0, a, d, b, boot, o);
        format(buf, sizeof(buf), "Du hast den Motor deiner/deines %s ausgemacht.", GetVehicleName(vid));
        SendClientMessage(playerid, COLOR_GRAY, buf);
        SendMeMessage(playerid, "dreht den Zündschlüssel und schaltet den Motor aus.");
    }
    else
    {
        SetVehicleParamsEx(vid, 1, 1, a, d, b, boot, o);
        format(buf, sizeof(buf), "Du hast den Motor deiner/deines %s gestartet.", GetVehicleName(vid));
        SendClientMessage(playerid, COLOR_GRAY, buf);
        SendMeMessage(playerid, "dreht den Zündschlüssel und startet den Motor.");
    }
    return 1;
}



CMD:buyhouse(playerid, params[])
{
    new bool:nearHouse = false;

    for (new i = 0; i < sizeof(HouseInfo); i++)
    {
        if (!HouseInfo[i][hID]) continue;
        if (!IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[i][hEnterX], HouseInfo[i][hEnterY], HouseInfo[i][hEnterZ])) continue;
        nearHouse = true;
        if (!strlen(HouseInfo[i][hOwner]))
        {
            if (GetPlayerMoney(playerid) < HouseInfo[i][hPrice]) return SendClientMessage(playerid, COLOR_GRAY, "   Du hast nix money");
            //hier money abzeiehen;
            strmid(HouseInfo[i][hOwner], player[playerid][pName], 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
            UpdateHouse(i);
            SaveHouse(i);
            SendClientMessage(playerid, -1, "Haus gekauft");
            return 1;
        }
        return SendClientMessage(playerid, COLOR_GRAY, "    Dieses Haus steht nicht zum Verkauf.");
    }

    if (!nearHouse) return SendClientMessage(playerid, -1, "Da ist kein Haus");

    return 1;
}

CMD:sellhouse(playerid, params[])
{
    new bool:nearHouse = false;

    for (new i = 0; i < sizeof(HouseInfo); i++)
    {
        if (!HouseInfo[i][hID]) continue;
        if (!IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[i][hEnterX], HouseInfo[i][hEnterY], HouseInfo[i][hEnterZ])) continue;

        nearHouse = true;

        if (!strlen(HouseInfo[i][hOwner])) continue;

        if (!strcmp(HouseInfo[i][hOwner], player[playerid][pName], true))
        {
            GivePlayerMoney(playerid, HouseInfo[i][hPrice] / 2);
            strmid(HouseInfo[i][hOwner], "", 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
            UpdateHouse(i);
            SaveHouse(i);
            SendClientMessage(playerid, -1, "Haus verkauft");
            return 1;
        }
        else
        {
            return SendClientMessage(playerid, COLOR_GRAY, "    Das Haus gehört nicht dir.");
        }
    }

    if (!nearHouse) return SendClientMessage(playerid, -1, "Da ist kein Haus");
    return 1;
}


/* ------------------ ADMIN COMMANDS ---------------------- */





CMD:createhouse(playerid, params[])
{
    if (player[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_GRAY, "   Du bist nicht berrechtigt diesen Befehl zu nutzen.");
    new Float:pos[3];
    GetPlayerPos(playerid, pos[0], pos[1], pos[2]);

    new houseid = getFreeHouseID();

    HouseInfo[houseid][hEnterX] = pos[0];
    HouseInfo[houseid][hEnterY] = pos[1];
    HouseInfo[houseid][hEnterZ] = pos[2];
    HouseInfo[houseid][hExitX] = 0.0;
    HouseInfo[houseid][hExitY] = 0.0;
    HouseInfo[houseid][hExitZ] = 0.0;
    HouseInfo[houseid][hInterior] = 0;
    HouseInfo[houseid][hPrice] = 1;
    strmid(HouseInfo[houseid][hOwner], "", MAX_PLAYER_NAME, MAX_PLAYER_NAME);
    new query[300];

    mysql_format(mysql, query, sizeof(query), "INSERT INTO houses (owner, enter_x, enter_y, enter_z, exit_x, exit_y, exit_z, interior, price) VALUES ('%e', %f, %f, %f, 0.0, 0.0, 0.0, 0, 1)", HouseInfo[houseid][hOwner], pos[0], pos[1], pos[2]);

    mysql_pquery(mysql, query, "OnHouseCreated", "i", houseid);
    UpdateHouse(houseid);

    new buf[128];
    format(buf, sizeof(buf), "House ID %d wurde erstellt", houseid);
    SendClientMessage(playerid, -1, buf);

    return 1;
}


public OnHouseCreated(houseid)
{
    HouseInfo[houseid][hID] = cache_insert_id();
    return 1;
}

CMD:givemoney(playerid, params[])
{
    new targetid, amount;
    if (player[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_GRAY, "   Du bist nicht berrechtigt diesen Befehl zu nutzen.");
    if (sscanf(params, "ud", targetid, amount)) return SendClientMessage(playerid, COLOR_GRAY, "BENUTZUNG: /givemoney [ID/Name] [Betrag]");
    GivePlayerMoney(targetid, amount);
    return 1;
}

CMD:cveh(playerid, params[])
{
    new vid, c1, c2, model;
    new Float:x, Float:y, Float:z;
    new buf[128];
    if (player[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_GRAY, "   Du bist nicht berrechtigt diesen Befehl zu nutzen.");
    if (sscanf(params, "ddd", model, c1, c2)) return SendClientMessage(playerid, COLOR_GRAY, "BENUTZUNG: /cveh [Model-ID] [Farbe] [Farbe]");
    if (model < 400 || model > 611) return SendClientMessage(playerid, COLOR_GRAY, "   Du hast eine ungültige Model-ID eingegeben.");
    GetPlayerPos(playerid, x, y, z);
    vid = CreateVehicle(model, x, y, z + 2.0, 0.0, c1, c2, -1, -1);
    PutPlayerInVehicle(playerid, vid, 0);
    format(buf, sizeof(buf), "   Du hast erfolgreich ein Fahrzeug erstellt: {A9C4E4}%s", GetVehicleName(vid));
    SendClientMessage(playerid, COLOR_GRAY, buf);
    return 1;
}

CMD:sethp(playerid, params[])
{
    new targetid, Float:health, buf[128];
    if (player[playerid][pAdmin] < 1) return SendClientMessage(playerid, COLOR_GRAY, "   Du bist nicht berrechtigt diesen Befehl zu nutzen.");
    if (sscanf(params, "uf", targetid, health)) return SendClientMessage(playerid, COLOR_GRAY, "BENUTZUNG: /sethp [ID/Name] [HP]");
    if (!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GRAY, "   Der Spieler ist nicht mit dem Server verbunden.");
    SetPlayerHealth(targetid, health);
    format(buf, sizeof(buf), "   Du hast das Leben von %s gesetzt: {A9C4E4}%.1f", player[targetid][pName], health);
    SendClientMessage(playerid, COLOR_GRAY, buf);
    return 1;
}

CMD:restart(playerid, params[])
{
    if (player[playerid][pAdmin] < 1337) return SendClientMessage(playerid, COLOR_GRAY, "   Du bist nicht berrechtigt diesen Befehl zu nutzen.");
    SendRconCommand("gmx");
    return 1;
}

CMD:nrg(playerid, params[])
{
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    CreateVehicle(522, x + 2, y, z, a, -1, -1, -1);
    SendClientMessage(playerid, -1, "NRG-500 gespawnt!");
    return 1;
}








public MySQLCreatePlayerTable()
{
    mysql_tquery(mysql,
                 "CREATE TABLE IF NOT EXISTS `players` (\
            `ID` INT(11) NOT NULL AUTO_INCREMENT,\
            `name` VARCHAR(24) NOT NULL,\
            `password` VARCHAR(128) NOT NULL DEFAULT '',\
            `otp` VARCHAR(16) NOT NULL DEFAULT '',\
            `FirstLogin` TINYINT(1) NOT NULL DEFAULT 1,\
            `level` INT(11) NOT NULL DEFAULT 1,\
            `money` INT(11) NOT NULL DEFAULT 500,\
            `kills` INT(11) NOT NULL DEFAULT 0,\
            `deaths` INT(11) NOT NULL DEFAULT 0,\
            `admin` INT(11) NOT NULL DEFAULT 0,\
            `posx` FLOAT NOT NULL DEFAULT 0.0,\
            `posy` FLOAT NOT NULL DEFAULT 0.0,\
            `posz` FLOAT NOT NULL DEFAULT 0.0,\
            `posa` FLOAT NOT NULL DEFAULT 0.0,\
            `interior` INT(11) NOT NULL DEFAULT 0,\
            `virtualw` INT(11) NOT NULL DEFAULT 0,\
            `skin` INT(11) NOT NULL DEFAULT 0,\
            PRIMARY KEY (`ID`),\
            UNIQUE KEY `name` (`name`)\
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;"
                );

    print("[MySQL] Spieler-Tabelle wurde ueberprueft/erstellt.");
}


public CreateHouseTable()
{
    new query[1024];
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
}

stock CreateBusinessTable()
{
    mysql_tquery(mysql, "CREATE TABLE IF NOT EXISTS businesses (\
        id INT AUTO_INCREMENT PRIMARY KEY,\
        name VARCHAR(24),\
        purchaseable TINYINT(1) DEFAULT 1,\
        price INT DEFAULT 0,\
        owner VARCHAR(24) DEFAULT 'Niemand',\
        coowner VARCHAR(24) DEFAULT 'Niemand',\
        interior INT DEFAULT 0,\
        world INT DEFAULT 0,\
        enter_x FLOAT DEFAULT 0.0,\
        enter_y FLOAT DEFAULT 0.0,\
        enter_z FLOAT DEFAULT 0.0,\
        exit_x FLOAT DEFAULT 0.0,\
        exit_y FLOAT DEFAULT 0.0,\
        exit_z FLOAT DEFAULT 0.0,\
        pickup INT DEFAULT 1274,\
        label VARCHAR(50) DEFAULT 'Business',\
        open TINYINT(1) DEFAULT 1,\
        opening_hours VARCHAR(20) DEFAULT '00:00-23:59',\
        money INT DEFAULT 0\
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;", "", "");

    print("[MySQL] Business-Tabelle wurde erstellt/überprüft.");
    return 1;
}


public LoadBizz()
{
    mysql_pquery(mysql, "SELECT * FROM businesses", "OnBizLoaded");
    return 1;
}




public OnBizLoaded()
{
    new r;
    new buf[600];
    new text[250];
    cache_get_row_count(r);
    if (!r) print("MySQL: Keine Businesses zum laden");

    for (new i = 0; i < r; i++)
    {
        new id = getFreeBizID();
        cache_get_value_name_int(i, "id", BizInfo[id][bID]);
        cache_get_value_name_int(i, "purchaseable", BizInfo[id][bPurchaseable]);
        cache_get_value_name_int(i, "price", BizInfo[id][bPrice]);
        cache_get_value_name_int(i, "interior", BizInfo[id][bInterior]);
        cache_get_value_name_int(i, "world", BizInfo[id][bWorld]);
        cache_get_value_name_int(i, "open", BizInfo[id][bOpen]);
        cache_get_value_name_int(i, "money", BizInfo[id][bMoney]);
        cache_get_value_name(i, "name", BizInfo[id][bName], 30);
        cache_get_value_name(i, "address", BizInfo[id][bAddress], 30);
        cache_get_value_name(i, "owner", BizInfo[i][bOwner], MAX_PLAYER_NAME);
        cache_get_value_name(i, "coowner", BizInfo[id][bCoOwner], MAX_PLAYER_NAME);
        cache_get_value_name(i, "opening_hours", BizInfo[id][bOpeningHours], 20);
        cache_get_value_name_float(i, "enter_x", BizInfo[id][bEnterX]);
        cache_get_value_name_float(i, "enter_y", BizInfo[id][bEnterY]);
        cache_get_value_name_float(i, "enter_z", BizInfo[id][bEnterZ]);
        cache_get_value_name_float(i, "exit_x", BizInfo[id][bExitX]);
        cache_get_value_name_float(i, "exit_y", BizInfo[id][bExitY]);
        cache_get_value_name_float(i, "exit_z", BizInfo[id][bExitZ]);
        if (!strlen(BizInfo[id][bOwner]))
        {
            if (BizInfo[id][bPurchaseable] == 1)
            {
                CreateDynamicObject(19470, BizInfo[id][bEnterX], BizInfo[id][bEnterY], BizInfo[id][bEnterZ] - 0.5, 0.0, 0.0, 360);
                BizInfo[id][bPickup] = CreatePickup(1272, 1, BizInfo[id][bEnterX], BizInfo[id][bEnterY], BizInfo[id][bEnterZ], 0);
                format(text, sizeof(text), "{A9C4E4}--- %s ---\n%s\n>>> ZU VERKAUFEN <<<\n{6e86ff}Kaufpreis: {FFFFFF}$%s\n\nKaufen mit '{6e86ff}/buybiz{FFFFFF}'", BizInfo[id][bName], BizInfo[id][bAddress], FormatNumber(BizInfo[id][bPrice]));
                BizInfo[id][bLabel] = Create3DTextLabel(text, -1, BizInfo[id][bEnterX], BizInfo[id][bEnterY], BizInfo[id][bEnterZ], 6.0, 0, 0);
            }
            else
            {
                BizInfo[id][bPickup] = CreatePickup(19524, 1, BizInfo[id][bEnterX], BizInfo[id][bEnterY], BizInfo[id][bEnterZ], 0);
            }
        }
        else if (strcmp(BizInfo[id][bOwner], "Staat", true) == 0)
        {
            BizInfo[id][bPickup] = CreatePickup(1272, 1, BizInfo[id][bEnterX], BizInfo[id][bEnterY], BizInfo[id][bEnterZ], 0);
            format(text, sizeof(text), "{ffa273}--- %s ---\nAdresse: {FFFFFF}Dillimore 1\n{ff726e}Besitzer: {FFFFFF}STAAT\n{ff726e}Kasse: {FFFFFF}$%d\n\nBetreten mit '{ff726e}ENTER{FFFFFF}'", BizInfo[id][bName], BizInfo[id][bMoney]);

            BizInfo[id][bLabel] = Create3DTextLabel(text, -1, BizInfo[id][bEnterX], BizInfo[id][bEnterY], BizInfo[id][bEnterZ], 6.0, 0, 0);
        }
        else
        {
            BizInfo[id][bPickup] = CreatePickup(1272, 1, BizInfo[id][bEnterX], BizInfo[id][bEnterY], BizInfo[id][bEnterZ], 0);
            format(text, sizeof(text), "** %s **\n\nInhaber: %s\nTeilinhaber: %s\nKasse: %d\nGeschäftszeiten: %s\n\nBetreten mit 'ENTER'", BizInfo[i][bName], BizInfo[i][bOwner], BizInfo[id][bCoOwner], BizInfo[id][bMoney], BizInfo[id][bOpeningHours]);
            BizInfo[id][bLabel] = Create3DTextLabel(text, -1, BizInfo[id][bEnterX], BizInfo[id][bEnterY], BizInfo[id][bEnterZ], 3.0, 0, 0);
        }
    }
    return 1;
}

stock getFreeBizID()
{
    for (new i = 0; i < sizeof(BizInfo); i++)
    {
        if (BizInfo[i][bID] == 0) return i;
    }
    return 1;
}

public MySQLLoadHouses()
{
    mysql_tquery(mysql, "SELECT * FROM houses ORDER BY id ASC", "OnHousesLoaded", "");
    return 1;
}


public SaveHouse(id)
{
    if (id < 0 || id >= MAX_HOUSES) return 0;
    if (HouseInfo[id][hID] == 0) return 0; // Haus existiert nicht

    new query[1024];

    mysql_format(mysql, query, sizeof(query),
                 "UPDATE houses SET \
        owner='%e', \
        address='%e', \
        price=%d, \
        interior=%d, \
        world=%d, \
        enter_x=%f, \
        enter_y=%f, \
        enter_z=%f, \
        exit_x=%f, \
        exit_y=%f, \
        exit_z=%f, \
        locked=%d, \
        rentable=%d, \
        rent_price=%d, \
        safe_money=%d, \
        safe_drugs=%d, \
        safe_weapon1=%d, \
        safe_weapon2=%d, \
        safe_weapon3=%d, \
        safe_weapon4=%d, \
        safe_weapon5=%d, \
        safe_ammo1=%d, \
        safe_ammo2=%d, \
        safe_ammo3=%d, \
        safe_ammo4=%d, \
        safe_ammo5=%d \
        WHERE id=%d",
                 HouseInfo[id][hOwner],
                 HouseInfo[id][hAddress],
                 HouseInfo[id][hPrice],
                 HouseInfo[id][hInterior],
                 HouseInfo[id][hWorld],
                 HouseInfo[id][hEnterX],
                 HouseInfo[id][hEnterY],
                 HouseInfo[id][hEnterZ],
                 HouseInfo[id][hExitX],
                 HouseInfo[id][hExitY],
                 HouseInfo[id][hExitZ],
                 HouseInfo[id][hLocked],
                 HouseInfo[id][hRentable],
                 HouseInfo[id][hRentPrice],
                 HouseInfo[id][hSafeMoney],
                 HouseInfo[id][hSafeDrugs],
                 HouseInfo[id][hSafeWeapons][0],
                 HouseInfo[id][hSafeWeapons][1],
                 HouseInfo[id][hSafeWeapons][2],
                 HouseInfo[id][hSafeWeapons][3],
                 HouseInfo[id][hSafeWeapons][4],
                 HouseInfo[id][hSafeAmmo][0],
                 HouseInfo[id][hSafeAmmo][1],
                 HouseInfo[id][hSafeAmmo][2],
                 HouseInfo[id][hSafeAmmo][3],
                 HouseInfo[id][hSafeAmmo][4],
                 HouseInfo[id][hID]
                );

    mysql_pquery(mysql, query);
    return 1;
}

public OnHousesLoaded()
{
    new rows;
    new buff[200];
    cache_get_row_count(rows);
    if (rows > 0)
    {
        for (new i = 0; i < rows; i++)
        {
            new houseid = getFreeHouseID();
            cache_get_value_name_int(i, "id", HouseInfo[houseid][hID]);
            cache_get_value_name(i, "owner", HouseInfo[houseid][hOwner], 24);
            cache_get_value_name(i, "address", HouseInfo[houseid][hAddress], 40);
            cache_get_value_name_int(i, "price", HouseInfo[houseid][hPrice]);
            cache_get_value_name_int(i, "interior", HouseInfo[houseid][hInterior]);
            cache_get_value_name_int(i, "world", HouseInfo[houseid][hWorld]);
            cache_get_value_name_float(i, "enter_x", HouseInfo[houseid][hEnterX]);
            cache_get_value_name_float(i, "enter_y", HouseInfo[houseid][hEnterY]);
            cache_get_value_name_float(i, "enter_z", HouseInfo[houseid][hEnterZ]);
            cache_get_value_name_float(i, "exit_x", HouseInfo[houseid][hExitX]);
            cache_get_value_name_float(i, "exit_y", HouseInfo[houseid][hExitY]);
            cache_get_value_name_float(i, "exit_z", HouseInfo[houseid][hExitZ]);
            cache_get_value_name_int(i, "locked", HouseInfo[houseid][hLocked]);
            cache_get_value_name_int(i, "rentable", HouseInfo[houseid][hRentable]);
            cache_get_value_name_int(i, "rent_price", HouseInfo[houseid][hRentPrice]);
            cache_get_value_name_int(i, "safe_money", HouseInfo[houseid][hSafeMoney]);
            cache_get_value_name_int(i, "safe_drugs", HouseInfo[houseid][hSafeDrugs]);
            cache_get_value_name_int(i, "safe_weapon1", HouseInfo[houseid][hSafeWeapons][0]);
            cache_get_value_name_int(i, "safe_weapon2", HouseInfo[houseid][hSafeWeapons][1]);
            cache_get_value_name_int(i, "safe_weapon3", HouseInfo[houseid][hSafeWeapons][2]);
            cache_get_value_name_int(i, "safe_weapon4", HouseInfo[houseid][hSafeWeapons][3]);
            cache_get_value_name_int(i, "safe_weapon5", HouseInfo[houseid][hSafeWeapons][4]);
            cache_get_value_name_int(i, "safe_ammo1", HouseInfo[houseid][hSafeAmmo][0]);
            cache_get_value_name_int(i, "safe_ammo2", HouseInfo[houseid][hSafeAmmo][1]);
            cache_get_value_name_int(i, "safe_ammo3", HouseInfo[houseid][hSafeAmmo][2]);
            cache_get_value_name_int(i, "safe_ammo4", HouseInfo[houseid][hSafeAmmo][3]);
            cache_get_value_name_int(i, "safe_ammo5", HouseInfo[houseid][hSafeAmmo][4]);
            UpdateHouse(houseid);

        }

        printf("[MySQL] %d Häuser wurden erfolgreich geladen.", rows);
    }
    else
    {
        print("[MySQL] Keine Häuser in der Datenbank gefunden.");
    }
    return 1;
}

stock getFreeHouseID()
{
    for (new i = 0; i < sizeof(HouseInfo); i++)
    {
        if (HouseInfo[i][hID] == 0) return i;
    }
    return 1;
}

stock UpdateHouse(houseid)
{
    new buff[128];

    if (HouseInfo[houseid][hPickup])
    {
        DestroyPickup(HouseInfo[houseid][hPickup]);
    }
    if (HouseInfo[houseid][hText])
    {
        Delete3DTextLabel(HouseInfo[houseid][hText]);
    }

    if (!strlen(HouseInfo[houseid][hOwner]))
    {
        HouseInfo[houseid][hPickup] = CreatePickup(PICKUP_FORSALE, 1, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ], -1);
        format(buff, sizeof(buff), "{A9C4E4}>>> ZU VERKAUFEN <<<\nHaus {FFFFFF}%s\n{A9C4E4}Kaufpreis: {FFFFFF}$%s", HouseInfo[houseid][hAddress], FormatNumber(HouseInfo[houseid][hPrice]));
        HouseInfo[houseid][hText] = Create3DTextLabel(buff, -1, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ], 6.0, 0, 1);
    }
    else
    {
        format(buff, sizeof(buff), "{A9C4E4}Haus {FFFFFF}%s", HouseInfo[houseid][hAddress]);
        HouseInfo[houseid][hPickup] = CreatePickup(PICKUP_SOLD, 1, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ], -1);
        HouseInfo[houseid][hText] = Create3DTextLabel(buff, -1, HouseInfo[houseid][hEnterX], HouseInfo[houseid][hEnterY], HouseInfo[houseid][hEnterZ], 6.0, 0, 1);
    }
    return 1;
}

stock SendMeMessage(playerid, const text[])
{
    if (isnull(text)) return 0;

    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new len = strlen(text);

    if (len <= MAX_LINE_LENGTH)
    {
        new string[144];
        format(string, sizeof(string), "* %s %s", name, text);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, TALK_RADIUS, x, y, z))
            {
                SendClientMessage(i, COLOR_ME, string);
            }
        }
    }
    else
    {
        new part1[80], part2[80];
        new splitPos = MAX_LINE_LENGTH;

        // Finde letztes Leerzeichen vor MAX_LINE_LENGTH
        for (new i = MAX_LINE_LENGTH - 1; i > 0; i--)
        {
            if (text[i] == ' ')
            {
                splitPos = i;
                break;
            }
        }

        // Ersten Teil kopieren
        for (new i = 0; i < splitPos; i++)
        {
            part1[i] = text[i];
        }
        part1[splitPos] = 0;

        // Zweiten Teil kopieren
        new pos = 0;
        for (new i = splitPos + 1; i < len; i++)
        {
            part2[pos] = text[i];
            pos++;
        }
        part2[pos] = 0;

        // Nachricht an Spieler in Reichweite senden
        new string[144];
        format(string, sizeof(string), "* %s %s", name, part1);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && IsPlayerInRangeOfPoint(i, TALK_RADIUS, x, y, z))
            {
                SendClientMessage(i, COLOR_ME, string);
                format(string, sizeof(string), "* ... %s", part2);
                SendClientMessage(i, COLOR_ME, string);
            }
        }
    }

    return 1;
}

// Funktion um Zahlen zu formatieren (100000 -> 100.000)
stock FormatNumber(number)
{
    new string[32], temp[32];
    format(temp, sizeof(temp), "%d", number);

    new len = strlen(temp);
    new pos = 0;
    new count = 0;

    // Von hinten nach vorne durchgehen
    for (new i = len - 1; i >= 0; i--)
    {
        string[pos++] = temp[i];
        count++;

        // Alle 3 Ziffern einen Punkt einfügen
        if (count == 3 && i != 0)
        {
            string[pos++] = '.';
            count = 0;
        }
    }

    // String umkehren (war rückwärts)
    new result[32];
    new resultPos = 0;
    for (new i = pos - 1; i >= 0; i--)
    {
        result[resultPos++] = string[i];
    }

    return result;
}