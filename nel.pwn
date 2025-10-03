#include <a_samp>
#include <a_mysql>

#define SERVERNAME "Neverland e-Life"
#define GAMEMODE "Reallife"

#define MYSQL_HOST "127.0.0.1"
#define MYSQL_USER "gta"
#define MYSQL_PASSWORD "Hallo123"
#define MYSQL_DB "gta"

new MySQL:mysql; 

enum {
    DIALOG_LOGIN,
    DIALOG_RULES,
    DIALOG_REGISTER,
    DIALOG_PASSWORD_CONFIRM,
    DIALOG_GENDER,
    DIALOG_AGE

}

enum pData{
    p_id,
	bool:pLoggedIn,
	pName[MAX_PLAYER_NAME+1],
    pPassword[128],
    pAdmin,
	pLevel,
	pMoney,
	pKills,
	pDeaths,
    bool:pGender,
    pAge,
    Float:pLastX,
    Float:pLastY,
    Float:pLastZ
}
new player[MAX_PLAYERS][pData];

main()
{
	print("\n----------------------------------");
	print(" Neverland e-Life");
	print("----------------------------------\n");
}


public OnGameModeInit()
{
    MySQSL_Connection();

	SetGameModeText(#SERVERNAME);
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
    if(!player[playerid][pLoggedIn]) {
        
        SendClientMessage(playerid, -1, "INFO: Es wird überprüft ob du einen Account hast ...");
        new buffer[128];
        mysql_format(mysql, buffer, sizeof(buffer), "SELECT id FROM users WHERE name = '%e'", player[playerid][pName]);
        mysql_pquery(mysql, buffer, "OnPlayerCheck", "d", playerid);
    }
	return 1;
}

forward OnPlayerCheck(playerid);
public OnPlayerCheck(playerid) {
    new r; 
    new buf[600];
    cache_get_row_count(r);
    if(r == 0){
        format(buf, sizeof(buf), "Es wurde kein Account mit dem Namen %s gefunden.", player[playerid][pName]);
        SendClientMessage(playerid, -1, buf);
        ShowPlayerDialog(playerid, DIALOG_RULES, DIALOG_STYLE_MSGBOX, "Regeln", "Grundsätzliche Regeln", "Weiter", "Abbrechen");
    }
    else {
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Anmeldung", "Bitte logge Dich ein:", "Ok", "Abbrechen");
    }
    return 1;
}

public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid, -1, "Herzlich Willkommen!");
    for(new i = 0; i < _:pData; i++)
    {
        player[playerid][pData:i] = 0;
    }
    player[playerid][pLoggedIn] = false;
    GetPlayerName(playerid, player[playerid][pName], MAX_PLAYER_NAME);

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
    new buf[256];
    switch (dialogid)
    {
        case DIALOG_LOGIN:
        {
            if(!response) return Kick(playerid);
		    if(strlen(inputtext) < 3) return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Anmeldung", "Bitte logge Dich ein:\n{FF0000}Mindestens 3 Zeichen!", "Ok", "Abbrechen");  

            
		    mysql_format(mysql, buf, sizeof(buf), "SELECT * FROM users WHERE name = '%e' AND password = MD5('%e')", player[playerid][pName], inputtext);
            mysql_pquery(mysql, buf, "OnPlayerLogin", "d", playerid);
            return 1;
        }

        case DIALOG_RULES:
        {
            if(!response) return Kick(playerid);
            
            ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", "Bitte registriere Dich:", "Ok", "Abbrechen");
            return 1;
        }

        case DIALOG_REGISTER:
        {
            if(!response) return Kick(playerid);

            if(strlen(inputtext) < 8) return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Registration", "Bitte registriere Dich:\n{FF0000}Mindestens 8 Zeichen!", "Weiter", "Abbrechen"); 
            
            strcat(player[playerid][pPassword], inputtext);

            ShowPlayerDialog(playerid, DIALOG_PASSWORD_CONFIRM, DIALOG_STYLE_PASSWORD, "Registration: Passwort erneut eingeben", "Bitte gib dein Passwort zur bestätigung erneut ein:", "Weiter", "Weiter");
            return 1;
        }

        case DIALOG_PASSWORD_CONFIRM:
        {
            if(!response) return Kick(playerid);

            //ggfs prüfen ob eingabe leer ist 
            if (strcmp(player[playerid][pPassword], inputtext)){
                return ShowPlayerDialog(playerid, DIALOG_PASSWORD_CONFIRM, DIALOG_STYLE_PASSWORD, "Registration: Passwort erneut eingeben", "Die Eingabe stimmt nicht überein!\n\nBitte gib dein Passwort zur bestätigung erneut ein:", "Weiter", "Weiter"); 
            }
            /*
            mysql_format(mysql, buf, sizeof(buf),"INSERT INTO users (name, password) VALUES ('%e', MD5('%e'))", player[playerid][pName], player[playerid][pPassword]);
            mysql_pquery(mysql, buf, "OnPlayerRegister", "d", playerid);*/
            ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_MSGBOX, "Registration: Geschlecht", "Sehr gut!\nBitte gib an um du männlich oder weiblich bist.", "Männlich", "Weiblich");

            return 1;
        }

        case DIALOG_GENDER:
        {
            if(!response){
                player[playerid][pGender] = false;
                ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Registration: Alter", "Du hast angegeben, dass du weiblich bist.\nGib noch dein Alter ein. Beachte, dass du mindestens 16 Jahre alt sein musst um Grand Theft Auto: San Andreas spielen zu dürfen.", "Weiter", "Abbrechen");
                return 1;
            }
            player[playerid][pGender] = true;
            ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Registration: Alter", "Du hast angegeben, dass du männlich bist.\nGib noch dein Alter ein. Beachte, dass du mindestens 16 Jahre alt sein musst um Grand Theft Auto: San Andreas spielen zu dürfen.", "Weiter", "Abbrechen");
            return 1;
        }

        case DIALOG_AGE:
        {
            if(!response) return Kick(playerid);
            if(strval(inputtext) < 16 || strval(inputtext) > 100)
            {
                ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Registration: Alter", "Ungültige eingabe!\n\nGib noch dein Alter ein. Beachte, dass du mindestens 16 Jahre alt sein musst um Grand Theft Auto: San Andreas spielen zu dürfen.", "Weiter", "Abbrechen");                
            }
            player[playerid][pAge] = strval(inputtext);

            // Hier dann skinauswahl starten

            mysql_format(mysql, buf, sizeof(buf),"INSERT INTO users (name, password, gender, age) VALUES ('%e', MD5('%e'), %d ,%d)", player[playerid][pName], player[playerid][pPassword], player[playerid][pGender], player[playerid][pAge]);
            mysql_pquery(mysql, buf, "OnPlayerRegister", "d", playerid);
            return 1;
        }

    }
	return 1;
}

forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid){
	player[playerid][p_id] = cache_insert_id();
	player[playerid][pLoggedIn]  = true;
	SendClientMessage(playerid, 0x00FF00FF, "[Konto] Registration erfolgreich.");

    return 1;
}

forward OnPlayerLogin(playerid);
public OnPlayerLogin(playerid){
    new r;
    cache_get_row_count(r);

    if(r == 0){
        ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Anmeldung", "Bitte logge Dich ein:\n{FF0000}Falsches Passwort!", "Ok", "Abbrechen");
    }
    else {
        // Load Stuff
    }
    return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

stock MySQSL_Connection(ttl = 3)
{
	print("[MySQL] Verbindungsaufbau...");
	mysql_log(); 

	mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB);

	if(mysql_errno(mysql) != 0)
	{
		if(ttl > 1)
		{
			print("[MySQL] Es konnte keine Verbindung zur Datenbank hergestellt werden.");
			printf("[MySQL] Starte neuen Verbindungsversuch (TTL: %d).", ttl-1);
			return MySQSL_Connection(ttl-1);
		}
		else
		{
			print("[MySQL] Es konnte keine Verbindung zur Datenbank hergestellt werden.");
			print("[MySQL] Bitte prüfen Sie die Verbindungsdaten.");
			print("[MySQL] Der Server wird heruntergefahren.");
			return SendRconCommand("exit");
		}
	}
	printf("[MySQL] Die Verbindung zur Datenbank wurde erfolgreich hergestellt! Handle: %d", _:mysql);
	return 1;
}