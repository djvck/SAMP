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
#define COLOR_GRAY         0xFF808080
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
#define COLOR_PURPLE2      0xFF800080
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
#define COLOR_ME           0xFFA500FF
#define COLOR_DO           0xFFA500FF


#define DIALOGGRAY         "{D3D3D3}"
#define DIALOGGREEN        "{90EE90}"


#define SERVERNAME "Neverland e-Life"
#define GAMEVERSION "v0.0.1 ALPHA"
#define GAMEMODE "Reallife"

#define MYSQL_HOST "127.0.0.1"
#define MYSQL_USER "gta"
#define MYSQL_PASSWORD "Hallo123"
#define MYSQL_DB "gta"

new MySQL:mysql;


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
new player[MAX_PLAYERS][pData];


new ServerHour = 0;
new ServerMinute = 0;
new TimerUpdateTime;
new TimerUpdateTextdraw;
new ConnectTimer[MAX_PLAYERS];



new Text:ServerClock;

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
    SendClientMessage(playerid, -1, "{4682B4}INFO{FFFFFF}: Die Spielewelt wird aufgebaut, bitte um etwas Geduld ...");
    SendClientMessage(playerid, -1, "{4682B4}INFO{FFFFFF}: Es wird Überprüft ob du einen Account hast ...");
    if (!player[playerid][pLoggedIn]) ConnectTimer[playerid] = SetTimerEx("ConnectDelay", 10000, false, "i", playerid);
    return 1;
}


forward ConnectDelay(playerid);
public ConnectDelay(playerid)
{
    new buffer[128];
    mysql_format(mysql, buffer, sizeof(buffer), "SELECT id, first_login FROM players WHERE name = '%e'", player[playerid][pName]);
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
        format(buf, sizeof(buf), "{90EE90}Willkommen auf Neverland e-Life.com!\n\n{D3D3D3}Es konnte kein Account unter dem Namen {4682B4}%s{D3D3D3} gefunden werden.\n\nUm auf unserem SA:MP Server spielen zu können, musst du dich zuerst im Forum registrieren.\nNach erfolgreicher Registration im Forum, kannst du einen Spieleraccount erstellen.\nSobald du einen Spieleraccount erstellt hast, kannst du dich\nmit unserem SA:MP Server verbinden und dein neues Abenteuer starten!\n\n{90EE90}Wir wünschen dir viel Spaß und freuen uns dich bald begrüßen zu dürfen!\n\n{4682B4}FORUM: www.neverland-elife.com", player[playerid][pName]);
        ShowPlayerDialog(playerid, DIALOG_NOACC, DIALOG_STYLE_MSGBOX, "Registrierung erforderlich!", buf, "Verstanden", "");
        Kick(playerid);
    }
    else
    {
        cache_get_value_name_int(0, "first_login", player[playerid][pFirstTime]);
        if (!player[playerid][pFirstTime])
        {
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Anmeldung", #DIALOGGRAY"Willkommen zurück!\n\nBitte trage dein Passwort unten in das Eingabefeld ein:\n\n{F88379}INFO: Bitte beachte, dass du 3 Versuche hast das Passwort korrekt einzugeben.", "Ok", "Abbrechen");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_FIRST_LOGIN, DIALOG_STYLE_PASSWORD, "Erste Anmeldung", #DIALOGGRAY"Herzlich Willkommen!\n\nBitte gib das Einmalpasswort ein welches du von einem Administrator erhalten hast:\n\n{F88379}INFO: Im Anschluss wirst du gebeten ein neues Passwort einzugeben.", "Ok", "Abbrechen");
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
    SendClientMessage(playerid, -1, "Herzlich Willkommen auf {4169E1}Neverland e-Life{FFFFFF}. ({4169E1}www.neverland-elife.com{FFFFFF})");
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

        // Kopiere zweiten Teil (�berspringe Leerzeichen)
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
            mysql_format(mysql, buf, sizeof(buf), "SELECT * FROM players WHERE name = '%e' AND password = '%e'", player[playerid][pName], inputtext);
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
                ShowPlayerDialog(playerid, DIALOG_SETPASS, DIALOG_STYLE_PASSWORD, "Neues Passwort", "{FFFFFF}Das von dir eingegebene Passwort entspricht nicht den Mindestanforderungen.\n\nBitte gib ein sicheres Passwort ein:\n\n"#DIALOGGREEN"** Das Passwort muss mindestens 8 Zeichen lang sein\n** Das Passwort muss mindestens 1 Sonderzeichen enthalten\n** Das Passwort muss mindestens eine Zahl enthalten\n\n"#DIALOGGRAY"Bitte merke dir dein Passwort.", "Weiter", "Abbrechen");
                return 1;
            }
            if (!IsPasswordValid(inputtext))
            {

                ShowPlayerDialog(playerid, DIALOG_SETPASS, DIALOG_STYLE_PASSWORD, "Neues Passwort", "{FFFFFF}Das von dir eingegebene Passwort entspricht nicht den Mindestanforderungen.\n\nBitte gib ein sicheres Passwort ein:\n\n"#DIALOGGREEN"** Das Passwort muss mindestens 8 Zeichen lang sein\n** Das Passwort muss mindestens 1 Sonderzeichen enthalten\n** Das Passwort muss mindestens eine Zahl enthalten\n\n"#DIALOGGRAY"Bitte merke dir dein Passwort.", "Weiter", "Abbrechen");
                return 1;
            }
            format(player[playerid][pPassword], 128, "%s", inputtext);
            ShowPlayerDialog(playerid, DIALOG_PASSWORD_CONFIRM, DIALOG_STYLE_PASSWORD, "Neues Passwort", #DIALOGGRAY"Sehr gut! Bitte gib das Passwort, zur Best�tigung, erneut ein:", "Weiter", "Abbrachen");
            return 1;
        }
        case DIALOG_PASSWORD_CONFIRM:
        {
            if (!response) return Kick(playerid);
            if (strcmp(player[playerid][pPassword], inputtext, false))
            {
                ShowPlayerDialog(playerid, DIALOG_PASSWORD_CONFIRM, DIALOG_STYLE_PASSWORD, "Neues Passwort", #DIALOGGRAY"Bitte gib das Passwort, zur Best�tigung, erneut ein:\n\n{FF0000}Die Passw�rter stimmen nicht �berein. Bitte versuche es erneut!", "Weiter", "Abbrachen");
                return 1;
            }
            mysql_format(mysql, buf, sizeof(buf), "UPDATE players SET password = MD5('%e'), first_login = 0 WHERE name = '%e'", player[playerid][pPassword], player[playerid][pName]);
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
            ShowPlayerDialog(playerid, DIALOG_FIRST_LOGIN, DIALOG_STYLE_PASSWORD, "Erste Anmeldung", "{FFFF00}Du hast das falsche Passwort eingegeben!"#DIALOGGRAY"\n\nBitte gib das Einmalpasswort ein welches du von einem Administrator erhalten hast:\n\n{F88379}INFO: Im Anschluss wirst du gebeten ein neues Passwort einzugeben.", "Ok", "Abbrechen");
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
            ShowPlayerDialog(playerid, DIALOG_SETPASS, DIALOG_STYLE_PASSWORD, "Neues Passwort", #DIALOGGRAY"Das Einmalpasswort wurde korrekt eingegeben.\n\nDu kannst nun dein eigenes Passwort vergeben.\n\n"#DIALOGGREEN"** Das Passwort muss mindestens 8 Zeichen lang sein\n** Das Passwort muss mindestens 1 Sonderzeichen enthalten\n** Das Passwort muss mindestens eine Zahl enthalten\n\n"#DIALOGGRAY"Bitte merke dir dein Passwort.", "Weiter", "Abbrechen");

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

    // Wenn 60 Minuten erreicht, zur n�chsten Stunde
    if (ServerMinute >= 60)
    {
        ServerMinute = 0;
        ServerHour += 1;

        // Nach 24 Uhr wieder zu 0 Uhr
        if (ServerHour >= 24)
        {
            ServerHour = 0;
        }

        // Spielzeit f�r alle Spieler aktualisieren
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
    return 1;  // ? NEU: return hinzugef�gt
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
            print("[MySQL] Bitte pr�fen Sie die Verbindungsdaten.");
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
    // Morgend�mmerung (5-7 Uhr) - Wird hell
    else if (ServerHour >= 5 && ServerHour < 7)
    {
        weather = 2; // Neblig/D�mmerung
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
    // Abendd�mmerung (18-20 Uhr) - Wird dunkel
    else if (ServerHour >= 18 && ServerHour < 20)
    {
        weather = 33; // Orange Himmel/D�mmerung
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
        SetPlayerSkin(playerid, 12);
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

stock bool:IsPasswordValid(const password[])
{
    new len = strlen(password);

    // Mindestens 8 Zeichen
    if (len < 8) return false;

    new bool:hasNumber = false;
    new bool:hasSpecial = false;

    for (new i = 0; i < len; i++)
    {
        // Pr�fe auf Zahl (0-9)
        if (password[i] >= '0' && password[i] <= '9')
        {
            hasNumber = true;
        }
        // Pr�fe auf Sonderzeichen (alles au�er Buchstaben und Zahlen)
        else if (!(password[i] >= 'a' && password[i] <= 'z') &&
                 !(password[i] >= 'A' && password[i] <= 'Z') &&
                 !(password[i] >= '0' && password[i] <= '9'))
        {
            hasSpecial = true;
        }

        // Wenn beide gefunden, k�nnen wir abbrechen
        if (hasNumber && hasSpecial) return true;
    }

    return (hasNumber && hasSpecial);
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

CMD:nrg(playerid, params[])
{
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    CreateVehicle(522, x + 2, y, z, a, -1, -1, -1);
    SendClientMessage(playerid, -1, "NRG-500 gespawnt!");
    return 1;
}
