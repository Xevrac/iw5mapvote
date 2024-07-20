#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

init() {
    precacheshader("gradient_fadein");
    precacheshader("gradient_top");
    precacheshader("white");
    //Set here the maps you want to rotate, separate them with a #.
    // Default level inclusions, uncomment line 11 to include this, comment line 12 to remove custom, or change it :)
    //level.mapvotemaps = strtok("mp_alpha#mp_bootleg#mp_bravo#mp_carbon#mp_dome#mp_exchange#mp_hardhat#mp_interchange#mp_lambeth#mp_mogadishu#mp_paris#mp_plaza2#mp_radar#mp_seatown#mp_underground#mp_village#mp_terminal_cls#mp_rust#mp_highrise#mp_italy#mp_park#mp_overwatch#mp_morningwood#mp_meteora#mp_cement#mp_qadeem#mp_restrepo_ss#mp_hillside_ss#mp_courtyard_ss#mp_aground_ss#mp_six_ss#mp_burn_ss#mp_crosswalk_ss#mp_shipbreaker#mp_roughneck#mp_moab#mp_boardwalk#mp_nola#mp_favela#mp_nuked#mp_nightshift", "#");
    level.mapvotemaps = strtok("mp_seatown#mp_dome#mp_plaza2#mp_mogadishu#mp_paris#mp_bootleg#mp_hardhat#mp_alpha#mp_village#mp_lambeth#mp_radar#mp_underground#mp_bravo#mp_nuked#mp_rust#mp_highrise#mp_terminal_cls#", "#");
    //Set the type/gamemode here, whatever your dsr file is called without the . When doing so, you must also modify within the "maptostring()" function in the "switch(type)" section so that the name of the dsr file matches the type/game mode.
    level.mapvotetype = strtok("XNET_TDM#XNET_INFECTED#XNET_HCTDM#XNET_FFA#XNET_DOM#XNET_HCFFA#XNET_SND", "#");
    level.mapvoteindices = [];
	
	tryes = 0;	
	while(level.mapvoteindices.size < 6 && tryes < 100) {
		tryes++;		
		j = randomint(level.mapvotemaps.size);
		k = randomint(level.mapvotetype.size);	
		while(inArray(level.mapvoteindices,(level.mapvotemaps[j] + "#" + level.mapvotetype[k])))
		{
			j = randomint(level.mapvotemaps.size);
			k = randomint(level.mapvotetype.size);		
		}
		level.mapvoteindices[level.mapvoteindices.size] = level.mapvotemaps[j] + "#" + level.mapvotetype[k];						
	}

    replacefunc(maps\mp\gametypes\_gamelogic::waittillFinalKillcamDone, ::finalkillcamhook);
}

finalkillcamhook() {
    if (!IsDefined(level.finalkillcam_winner)) {
        mapvote();
        return false;
    } else {
        level waittill("final_killcam_done");
        mapvote();
        return true;
    }
}

mapvote() {
    if (!waslastround()) return;
    level.mapvoteui[0] = shader("white", "TOP", "TOP", 0, 120, 350, 20, (0.157,0.173,0.161), 1, 1, true);
    level.mapvoteui[1] = shader("white", "TOP", "TOP", 0, 140, 350, 20, (0.310,0.349,0.275), 1, 1, true);
    level.mapvoteui[2] = shader("gradient_top", "TOP", "TOP", 0, 140, 350, 2, (1,1,1), 1, 2, true);
    level.mapvoteui[3] = shader("white", "TOP", "TOP", 0, 160, 350, 20, (0.212,0.231,0.220), 1, 1, true); //160
    level.mapvoteui[4] = shader("white", "TOP", "TOP", 0, 180, 350, 20, (0.180,0.196,0.188), 1, 1, true); //180
    level.mapvoteui[5] = shader("white", "TOP", "TOP", 0, 200, 350, 20, (0.212,0.231,0.220), 1, 1, true); //200
    level.mapvoteui[6] = shader("white", "TOP", "TOP", 0, 220, 350, 20, (0.180,0.196,0.188), 1, 1, true); //220
    level.mapvoteui[7] = shader("white", "TOP", "TOP", 0, 240, 350, 20, (0.212,0.231,0.220), 1, 1, true); //240
    level.mapvoteui[8] = shader("white", "TOP", "TOP", 0, 260, 350, 20, (0.180,0.196,0.188), 1, 1, true); //260
    level.mapvoteui[9] = shader("white", "TOP", "TOP", 0, 280, 350, 20, (0.157,0.173,.161), 1, 1, true); //280
    level.mapvoteui[10] = shader("white", "TOP", "TOP", 0, 300, 350, 20, (0.310,0.349,0.275), 1, 1, true); //300
    level.mapvoteui[11] = shader("gradient_top", "TOP", "TOP", 0, 280, 350, 2, (1,1,1), 1, 2, true); // 280
    level.mapvoteui[12] = text(&"VOTING PHASE: ", "LEFT", "TOP", -170, 130, 1, "hudSmall", (1,1,1), 1, 3, true, 20);    //
    level.mapvoteui[13] = text( maptostring(strTok(level.mapvoteindices[0],"#")[0], strTok(level.mapvoteindices[0],"#")[1]), "LEFT", "TOP", -170, 170, 1, "objective", (1,1,1), 1, 3, true); // 170
    level.mapvoteui[14] = text( maptostring(strTok(level.mapvoteindices[1],"#")[0], strTok(level.mapvoteindices[1],"#")[1]), "LEFT", "TOP", -170, 190, 1, "objective", (1,1,1), 1, 3, true); // 190
    level.mapvoteui[15] = text( maptostring(strTok(level.mapvoteindices[2],"#")[0], strTok(level.mapvoteindices[2],"#")[1]), "LEFT", "TOP", -170, 210, 1, "objective", (1,1,1), 1, 3, true); // 210
    level.mapvoteui[16] = text( maptostring(strTok(level.mapvoteindices[3],"#")[0], strTok(level.mapvoteindices[3],"#")[1]), "LEFT", "TOP", -170, 230, 1, "objective", (1,1,1), 1, 3, true); // 230
    level.mapvoteui[17] = text( maptostring(strTok(level.mapvoteindices[4],"#")[0], strTok(level.mapvoteindices[4],"#")[1]), "LEFT", "TOP", -170, 250, 1, "objective", (1,1,1), 1, 3, true); // 250
    level.mapvoteui[18] = text( maptostring(strTok(level.mapvoteindices[5],"#")[0], strTok(level.mapvoteindices[5],"#")[1]), "LEFT", "TOP", -170, 270, 1, "objective", (1,1,1), 1, 3, true); // 270  
    //////////////
    //TODO: speed_throw/toggleads_throw will show bound/unbound for hold/toggle ads players. compromise may be to use forward/back, depending on how controller
    //bindings handle this.
    level.mapvoteui[19] = text("Up ^2[{+attack}] ^7Down ^2[{+toggleads_throw}]", "LEFT", "TOP", -170, 290, 1, "objective", (1,1,1), 1, 3, true); //290
    level.mapvoteui[20] = text("Vote ^2[{+activate}]", "RIGHT", "TOP", 170, 290, 1, "objective", (1,1,1), 1, 3, true); //290
    level.mapvoteui[21] = text("^9Discord^7: ^9https://xevnet.au", "LEFT", "TOP", -170, 310, 1, "objective", (0.7,0.7,0.7), 1, 3, true); //310
    foreach(player in level.players) player thread input();
    for(i = 0; i <= 20; i++) {
        level.mapvoteui[12] setvalue(20 - i);
        //playsoundonplayers("trophy_detect_projectile");
        wait 1;
    }
    level notify("mapvote_over");
    besti = 0;
    bestv = -1;
    for(i = 0; i < 6; i++) {
        if(level.mapvoteui[i + 13].value > bestv) {
            besti = i;
            bestv = level.mapvoteui[i + 13].value;
        }
    }
    //Note: We wait to prevent the scoreboard popping up at the end for a cleaner transition (Don't wait infinitely as a failsafe).
    //TODO: Proper manipulation of sv_level.mapvotemaps is the better way to do this as it would allow the final scoreboard to show.
    setDvar( "sv_maprotationcurrent", "dsr " + strTok(level.mapvoteindices[besti],"#")[1] + " map " + strTok(level.mapvoteindices[besti],"#")[0] );   
}

input() {
    self endon("disconnect");
    self endon("mapvote_over");
    index = 0;
    selected = -1;
    select[0] = self text((index + 1) + "/6", "RIGHT", "TOP", 170, 130, 1, "objective", (1,1,1), 1, 3, false);
    //select[1] = self text(" ", "LEFT", "TOP", -170, 150, 1, "objective", (1,1,1), 1, 3, false);
    select[2] = self shader("gradient_fadein", "TOP", "TOP", 0, 160, 350, 20, (1,1,1), 0.5, 2, false);
    select[3] = self shader("gradient_top", "TOP", "TOP", 0, 180, 350, 2, (1,1,1), 1, 2, false);
    self notifyonplayercommand("up", "+attack");
	self notifyonplayercommand("up", "+forward");
    self notifyonplayercommand("down", "+toggleads_throw");
    self notifyonplayercommand("down", "+speed_throw");
    self notifyonplayercommand("down", "+back");
    self notifyonplayercommand("select", "+usereload");
    self notifyonplayercommand("select", "+activate");
    self notifyonplayercommand("select", "+frag");
    for(;;) {
        command = self waittill_any_return("up", "down", "select");        
        if(command == "up" && index > 0) {
            index--;
            select[0] settext((index + 1) + "/6");
            //select[1] settext(" ");
            select[2].y -= 20;
            select[3].y -= 20;
            self playlocalsound("mouse_over");
        } else if(command == "down" && index < 5) {
            index++;
            select[0] settext((index + 1) + "/6");
            //select[1] settext(" ");
            select[2].y += 20;
            select[3].y += 20;
            self playlocalsound("mouse_over");
        } else if(command == "select") {
            if(selected == -1) {
                selected = index;                
                
                level.mapvoteui[selected + 13].value += 1;
                level.mapvoteui[selected + 13].text = strTok(level.mapvoteui[selected + 13].text,":")[0] + ":" + level.mapvoteui[selected + 13].value;
                level.mapvoteui[selected + 13]  settext(level.mapvoteui[selected + 13].text);                
                //iPrintLn(level.mapvoteui[selected + 13].text);                    
                self playlocalsound("mouse_click");
            } else if(selected != index) {                
                
                level.mapvoteui[selected + 13].value -= 1;
                level.mapvoteui[selected + 13].text = strTok(level.mapvoteui[selected + 13].text,":")[0] + ":" + level.mapvoteui[selected + 13].value;
                level.mapvoteui[selected + 13]  settext(level.mapvoteui[selected + 13].text);                
                selected = index;
                
                level.mapvoteui[selected + 13].value += 1;
                level.mapvoteui[selected + 13].text = strTok(level.mapvoteui[selected + 13].text,":")[0] + ":" + level.mapvoteui[selected + 13].value;
                level.mapvoteui[selected + 13]  settext(level.mapvoteui[selected + 13].text);
                //iPrintLn(level.mapvoteui[selected + 13].text);    
                self playlocalsound("mouse_click");
            }
        }        
    }
}

text(text, align, relative, x, y, fontscale, font, color, alpha, sort, server, value) {
    element = spawnstruct();
    if(server) {
        element = createServerFontString( font, fontscale ); 
    } else {
        element = self createFontString( font, fontscale ); 
    }
    if(isdefined(value)) {
        element.label = text;
        element.value = value;
        element setvalue(value);
    } else {
        element settext(text);
        element.text = text;
        element.value = 0;

    }
    element.hidewheninmenu = true;
    element.color = color;
    element.alpha = alpha;
    element.sort = sort;
    element setpoint(align, relative, x, y);
    return element;
}

addTextHud( who, x, y, alpha, alignX, alignY, horiz, vert, fontScale, sort ) {
	if( isPlayer( who ) )
		hud = newClientHudElem( who );
	else
		hud = newHudElem();

	hud.x = x;
	hud.y = y;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.alignX = alignX;
	hud.alignY = alignY;
	if(isdefined(vert))
		hud.vertAlign = vert;
	if(isdefined(horiz))
		hud.horzAlign = horiz;		
	if(fontScale != 0)
		hud.fontScale = fontScale;
	hud.foreground = 1;
	hud.archived = 0;
	return hud;
}

shader(shader, align, relative, x, y, width, height, color, alpha, sort, server) {
    element = spawnstruct();
    if(server) {
        element = newhudelem(self);
    } else {
        element = newclienthudelem(self);
    }
    element.elemtype = "icon";
    element.hidewheninmenu = true;
    element.shader = shader;
    element.width = width;
    element.height = height;
    element.align = align;
    element.relative = relative;
    element.xoffset = 0;
    element.yoffset = 0;
    element.children = [];
    element.sort = sort;
    element.color = color;
    element.alpha = alpha;
    element setparent(level.uiparent);
    element setshader(shader, width, height);
    element setpoint(align, relative, x, y);
    return element;
}

randomindices() {
    array = [];
    for (i = 0; i < 6; i++) {
        array[i] = randomint(level.mapvotemaps.size);
        for (j = 0; j < i; j++) {
            if (array[i] == array[j]) {
                i--;
                break;
            }
        }
    }
    return array;
}



maptostring(map,type) {    
    switch(map) {
    case "mp_alpha":  map = "LOCKDOWN";
    break;
    case "mp_bootleg": map = "BOOTLEG";
    break;
    case "mp_bravo": map = "MISSION";
    break;
    case "mp_carbon": map = "CARBON";
    break;
    case "mp_dome": map = "DOME";
    break;
    case "mp_exchange": map = "DOWNTURN";
    break;
    case "mp_hardhat": map = "HARDHAT";
    break;
    case "mp_interchange": map = "INTERCHANGE";
    break;
    case "mp_lambeth": map = "FALLEN";
    break;
    case "mp_mogadishu": map = "BAKAARA";
    break;
    case "mp_paris": map = "RESISTANCE";
    break;
    case "mp_plaza2": map = "ARKADEN";
    break;
    case "mp_radar": map = "OUTPOST";
    break;
    case "mp_seatown": map = "SEATOWN";
    break;
    case "mp_underground": map = "UNDERGROUND";
    break;
    case "mp_village": map = "VILLAGE";
    break;
    case "mp_terminal_cls": map = "TERMINAL";
    break;
    case "mp_rust": map = "RUST";
    break;
    case "mp_highrise": map = "HIGHRISE";
    break;
    case "mp_italy": map = "PIAZZA";
    break;
    case "mp_park": map = "LIBERATION";
    break;
    case "mp_overwatch": map = "OVERWATCH";
    break;
    case "mp_morningwood": map = "BLACK BOX";
    break;
    case "mp_meteora": map = "SANCTUARY";
    break;
    case "mp_qadeem": map = "OASIS";
    break;
    case "mp_restrepo_ss": map = "LOOKOUT";
    break;
    case "mp_hillside_ss": map = "GETAWAY";
    break;
    case "mp_courtyard_ss": map = "EROSION";
    break;
    case "mp_aground_ss": map = "AGROUND";
    break;
    case "mp_six_ss": map = "VORTEX";
    break;
    case "mp_burn_ss": map = "U-TURN";
    break;
    case "mp_crosswalk_ss": map = "INTERSECTION";
    break;
    case "mp_shipbreaker": map = "DECOMMISSION";
    break;
    case "mp_roughneck": map = "OFF SHORE";
    break;
    case "mp_moab": map = "GULCH";
    break;
    case "mp_boardwalk": map = "BOARDWALK";
    break;
    case "mp_nola": map = "PARISH";
    break;
    case "mp_favela": map = "FAVELA";
    break;
    case "mp_nuked": map = "NUKETOWN";
    break;
    case "mp_nightshift": map = "SKIDROW";
    break;
    case "mp_cement": map = "FOUNDATION";
    break;
    default:
    break;
    } 

    switch(type) {
    case "TDM_default": map = map + " (TEAM DEATHMATCH)" + " :0";
    break;
    case "DOM_default":map = map  + " (DOMINATION)" + " :0";
    break;
    case "DEM_default": map = map + " (DEMOLITION)" + " :0";
    break;
    case "INF_Default": map = map + " (INFECTED)" + " :0";
    break;
    case "FFA_default":map = map  + " (FREE FOR ALL)" + " :0";    
    break;
    case "CTF_default":map = map  + " (CAPTURE THE FLAG)" + " :0";    
    break;
    case "DZ_default":map = map  + " (DROP ZONE)" + " :0";    
    break;
    case "GG_default":map = map  + " (GUN GAME)" + " :0";    
    break;
    case "HQ_default":map = map  + " (HEADQUARTERS)" + " :0";    
    break;
    case "JUG_default":map = map  + " (JUGGERNAUT)" + " :0";
    break;
    case "KC_default":map = map  + " (KILL CONFIRMED)" + " :0";
    break;
    case "OIC_default":map = map  + " (ONE IN THE CHAMBER)" + " :0";
    break;
    case "SAB_default":map = map  + " (SABOTAGE)" + " :0";
    break;
    case "SD_default":map = map  + " (SEARCH AND DESTROY)" + " :0";
    break;
    case "TDEF_default":map = map  + " (TEAM DEFENDER)" + " :0";
    break;
    case "TJ_default":map = map  + " (TEAM JUGGERNAUT)" + " :0";
    break;
	case "XNET_TDM":map = map + " (^9TEAM DEATHMATCH^7)" + ":0";
	break;
	case "XNET_INFECTED":map = map + " (^9INFECTED^7)" + ":0";
	break;
	case "XNET_HCTDM":map = map + " (^1HARDCORE ^9TEAM DEATHMATCH^7)" + ":0";
	break;
	case "XNET_FFA":map = map + " (^9FREE FOR ALL^7)" + ":0";
	break;
	case "XNET_DOM":map = map + " (^9DOMINATION^7)" + ":0";
	break;
	case "XNET_HCFFA":map = map + " (^1HARDCORE ^9FREE FOR ALL^7)" + ":0";
	break;
	case "XNET_SND":map = map + " (^9SEARCH & DESTORY^7)" + ":0";
	break;
    default:
    break;
    }    
    return map;
}

inArray(array, text)
{
    for(i=0; i<array.size; i++)
    {
        if(array[i] == text)
          return true;
    }
    return false;
}