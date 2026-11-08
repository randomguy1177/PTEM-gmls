gml 

global.levelmemory = [];
global.rooms = {};
global.tileset_sizes = {};
if variable_global_exists("sprites") 
{
	var sprs = variable_struct_get_names(global.sprites);
	for (var i = 0;i < array_length(sprs);i++)
		sprite_delete(global.sprites[$ sprs[i]]);
} 
global.sprites = {};
global.audio = []; // unused 

global.afomobjects = {};

spr_missingsprbuffer = 0;
global.missingspr = tile_tower;
// buffer_delete(spr_missingsprbuffer);

instance_create(0, 0, obj_pizzacoinindicator);

instance_destroy(obj_custom_object_ext);

global.killedbitch = false;

with instance_create(0, 0, obj_custom_object_ext)
{
	persistent = 1;
	image_alpha = 0;
	
	tilemap_surface = -4;
	tilemap_rendsurf = -4;
	tilemapinst = -4;
	
	seamX = [0, 0];
	seamY = [0, 0];
	xDiff = [0, 0];
	yDiff = [0, 0];
	seamSaveX = [0, 0];
	seamSaveY = [0, 0];
	camSeamX = 0;
	camSeamY = 0;
	seamsize = 4;
	seamready = false;
	
	// vvv : this used to be a ds_map
	music_map = 
	{
	    "event:/music/w1/entrance" : mu_entrance,
		"event:/mod-music/noisereplace/entrance" : mu_entrance, 
	    "event:/music/w1/entrancesecret" : mu_medievalsecret,
	    "event:/music/w1/medieval" : mu_medievalentrance,
	    "event:/music/w1/medieval.2" : mu_medieval,
	    "event:/music/w1/medievalsecret" : mu_medievalsecret,
	    "event:/music/w1/ruin" : mu_ruin,
	    "event:/music/w1/ruin.1" : mu_ruinremix,
	    "event:/music/w1/ruinsecret" : mu_ruinsecret,
	    "event:/music/w1/dungeon" : mu_dungeon,
	    "event:/music/w1/dungeonsecret" : mu_dungeonsecret,
	
	    "event:/music/w2/desert" : mu_desert,
	    "event:/music/w2/desert.1" : mu_ufo,
	    "event:/music/w2/desertsecret" : mu_desertsecret,
	    "event:/music/w2/farm" : mu_farm,
	    "event:/music/w2/farm.1" : mu_whats_on_kids_menu,
	    "event:/music/w2/farmsecret" : mu_farmsecret,
	    "event:/music/w2/graveyard" : mu_graveyard,
	    "event:/music/w2/graveyardsecret" : mu_medievalsecret,
	    "event:/music/w2/saloon" : mu_saloon,
	    "event:/music/w2/saloonsecret" : mu_saloonsecret,
	
	    "event:/music/w3/beach" : mu_beach,
	    "event:/music/w3/beachsecret" : mu_medievalsecret,
	    "event:/music/w3/forest" : mu_forest,
	    "event:/music/w3/forest.2" : mu_gustavo,
	    "event:/music/w3/forestsecret" : mu_medievalsecret,
	    "event:/music/w3/golf" : mu_minigolf,
	    "event:/music/w3/golfsecret" : mu_medievalsecret,
	    "event:/music/w3/space" : mu_pinball,
	    "event:/music/w3/spacesecret" : mu_medievalsecret,
	
	    "event:/music/w4/freezer" : mu_freezer,
	    "event:/music/w4/freezersecret" : mu_medievalsecret,
	    "event:/music/w4/industrial" : mu_industrial,
	    "event:/music/w4/industrialsecret" : mu_medievalsecret,
	    "event:/music/w4/sewer" : mu_sewer,
	    "event:/music/w4/sewersecret" : mu_medievalsecret,
	    "event:/music/w4/street" : mu_street,
	    "event:/music/w4/streetsecret" : mu_medievalsecret,
	
	    "event:/music/w5/chateau" : mu_chateau,
	    "event:/music/w5/kidsparty" : mu_kidsparty,
	    "event:/music/w5/kidspartysecret" : mu_medievalsecret,
	    "event:/music/w5/war" : mu_war,
	
	    "event:/music/hub" : mu_hub,
	    "event:/music/tutorial" : mu_funiculi,
	    "event:/music/finalescape" : mu_finalescape
	};
	superarray = 
	[
		"obj_hardmode",
		"obj_bosskeynoise",
		"obj_grindrailslope",
		"obj_banditochicken_dynamite",
		"obj_lightsource",
		"obj_followcharacter",
		"obj_doorRobot",
		"obj_tubeleft",
		"obj_introprop",
		"obj_fakepepboss",
		"obj_escapecollect",
		"obj_tubeenter",
		"obj_geromeanim",
		"obj_ratprop",
		"obj_hillbillymonster",
		"obj_rattumble",
		"obj_editor",
		"obj_tubeexitmach",
		"obj_bosshitbox",
		"par_boss",
		"obj_mortfollow",
		"obj_mach3solid",
		"obj_deadjohn1",
		"obj_solid_goblinraid",
		"obj_baddiebutton",
		"obj_endgamefade",
		"obj_hotmetalblock",
		"obj_olivebubbledeco",
		"obj_moustachehitbox",
		"obj_fakepeplimb",
		"obj_piraneapple_spawn",
		"obj_farmerbaddie2",
		"obj_forknight_pizzahead",
		"obj_secrettile",
		"obj_pf_fakepep",
		"obj_chargeenemyhitbox",
		"obj_bigspaceblock",
		"obj_trash",
		"obj_ghoul",
		"obj_vigilantebazooka",
		"obj_audioconfig",
		"obj_soundtest_pause",
		"obj_raceend",
		"obj_kentukybomb",
		"obj_vigilanteNPC",
		"obj_snowparticle",
		"obj_pizzafaceboss_p3",
		"obj_motorboat",
		"obj_charswitch_intro",
		"obj_negativenumber",
		"obj_backgroundreplace",
		"obj_pigdark",
		"obj_baddiehurtbox",
		"obj_stick_forsale",
		"obj_sausageeyes",
		"obj_cowspawner",
		"obj_spaceshuttlestop",
		"obj_debugcontroller",
		"obj_bigspitcheesespike",
		"obj_mainmenu_jumpscare",
		"obj_ventilatorleaf",
		"obj_timesupwar",
		"obj_deadjohnparent",
		"obj_pizzahead_cog",
		"obj_ufobullet",
		"obj_pizzaface_showerprop",
		"obj_monstertrackingrooms",
		"obj_credits",
		"obj_pizzamech",
		"obj_afterimagecontroller",
		"obj_noisejetpack",
		"obj_pf_fakepepgianthead",
		"obj_golfhoop",
		"obj_farmer2",
		"obj_playerprop_macheffect",
		"obj_grandma",
		"obj_brickcomeback",
		"obj_pizzahead_blackfade",
		"obj_confettieffect",
		"obj_pepperman",
		"obj_chieftainNPC",
		"obj_transfotip",
		"obj_dialogcontroller",
		"obj_racestart",
		"obj_railswitchslow",
		"obj_pizzafacebrick",
		"obj_factoryswitch",
		"obj_platformvigi",
		"obj_marbleblock",
		"obj_fakesantapresent",
		"obj_noisefollower",
		"obj_knightplatform",
		"obj_trap",
		"obj_weeniehitbox",
		"obj_menutv2",
		"obj_stringycheese",
		"obj_pizzaball_golfhit",
		"obj_secretportal",
		"obj_piraneapple_sign",
		"obj_chainsawpuff",
		"obj_bee",
		"obj_tiledestroy",
		"obj_noiseyspawner2",
		"obj_tubeexitdownexit",
		"obj_weenie",
		"obj_PTG",
		"obj_conveyorspawner",
		"obj_pepper_marbleblock",
		"obj_peppinoswitch",
		"obj_toppinprop",
		"obj_horsey",
		"obj_pizzaball",
		"obj_pizzaheadminigun",
		"obj_kentukylenny",
		"obj_tutorialtargetblock",
		"obj_fmod",
		"obj_pizzaheadsword",
		"obj_bossdark",
		"obj_tiledintroprop",
		"obj_stick",
		"obj_blackoutline",
		"obj_destroyablegolf",
		"obj_nosand",
		"obj_meatgrinder",
		"obj_toxicbutton",
		"obj_instanttemp",
		"obj_noisekeytell",
		"obj_fakepephallwayend",
		"obj_gnomecustomerblockfinal",
		"obj_fakepeptauntspawner",
		"obj_cowstampede",
		"obj_menutv3",
		"obj_toxiccloud",
		"obj_mine",
		"obj_clownmatoOLD",
		"obj_peppermanGIANTbowlingball",
		"obj_vigilanteshot",
		"obj_pizzafaceboss_p2",
		"obj_reversespaceblock",
		"obj_ammocollect",
		"obj_dynamiteexplosion_boss",
		"obj_ratmountgroundpound",
		"obj_fakepepsolid",
		"obj_farmer3projectile",
		"obj_gustavoswitch",
		"obj_soundtest_next",
		"obj_speedlinesup",
		"obj_tutorialblock",
		"obj_icicle_spawner",
		"obj_burd",
		"obj_noisebigkey",
		"obj_pizzaheadTVspawner",
		"obj_noisebossOLD",
		"obj_endingeffect",
		"obj_musicOLD",
		"obj_johnresurrection_peppino",
		"obj_destructible_goblinraid",
		"obj_noisewashingmachinetower",
		"obj_collectgolf",
		"obj_donkey",
		"obj_loophallway",
		"obj_johnresurrection_gerome",
		"obj_farmerprojectile",
		"obj_skateboardnoise",
		"obj_noisebigbomb",
		"obj_pizzaheadportrait",
		"obj_tvtrap",
		"obj_hiddenobjecttrigger",
		"obj_gustavograbbable",
		"obj_king",
		"obj_fakepepclone",
		"obj_geromeexit",
		"obj_poodebris",
		"obj_shotgunback",
		"obj_johnecheese_spawner",
		"obj_kidspartybg",
		"obj_noisettecafe",
		"obj_text",
		"obj_movingplatform",
		"obj_baddietombcontroller",
		"obj_factorygate",
		"obj_farmerbaddie",
		"obj_soundtest",
		"obj_noisettefinale",
		"obj_keyconfig",
		"obj_mrstickcardboard",
		"obj_longintro",
		"obj_targetguy",
		"obj_computer",
		"obj_pepper_marblestatue",
		"obj_baddiecollisionboxTEST",
		"obj_ratblock1x1",
		"obj_cullingsystem",
		"obj_clownmato",
		"obj_globaltimer",
		"obj_factorycreateeffect",
		"obj_playerprop",
		"obj_patroller",
		"obj_noisecrushertrail",
		"obj_moving_hstop",
		"obj_bottletreasure",
		"obj_secrettrigger",
		"obj_cheftask",
		"obj_whoophand",
		"obj_cow",
		"obj_totemthunder",
		"obj_millionpunchhitbox",
		"obj_pizzakinparent",
		"obj_freezeddragon",
		"obj_vigilantecow",
		"obj_pizzahead_finalecutscene",
		"obj_exitgustavo",
		"obj_snotty",
		"obj_actor",
		"obj_smallletters",
		"obj_mrsticknotification",
		"obj_sausageman",
		"obj_vigilante_duelintro",
		"obj_geromeblock",
		"obj_pineappleprojectilespawn",
		"obj_uziprojectile",
		"obj_pistolbullet",
		"obj_chickenpickup",
		"obj_pepanimatronicfollow",
		"obj_pizzafaceboss_p2OLD",
		"obj_micnoise",
		"obj_uparrowhitbox",
		"obj_taxitransition",
		"obj_touchall",
		"obj_farmer2projectile",
		"obj_stickfollower",
		"obj_hppickup",
		"obj_priesthazard",
		"obj_textureloading",
		"obj_viginoiseyspawner",
		"obj_farmerbaddie2_projectile",
		"obj_vigilantebossOLD",
		"obj_hallwaymonster",
		"obj_doorG",
		"obj_startgate_hats",
		"obj_farmer2follow",
		"obj_hiddenobject",
		"obj_totemcloud",
		"obj_frontcanonbomb",
		"obj_startgate_pizza",
		"obj_magnet",
		"obj_hubelevator",
		"obj_secretportalstart",
		"obj_playereffectprop",
		"obj_ratblock",
		"obj_balloongrabbableeffect",
		"obj_jumpscare",
		"obj_shuttleparts",
		"obj_pizzaarrowtrap",
		"obj_chunktimer",
		"obj_antigravbubbleeffect",
		"obj_startgate_treasure",
		"obj_motorcycleblock",
		"obj_ghostknight",
		"obj_screensizer",
		"obj_stickycheeseprojectile",
		"obj_moving_vstop",
		"obj_fakepephead",
		"obj_policebooth",
		"obj_johnresurrection",
		"obj_pizzaheadbrickball",
		"obj_particlesystem",
		"obj_destroyable_respawner",
		"obj_mainmenu",
		"obj_rocket",
		"obj_deliveryfollower",
		"obj_railswitchnone",
		"obj_lightsource_expand",
		"obj_policecar",
		"obj_railparent",
		"obj_textbutton",
		"obj_dungeonblock",
		"obj_morthook",
		"obj_cheeseballspawner",
		"obj_baddiegibsstick",
		"obj_brickball",
		"obj_fakepeplimb2",
		"obj_exitfollower",
		"obj_stick_target",
		"obj_trapghost",
		"obj_exitfollowercollect",
		"obj_horseydown",
		"obj_lapportalentrance",
		"obj_heatafterimage",
		"obj_ghostdrapes",
		"obj_bosscontroller",
		"obj_ladderhorizontal",
		"obj_johnghost",
		"obj_mortflyaway",
		"obj_treasureeffect",
		"obj_chateaulight",
		"obj_peppermanbowlingballspawner",
		"obj_ghostblock",
		"obj_patrolcone",
		"obj_tubedown",
		"obj_soldier",
		"obj_knighttrap",
		"obj_farmerbaddie3",
		"obj_snicktower",
		"obj_ghosthazard",
		"obj_laundrymachine",
		"obj_hamkuff",
		"obj_secretmanager",
		"obj_pineabreakdancehitbox",
		"obj_monsterslope",
		"obj_farmer3follow",
		"obj_escapespawn",
		"obj_technicaldifficulty",
		"obj_backtohub_fadeout",
		"obj_cowfall",
		"obj_spaceshuttlecutscene",
		"obj_nuketerminal",
		"obj_pizzice_projectile",
		"obj_hurtstars",
		"obj_spaceshuttle",
		"obj_peppermanbrick",
		"obj_moneynumber",
		"obj_slugbullet",
		"obj_noisebosscrate",
		"obj_pizzafacebaddie",
		"obj_bossplayerdeath",
		"obj_pepperman_pepportrait",
		"obj_enemybullet",
		"obj_soundtest_button",
		"obj_ghostdashpad",
		"obj_totem",
		"obj_snowmanhead",
		"obj_bazookabaddie",
		"obj_roomcheck",
		"obj_johnecheese",
		"obj_noisey",
		"obj_farmer1follow",
		"obj_surprisebox_boss",
		"obj_arenadoor", // obj_afom_arenadoor
		"obj_stick_forsale2",
		"obj_spawner_goblinraid",
		"obj_superattackeffect",
		"obj_finalhallwayface",
		"obj_finishereffect",
		"obj_horseyright",
		"obj_hungrypillarflash",
		"obj_badratspawner",
		"obj_coopplayerfollow",
		"obj_grannypizzasign",
		"obj_horseyup",
		"obj_treasureviewer",
		"obj_crosspriest_cross",
		"obj_smokingprojectile",
		"obj_peppermanvengeful",
		"obj_frontcanoncrosshair",
		"obj_optiondoor",
		"obj_playerspikecheese",
		"obj_pizzaface_thunderdark",
		"obj_graffiti",
		"obj_menutv1",
		"obj_timecollect",
		"obj_ramp",
		"obj_meatballtower",
		"obj_deadjohn2",
		"obj_weenieOLD",
		"obj_fakepepprojectile",
		"obj_soundtrap",
		"obj_farmerbaddie3_projectile",
		"obj_horseyblock",
		"obj_clownballoon",
		"obj_johnresurrection_pizzahead",
		"obj_revolvershot",
		"obj_tank",
		"obj_pizzaheadbomb",
		"obj_superpinballmachine",
		"obj_pizzice",
		"obj_smokingpizzaslice",
		"obj_stairs",
		"obj_noisehotairempty",
		"obj_soundtest_prev",
		"obj_minecart_rail",
		"obj_hpeffect",
		"obj_farmerpeasanto",
		"obj_whoop",
		"obj_levelselect",
		"obj_gusbrickfightball",
		"obj_chickenfollow",
		"obj_warplaserhoming",
		"obj_brickballspeedline",
		"obj_geromedoor",
		"obj_spider",
		"obj_antigravbubble",
		"obj_flamethrowerhurtbox",
		"obj_fakeobject",
		"obj_menutv",
		"obj_beedeco",
		"obj_robotmonster",
		"obj_pinballtrap",
		"obj_tea",
		"obj_clownballoon_projectile",
		"obj_clerk",
		"obj_alienbyebye",
		"obj_climbablewall",
		"obj_pepper_groundpoundspot",
		"obj_rubble",
		"obj_spiderweb",
		"obj_characterswitch",
		"obj_lightsource_attach",
		"obj_gustavodestroyable",
		"obj_iceblock_breakable",
		"obj_farmerpeasantoprojectile",
		"obj_deadjohn3",
		"obj_turret",
		"obj_climbingupstairs",
		"obj_electricwall",
		"obj_beatbox",
		"obj_freezerblock",
		"obj_pizzafacepart",
		"obj_robotmonsterhand",
		"obj_beer",
		"obj_gravecorpse",
		"obj_wartimer",
		"obj_bigbeer",
		"obj_savesystem",
		"obj_palettedresser",
		"obj_bossvulnerable",
		"obj_johndestructible",
		"obj_farmerparent",
		"obj_cutoffsmall",
		"obj_ufoexterior",
		"obj_stickycheese",
		"obj_monstersolid",
		"obj_noisekey",
		"obj_arcprojectile",
		"obj_wirewall",
		"obj_hamburger",
		"obj_notes",
		"obj_poweringupeffect",
		"obj_doorMonster",
		"obj_lapportal",
		"obj_pizzasona_points",
		"obj_fakepephallwaystart",
		"obj_getingetin",
		"obj_papertreasure",
		"obj_peppinoclone",
		"obj_bounceplank",
		"obj_peppermanbowlingball",
		"obj_vigilantedynamite",
		"obj_taxicardboard",
		"obj_cheesedragontower",
		"obj_fakepepflash",
		"obj_noisebombboss",
		"obj_bubbles",
		"obj_button",
		"obj_pizzaheadstomp",
		"obj_deliveryfolloweranim",
		"obj_gerome",
		"obj_electricpotato",
		"obj_rancherbullet_debris",
		"obj_pistolpickup",
		"obj_smallforestblock",
		"obj_fallingplatform",
		"obj_hattreasure",
		"obj_ghostcollectibles",
		"obj_achievement_enemiesdead",
		"obj_eggplantdisclaimer",
		"obj_cutoff",
		"obj_genericfade",
		"obj_pizzafacefallout",
		"obj_frontcanongoblin_trigger",
		"obj_playersmokehitbox",
		"obj_endingprop",
		"obj_frontcanongoblin",
		"obj_vigilanteboss",
		"obj_cheeseboat",
		"obj_miniufo_grounded",
		"obj_noiseballooncrash",
		"obj_drawcontroller",
		"obj_rocketdead",
		"obj_noiseboss",
		"obj_pizzaarrow",
		"obj_bigforestblock",
		"obj_pizzafacehitbox",
		"obj_cleaningwater",
		"obj_deliverytimer",
		"obj_arena_pizzaportal",
		"obj_noisebossbomb",
		"obj_haystackrope",
		"obj_monstergate",
		"obj_pizzahead_haywire",
		"obj_baddiespawnernograv",
		"obj_spaceblock",
		"obj_gusbrickchase",
		"obj_priest",
		"obj_tutorialbook",
		"obj_mrstickboss",
		"obj_baddiebutton_perma",
		"obj_fakepeppinospawner",
		"obj_titlecard",
		"obj_baddiegate",
		"obj_vigilantefollower",
		"obj_tubeup",
		"obj_sandparticle",
		"obj_gusbrickhurt",
		"obj_asteroid",
		"obj_startgate_secreteye",
		"obj_golfdemon",
		"obj_filedoor",
		"obj_forknightspawner",
		"obj_tuberight",
		"obj_combotitle",
		"obj_factoryblock",
		"obj_wordhitbox",
		"obj_bazooka",
		"obj_deliverypizzabox",
		"obj_slope",
		"obj_solid",
		"obj_thunder",
		"obj_swordstone",
		"obj_bombexplosion",
		"obj_boilingsauce",
		"obj_puppetsafezone",
		"obj_dummyTEST",
		"obj_tinyslimedude",
		"obj_pizzagoblinbomb",
		"obj_camerapatrol",
		"obj_canongoblinbomb",
		"obj_player",
		"obj_player2",
		"obj_player1",
		"obj_pause",
		"obj_music",
		"obj_tv",
		"obj_bosshealth",
		"obj_camera",
		"obj_playerexplosion",
		"obj_toppinwarriorattack",
		"obj_destructibles",
		"obj_bigdestructibles",
		"obj_saveroom",
		"obj_panicdebris",
		"obj_kentukylenny_projectile",
		"obj_controller",
		"obj_stylebar",
		"obj_parallax",
		"obj_pizzacoinindicator",
		"obj_secretfound",
		"obj_cooppointer",
		"obj_stick_gateprop",
		"obj_coopflag",
		"obj_escapecollectbig",
		"obj_roomname",
		"obj_timeattack",
		"obj_vigidelete",
		"obj_pigtotal",
		"obj_anchortrap",
		"epicboogaloo",
		"obj_inputAssigner",
		"obj_title",
		"obj_mainmenuselect",
		"obj_option",
		"obj_erasegame",
		"obj_lungehitbox",
		"obj_keyconfigOLD",
		"obj_cursor",
		"obj_menuselections",
		"obj_hard",
		"obj_controls",
		"obj_file1",
		"obj_file3",
		"obj_mrmooney",
		"obj_file2",
		"obj_retry",
		"obj_exit",
		"obj_manual",
		"obj_characterselect",
		"obj_peppinoselect",
		"obj_noiseselect",
		"obj_mouthhitbox",
		"obj_rank",
		"obj_generaldestroyable",
		"obj_noiseyspawner",
		"obj_timesup",
		"obj_rattumble_big",
		"obj_slaphitbox",
		"obj_canonexplosion",
		"obj_gasolinetreasure",
		"obj_bomb",
		"obj_swordhitbox",
		"obj_introscooter",
		"obj_haystack",
		"obj_firemouth_projectile",
		"obj_junk",
		"obj_throwableparent",
		"obj_stampedecloud",
		"obj_breakabletv",
		"obj_shotgunbullet",
		"obj_metalblock",
		"obj_shotgunbullet857",
		"obj_dynamiteexplosion",
		"obj_car_dead",
		"obj_baddiecollisionbox",
		"obj_slaphitbox2",
		"obj_hurtbox",
		"obj_pizzaface_thunder",
		"obj_swingdinghitbox",
		"obj_playerbomb",
		"obj_dynamite",
		"obj_pizzaheadbomb_explosion",
		"obj_mortblock",
		"obj_morthitbox",
		"obj_kentukykenny_projectile",
		"obj_pizzard_bolt",
		"obj_pepgoblin_kickhitbox",
		"obj_rancher_bullet",
		"obj_minijohn_hitbox",
		"obj_spike",
		"obj_vigilantebazookatrail",
		"obj_warblock",
		"obj_conveyordespawner",
		"obj_fightballblock",
		"obj_baddie",
		"obj_thug_red",
		"obj_parryhitbox",
		"obj_baddiecollisionboxother",
		"obj_destructiblerockblock",
		"obj_boss",
		"obj_ghostfollow",
		"obj_baddiedead",
		"obj_robotknife",
		"obj_spitcheesespike",
		"obj_pineahitbox",
		"obj_sausagemancigar",
		"obj_verticalhallway",
		"obj_forkhitbox",
		"obj_slipnslide",
		"obj_warplaser",
		"obj_baddieragehitbox",
		"obj_noisegoblin_arrow",
		"obj_banditochicken_projectile",
		"obj_junkenemy",
		"obj_sausageman_dead",
		"obj_enemybird",
		"obj_slimedead",
		"obj_enemybandaid",
		"obj_cheeseslime",
		"obj_thug_blue",
		"obj_thug_green",
		"obj_treasureguy",
		"obj_treasureguybox",
		"obj_minijohn",
		"obj_piraneapple",
		"obj_banditochicken",
		"obj_snowman",
		"obj_cheeserobot",
		"obj_pizzaboy",
		"obj_robot",
		"obj_kentukykenny",
		"obj_pizzagoblin",
		"obj_noisegoblin",
		"obj_canongoblin",
		"obj_flush",
		"obj_autocanon",
		"obj_tvtrigger",
		"obj_pizzard",
		"obj_pickle",
		"obj_rancher",
		"obj_swedishmonkey",
		"obj_randomobject",
		"obj_pepgoblin",
		"obj_johnresurrection_treasure",
		"obj_pinballlauncher",
		"obj_bigcheese",
		"obj_ballgoal",
		"obj_pizzaballOLDOLD",
		"obj_spitcheese",
		"obj_trashOLD",
		"obj_invtrash",
		"obj_peasanto",
		"obj_ninja",
		"obj_forknight",
		"obj_tankOLD",
		"obj_coolpineapple",
		"obj_ancho",
		"obj_sprite", // obj_soundtest_gus
		"obj_miniufo",
		"obj_indiancheese",
		"obj_fencer",
		"obj_sausagemanOLD",
		"obj_grandpa",
		"obj_weeniesquireOLD",
		"obj_alienpickup",
		"obj_weeniemount",
		"obj_baddiespawner",
		"obj_agressivebaddiespawner",
		"obj_supriseenemyarea",
		"obj_arenagate",
		"obj_supriseenemy",
		"obj_escapeenemy",
		"obj_arenaspawn", // obj_afom_arenaspawn
		"obj_arenalimit",
		"obj_arenaspawnpoint",
		"obj_superspring",
		"obj_gusbrickhub",
		"obj_balloon",
		"obj_timedgate",
		"obj_pizzafaceboss_p3OLD",
		"obj_pizzaballOLD",
		"obj_peppermandestroyable",
		"obj_peppermanOLD",
		"obj_graffititreasure",
		"obj_peppermancharge",
		"obj_fakepeppino",
		"obj_crushershockwave",
		"obj_pepperbombspawner",
		"obj_cheesedragon",
		"obj_cheesedragonflames",
		"obj_peppermanbomb",
		"obj_enemyrain",
		"obj_pizzaface",
		"obj_onebyone",
		"obj_platform",
		"obj_destroyable",
		"obj_ladder",
		"obj_rollblock",
		"obj_secretblock",
		"obj_grabbiehandOLD",
		"obj_desertdestroyable",
		"obj_destroyable2",
		"obj_destroyable3",
		"obj_secretdestroyable",
		"obj_onewaybigblock",
		"obj_secretbigblock",
		"obj_secretmetalblock",
		"obj_destroyable2_big",
		"obj_cheeseballblock",
		"obj_barrelblock",
		"obj_reverseminipillar",
		"obj_minipillar",
		"obj_movingoutlet",
		"obj_null",
		"obj_unclimbablewall",
		"obj_grindrail",
		"obj_bombblock",
		"obj_enemyblock",
		"obj_shotgunblock",
		"obj_weaponmachine",
		"obj_shotgun",
		"obj_treasure",
		"obj_giantkey",
		"obj_pizzaboxunopen",
		"obj_collect",
		"obj_pizzapepper",
		"obj_bigcollectgolf",
		"obj_pizzashield_collectible",
		"obj_pizzashield",
		"obj_pizzakinshroom",
		"obj_pizzakincheese",
		"obj_pizzakintomato",
		"obj_pizzakinsausage",
		"obj_pizzakinpineapple",
		"obj_noisebomb", // obj_afom_noisebomb
		"obj_bigcollect",
		"obj_giantcollect",
		"obj_key",
		"obj_pizzaslice",
		"obj_pizzacoin",
		"obj_phonebooth",
		"obj_hungrypillar",
		"obj_exitgate",
		"obj_exitdoorsignground",
		"obj_snicklevelend",
		"obj_portalentrance",
		"obj_portalend",
		"obj_costumerdoor",
		"obj_costumer",
		"obj_costumerpizza",
		"obj_cheeseball",
		"obj_pineapplemonster",
		"obj_wetfloor",
		"obj_beertreasure",
		"obj_noisebombspawner",
		"obj_sidesuperspring",
		"obj_beartrap",
		"obj_bowlingball",
		"obj_skateboard",
		"obj_pizzacutterthwomp2",
		"obj_pizzacutterthwomp1",
		"obj_taxi",
		"obj_stopsign",
		"obj_mort_inline",
		"obj_taxidud",
		"obj_keydoor",
		"obj_breakabledoor",
		"obj_door",
		"obj_goldendoor",
		"obj_badrat",
		"obj_doorblocked",
		"obj_startgate",
		"obj_boxofpizza",
		"obj_hallway",
		"obj_pitfall",
		"obj_door2",
		"obj_doorA",
		"obj_doorB",
		"obj_doorC",
		"obj_doorD",
		"obj_doorE",
		"obj_pizzacutter1",
		"obj_pizzacutter2",
		"obj_destructibleplatform",
		"obj_iceblock",
		"obj_peppermanartdude",
		"obj_risingboilingsauce",
		"obj_noisetrap_rock",
		"obj_dashpad",
		"obj_tntblock",
		"obj_noisedynamite",
		"obj_boulder",
		"obj_rockblock",
		"obj_crosspriest",
		"obj_noiserock",
		"obj_boulderspawner",
		"obj_firemouthflame",
		"obj_freemilk",
		"obj_tombstone",
		"obj_ghostwall",
		"obj_metaldetector",
		"obj_noisehotair",
		"obj_noisematch",
		"obj_mortfollowerexit",
		"obj_pizzafaceshower",
		"obj_hookup",
		"obj_pizzafaceboss_p2background",
		"obj_mort",
		"obj_lavapotfall",
		"obj_mortgrain",
		"obj_well",
		"obj_warppoint",
		"obj_gusbrickpoker",
		"obj_lap2visual",
		"obj_timedgateclock",
		"obj_tomatoblock",
		"obj_teleporter",
		"obj_water",
		"obj_woodbarrel",
		"obj_barrel",
		"obj_current",
		"obj_barrelspawner",
		"obj_gustavopizza",
		"obj_gnomecustomer",
		"obj_doornexthub",
		"obj_gnomecustomerblock",
		"obj_ratrunaway",
		"obj_mushroom",
		"obj_gnomehouse1",
		"obj_gnomehouse2",
		"obj_gnomehouse3",
		"obj_gnomehouse4",
		"obj_gnomehouse5",
		"obj_washingmachinemount",
		"obj_grabbiehand",
		"obj_boxcrusher",
		"obj_iceblock_temp",
		"obj_hubtreasure",
		"obj_cheeseblob",
		"obj_cheesemaker",
		"obj_railv",
		"obj_railh2",
		"obj_pizzacollectphy",
		"obj_railh",
		"obj_car",
		"obj_vsscreen",
		"obj_pizzasonacollect",
		"obj_goalsign",
		"obj_flushcount",
		"obj_siren",
		"obj_exitdoorsign",
		"obj_plusseconds",
		"obj_ranksign",
		"obj_gustavo_warmissile",
		"obj_donesign",
		"obj_Hranksign",
		"obj_press",
		"obj_uparrow",
		"obj_pizzaheadTV_bg",
		"obj_creditimages",
		"obj_leveltitles",
		"obj_easy",
		"obj_pizzafacep3_prop",
		"obj_100",
		"obj_80",
		"obj_movingspike",
		"obj_40",
		"obj_gustavo_kidsparty",
		"obj_20",
		"obj_pizzaball_rank",
		"obj_smallnumber",
		"obj_cowboyhat",
		"obj_treasureshadow",
		"obj_Opeppino",
		"obj_itspizzatime",
		"obj_grabmarker",
		"obj_parentparticle",
		"obj_balloongrabbable",
		"obj_baddiegibs",
		"obj_fakesanta",
		"obj_doorF",
		"obj_washingmachine",
		"obj_wooddebris",
		"obj_slapstar",
		"obj_pizzadebris",
		"obj_debris",
		"obj_dripspawner",
		"obj_null", // object189
		"obj_explosive_goblinraid",
		"obj_bulletcollectible",
		"obj_knightdebris",
		"obj_boxxeddebris",
		"obj_glassdebris",
		"obj_vomit",
		"obj_slimedebris",
		"obj_metaldebris",
		"obj_meatblock",
		"obj_drip",
		"obj_skateboarddebris1",
		"obj_lock",
		"obj_pizzaloss",
		"obj_skateboarddebris2",
		"obj_tntblockdebris",
		"obj_fallingHUDface",
		"obj_cheesedragonshadow",
		"obj_hubwater",
		"obj_gusbrickcloud",
		"obj_shakeanddie",
		"obj_noisesatellite",
		"obj_glassblock",
		"obj_tutorialtrap",
		"obj_crashingplane",
		"obj_crashplaneblock",
		"obj_pizzaballblock",
		"obj_ventilator",
		"obj_toppinwarrior",
		"obj_toppinwarriorbutton",
		"obj_logoprop",
		"obj_solidpillar",
		"obj_lightlamp",
		"obj_farmer3",
		"obj_lampost",
		"obj_pillarentrance",
		"obj_hardmode_ghost",
		"obj_speedlines",
		"obj_pizzaportalfade",
		"obj_angrycloud",
		"obj_sweat",
		"obj_balloonpop",
		"obj_fakepepfollower",
		"obj_bulletimpact",
		"obj_bulletdisappear",
		"obj_chargeeffect",
		"obj_superchargeeffect",
		"obj_pogoeffect",
		"obj_chainsaweffect",
		"obj_vigilantespot",
		"obj_explosioneffect",
		"obj_pistoleffect",
		"obj_shotgunjumpeffect",
		"obj_superslameffect",
		"obj_spikehurteffect",
		"obj_stompeffect",
		"obj_jumpdust",
		"obj_superdashcloud",
		"obj_highjumpcloud1",
		"obj_highjumpcloud2",
		"obj_grindeffect",
		"obj_world5john",
		"obj_brickgustavo",
		"obj_punchdust",
		"obj_fadeout",
		"obj_pausefadeout",
		"obj_endlevelfade",
		"obj_bossdefeatflash",
		"obj_bangeffect",
		"obj_blackbars",
		"obj_bumpeffect",
		"obj_keyeffect",
		"obj_doortransition",
		"obj_doortransitionend",
		"obj_doortransition2",
		"obj_slidecloud",
		"obj_puppetmonster",
		"obj_landcloud",
		"obj_dashcloud",
		"obj_dashcloud2",
		"obj_cloudeffect",
		"obj_machalleffect",
		"obj_afterimage",
		"obj_crazyruneffect",
		"obj_crazyrunothereffect",
		"obj_taunteffect",
		"obj_baddietaunteffect",
		"obj_tauntafterimage",
		"obj_toxicfan",
		"obj_tauntaftereffectspawner",
		"obj_flash",
		"obj_ghosttransparency",
		"obj_piranneapplewater",
		"obj_bombdelete",
		"obj_fakepepgianthead",
		"obj_mrstickblock",
		"obj_parryeffect",
		"obj_golflauncher",
		"obj_genericpoofeffect",
		"obj_pizzafaceboss_p3intro",
		"obj_snickexe",
		"obj_SAGE2019achievementmarker",
		"obj_snickchallengedoor",
		"obj_cowboytask",
		"obj_bossspotlight",
		"obj_pepbat",
		"obj_dresser",
		"obj_achievementviewer",
		"obj_presentbox",
		"obj_iceblockminiboss",
		"obj_santanoise",
		"obj_santasleight",
		"obj_santasleight2",
		"obj_blank",
		"obj_alienfollow",
		"obj_clock",
		"obj_lavapot",
		"obj_objecticontracker",
		"obj_hoop",
		"obj_pizzaheadbullet",
		"obj_null", // "object474",
		"obj_gustavo",
		"obj_noisevengeful",
		"obj_tinytaunt",
		"obj_cutscene_handler",
		"obj_customeractor",
		"obj_pizzacustomer",
		"obj_peasantohitbox",
		"obj_mrstickhub",
		"obj_taxi_cutscene",
		"obj_gnome_checklist",
		"obj_beachsandparticle",
		"obj_mach3effect",
		"obj_motodude",
		"obj_baddiecameraspawner",
		"obj_kentukybombfire",
		"obj_priestangel",
		"obj_gravesurfing",
		"obj_kentukybomber",
		"obj_golfburger",
		"obj_planetparticle",
		"obj_banditobomb",
		"obj_iceblockslope",
		"obj_burgertreasure",
		"obj_checkpoint",
		"obj_medievalprojectile",
		"obj_smallspaceblock",
		"obj_objectlist",
		"obj_achievementtracker",
		"obj_pizzafaceboss",
		"obj_loadingscreen",
		"obj_endingrank",
		"obj_comboend",
		"obj_geromefollow",
		"obj_ending",
		"obj_vigilanteunsure",
		"obj_bosskeyspawn",
		"obj_pizzaheadgetout",
		"obj_fakepepheaddebris",
		"obj_vigilantecrate",
		"obj_evilbanana",
		"obj_icicle",
		"obj_ham",
		"obj_bosscontrollerOLD",
		"obj_pauseOLD",
		"obj_gustavo_war",
		"obj_enguardehitbox",
		"obj_pineapplemonsterzone",
		"obj_shotgunblast",
		"obj_gustavofollower",
		"obj_snottyexit",
		"obj_playernoisearrow",
		"obj_cracker",
		"obj_pigcitizen",
		"obj_pizzahead_whitefade",
		"obj_tutorialtarget",
		"obj_achievement_custom",
		"obj_weeniesquire",
		"obj_timedgatespawn",
		"obj_blobmonster",
		"obj_peppermanNPC",
		"obj_pizzafacebossOLD",
		"obj_spaceblockswitch",
		"obj_giantkeyfollow",
		"obj_fakepepspawner",
		"obj_toxicspray",
		"obj_factorysensor",
		"obj_pizzaheadswordstone",
		"obj_horseyleft",
		"obj_graffiticount",
		"obj_monster",
		"obj_version",
		"obj_pepper_marblespot",
		"obj_dialognpc",
		"obj_screenconfirm",
		"obj_keyfollow",
		"obj_spaceshuttletrans",
		"obj_pizzahead_attackhitbox",
		"obj_antigrav",
		"obj_peppermanfollower",
		"obj_tile_precision_check",
		"obj_tubeexitSjump",
		"obj_bosskey",
		"obj_fakesuperspring",
		"obj_endingcard",
		"obj_johnresurrection_pillar",
		"obj_possessable",
		"obj_bigtombstone",
		"obj_minecart",
		"obj_rmEditor",
		"obj_editorInst",
		"obj_modAssets", 
		"obj_editorBG",
		"obj_cyop_loader",
		"obj_tilemapDrawer",
		"obj_customRoomTransition",
		"obj_customBG",
		"obj_sprite",
		"obj_customAudio",
		"obj_menutvcustom",
		"obj_modMenu",
		"obj_pizzasona_spawn",
		"obj_towerBrowser",
		"obj_camera_region",
		"obj_warp_number",
		"obj_teleporter_receptor",
		"obj_destroyable2_bigescape",
		"obj_destroyable2_escape",
		"obj_destroyable_escape",
		"obj_destroyable3_escape"
	];
	cyopconvertlist = {};
	for (var i = 0, cyop_len = array_length(superarray);i < cyop_len;i++)
		cyopconvertlist[$ i] = superarray[i];
	depth = 200;
	levelLoaded = false;
	selected = 0;
	global.handlerid = id;
	global.levelname = "";
	download_queue = ds_queue_create();
	downloading = false;
	downloadFile = function(_file, _filename) 
	{
		var q =
		{
			file : _file, 
			name : _filename
		};
		
		ds_queue_enqueue(download_queue, q);
	} 
	downloadFile("https://file.garden/Z3VHA6ddaRVf0rYy/nighttower.png", "spr_nighttower.png");
	downloadFile("https://file.garden/Z3VHA6ddaRVf0rYy/spr_missingtile.png", "spr_missingtile.png");
	if !file_exists("towericon.png") 
		downloadFile("https://file.garden/Z3VHA6ddaRVf0rYy/towericon.png", "towericon.png");
	else
		global.towericon = sprite_add("towericon.png", 0, 0, 0, 0, 0);
	get_user_folder = function()
	{
		var startPath = ""
		if (os_type == os_android) {
			var temp = string_split(game_save_id, "/", true)
			var first_index = array_get_index("data", temp)
			startPath = "/storage/emulated/" + temp[first_index + 2]
		} else {
			var temp = string_split(working_directory, "\\", true)
			startPath = "C:/Users/" + temp[3]
		}
		return startPath + "/Documents/pizza tower android/"
	}
	game_directory = get_user_folder()
	path = game_directory + "afom" + "/" 
	if (!directory_exists(game_directory))
		directory_create(game_directory)
	if (!directory_exists(path))
		directory_create(path)
	ini_open(game_directory + "afom_user.ini");
	var saved_path = ini_read_string("General", "saved_path", "")
	if saved_path != path {
		get_string_async("(This system was made by hoy_es_diciembre_1225 this code is being used for temporary purposes) Heya!\nJust to let you know that the afom folder is " + (saved_path == "" ? "" : "now ") + "located in:", path)
		ini_write_string("General", "saved_path", string(path))
	}
	ini_close();
	// path = "/storage/emulated/0/Documents/pizza tower android/afom/"; 
	tilebetterload = false;
	options = 
	[
		{
			text : "ALT TILE LOADING", 
			enabled : false, 
			variable : "tilebetterload" 
		} 
		, 
		{
			text : "LOAD CUSTOM SPRITES", 
			enabled : true, 
			variable : "loadcustomsprites" 
		}, 
		{
			text : "PREFER WFIXED ROOMS", 
			enabled : true, 
			variable : "fixedrooms" 
		} 
	];
	tab = 0;
	tabs = ["LEVELS", "SETTINGS"];
	levels = [];
	loadtimer = 0;
	for (var level_names = file_find_first(path + "*", fa_directory);level_names != "";level_names = file_find_next())
	{
		var level_bg = file_exists(path + level_names + "/bg.png") ? sprite_add(path + level_names + "/bg.png", 0, 0, 0, 0, 0) : "none";
		var level_icon = file_exists(path + level_names + "/icon.png") ? sprite_add(path + level_names + "/icon.png", 0, 0, 0, 0, 0) : "none";
		array_push(levels,
		{
			name : level_names, 
			bg : level_bg, 
			icon : level_icon
		});
	} 
	file_find_close();
	for (var i = 0;i < array_length(levels);i++) // file find first fucking sucks it can't be put in another file find first 
	{
		var my_ini = file_find_first(path + levels[i].name + "/*.ini", 0);
		file_find_close();
		ini_open(path + levels[i].name + "/" + my_ini);
		levels[i].ininame = ini_read_string("properties", "name", string(levels[i].name));
		if levels[i].icon == "none" && !ini_read_real("properties", "type", 0) && variable_global_exists("towericon")
			levels[i].icon = global.towericon;
		ini_close();
	} 
	instance_deactivate_all(true);
	instance_activate_object(obj_inputAssigner);
	instance_activate_object(obj_virtual_controller);
	instance_activate_object(obj_virtual_controller_manager);
	instance_activate_object(obj_elite_controller);
	instance_activate_object(obj_screensizer);
	instance_activate_object(obj_savesystem);
	audio_pause_all();
	scr_music(mu_editor);
	loadtiles = true;
	loadcustomsprites = true;
	fixedrooms = true;
	useoldtilerendering = false;
	bg_names = [];
	// set = false;
	global.errorlist = [];
	scrolling = 0;
	tiletimer = 0;
	last_tile_cx = 0;
	last_tile_cy = 0;
	event.room_start[0] = @'
		if !levelLoaded
			exit;
		if surface_exists(tilemap_surface)
			surface_free(tilemap_surface);
		with obj_tutorialbook
		{
			image_visible = true;
			idlespr = spr_tutorialgranny_sleep;
			talkspr = spr_tutorialgranny_talk;
		} 
		var lev = -1;
		for (var l = 0, l_len = array_length(global.levelmemory);l < l_len;l++)
		{
			if room == global.levelmemory[l].room_index
			{
			    lev = l;
			    break;
			}
		}
		if lev != -1
		{
			var file = global.levelmemory[lev];
			bg_names = variable_struct_get_names(file.backgrounds);
			for (var i = 1, i_len5 = array_length(bg_names);i < i_len5;i++)
			{
			    var this = bg_names[i];
			    var z = i - 1;
			    while (z >= 0 && real(bg_names[z]) < real(this))
			    {
			        bg_names[z + 1] = bg_names[z];
			        z--;
			    }
			    bg_names[z + 1] = this;
			}
			// show_message_async(bg_names);
			for (var c = 0, c_len = array_length(global.afomobjects[$ room]);c < c_len;c++) 
			{
				var j = global.afomobjects[$ room][c];
				with j.object
				{
					if object_index == obj_sprite && variable_struct_exists(j.variables, "sprite_index")
					    j.variables.sprite = j.variables.sprite_index;
					if object_index == obj_sprite && variable_struct_exists(j.variables, "idlespr")
					    j.variables.sprite = j.variables.idlespr;
					if object_index == obj_timedgateclock && variable_struct_exists(j.variables, "time_max")
					    j.variables.time = j.variables.time_max;
					if object_index == obj_tutorialbook && variable_struct_exists(j.variables, "visible")
					    j.variables.image_visible = j.variables.visible;
					if variable_struct_exists(j.variables, "sprite_index")
					{
						if !sprite_exists(asset_get_index(j.variables.sprite_index)) && !variable_struct_exists(global.sprites, j.variables.sprite_index) 
							j.variables.sprite_index = object_get_sprite(object_index);
					} 
					if variable_struct_exists(j.variables, "sprite")
					{
						if !sprite_exists(asset_get_index(j.variables.sprite)) && !variable_struct_exists(global.sprites, j.variables.sprite) 
							j.variables.sprite = spr_player_idle;
					} 
					if object_index == obj_pizzaboxunopen && variable_struct_exists(j.variables, "content")
					{
						if is_array(j.variables.content) 
							j.variables.content = j.variables.content[0]; // temporary bug fix
					} 
					if object_index == obj_conveyorspawner && variable_struct_exists(j.variables, "objectlist")
					{
						var arr = [];
						if !is_array(j.variables.objectlist) 
						{
							array_push(arr, asset_get_index(j.variables.objectlist) != -1 ? asset_get_index(j.variables.objectlist) : obj_null);
							j.variables.objectlist = arr;
						}
					} 
					var arr_names = variable_struct_get_names(j.variables);
					for (var k = 0;k < variable_struct_names_count(j.variables);k++) 
					{
						var isasset = asset_get_index(variable_struct_get(j.variables, arr_names[k])) != -1; // check if the string is a gamemaker asset
						if arr_names[k] == "escape" && object_get_parent(object_index) == obj_baddie
						{
							if variable_struct_get(j.variables, arr_names[k]) || variable_struct_get(j.variables, arr_names[k]) == "true"
							{
								with instance_create(j.variables.x - file.roomX, j.variables.y - file.roomY, obj_escapespawn) 
									baddieID = other.id;
								if global.panic
									instance_deactivate_object(id);
							}
						}
						if variable_struct_get(j.variables, arr_names[k]) == "true" 
							variable_struct_set(j.variables, arr_names[k], true);
						if variable_struct_get(j.variables, arr_names[k]) == "false" 
							variable_struct_set(j.variables, arr_names[k], false); 
						var _val = variable_struct_get(j.variables, arr_names[k]);
						var customsprlol = is_string(_val) && variable_struct_exists(global.sprites, _val);
						variable_instance_set(id, arr_names[k], customsprlol ? global.sprites[$ _val] : (isasset ? asset_get_index(_val) : _val)); // assign the variables from the instance to the object 
					}
					if object_index == obj_roomname && variable_instance_exists(id, "msg") // fail safe God 
						global.roommessage = msg;
					if object_index == obj_tutorialbook
					{ 
						visible = 0;
						text_xscale = (display_get_gui_width() - 64) / sprite_get_width(spr_tutorialbubble);
						event_perform(ev_other, ev_room_start);
					} 
					if object_index == obj_teleporter
					{
						start = 1;
						trigger = false;
						sprite_index = spr_teleportportal;
						depth = object_get_depth(obj_teleporter);
					} 
					if object_index == obj_secretportal && variable_instance_exists(id, "secret") && secret && !instance_exists(obj_ghostcollectibles)
						instance_create(0, 0, obj_ghostcollectibles);
					x = j.variables.x - file.roomX;
					y = j.variables.y - file.roomY;
					xstart = x;
					ystart = y;
					if object_index == obj_door
						y = round(y / 32) * 32;
					if variable_struct_exists(j.variables, "flipX") && j.variables.flipX // ripped from cyop
					{
					    var horDifference = sprite_get_width(sprite_index) - sprite_get_xoffset(sprite_index) * 2;
					    x += horDifference * image_xscale;
					    image_xscale *= -1;
					}
					if variable_struct_exists(j.variables, "flipY") && j.variables.flipY // ripped from cyop 
					{
					    var verDifference = sprite_get_height(sprite_index) - sprite_get_yoffset(sprite_index) * 2;
					    y += verDifference * image_yscale;
					    image_yscale *= -1;
					}
					if object_index == obj_text && text == obj_startgate
					{
						with instance_create(x, y, obj_startgate) 
						{
							level = other.levelName;
							xstart = x;
							ystart = y;
							sprite_index = (other.sprite_index == spr_null ? object_get_sprite(obj_startgate) : other.sprite_index);
							targetRoom = global.rooms[$ "main"];
							levelName = other.levelName;
						} 
						instance_destroy();
					} 
					if object_index == obj_text && text == "obj_teleporter_receptor"
					{
						with instance_create(x, y, obj_teleporter) 
						{
							xstart = x;
							ystart = y;
							event_perform(ev_other, ev_room_start);
						} 
						instance_destroy();
					} 
					if variable_struct_exists(j.variables, "targetRoom")
					{
						var targetname = variable_struct_get(j.variables, "targetRoom");
						
						if other.fixedrooms
							variable_instance_set(id, "targetRoom", global.rooms[$ (targetname + (global.rooms[$ targetname + "_wfixed"] != undefined ? "_wfixed" : ""))]);
						else
							variable_instance_set(id, "targetRoom", global.rooms[$ targetname]);
					} 
				} 
			} 
			if !audio_is_playing(file.song) && audio_exists(file.song) && !global.panic
			{
				audio_stop_sound(obj_music.musicID);
				obj_music.musicID = scr_music(file.song);
			}
			if file[$ "pscore"] != undefined && global.srank != file.pscore
				global.srank = file.pscore;
		}
		
		global.killedbitch = false;
		/* if variable_global_exists("missingspr") && sprite_exists(global.spr_missingtile) && global.missingspr != global.spr_missingtile
			global.missingspr = global.missingspr; */
	';
	event.step[0] = @' 
		if instance_exists(obj_tutorialbook)
		{
			with obj_tv 
				visible = false;
			with obj_camera 
				visible = false;
		} 
		if self[$ "scr_load_file"] == undefined
		{
			scr_load_file = function(filename) // Lowkey ripped this from my modloader
			{
				var _gml = "";
				if file_exists(filename)
				{
					var _file = buffer_load(filename);
					if buffer_get_size(_file) > 0
						_gml = buffer_read(_file, buffer_string);
					buffer_delete(_file); 
				}
				return _gml;
			}
		}
		if self[$ "add_afom_rooms"]  == undefined
		{
			add_afom_rooms = function() 
			{
				for (var i = 0, i_len3 = array_length(global.levelmemory);i < i_len3;i++) 
				{
				    var rm = room_add();
				    room_set_width(rm, global.levelmemory[i].width);
				    room_set_height(rm, global.levelmemory[i].height);
				    room_set_camera(rm, 0, camera_create_view(0, 0, 960, 540, 0, noone, 0, 0, 1080, 1280)); 
					var file = global.levelmemory[i]; 
					for (var b = 0, i_len6 = array_length(file.instances);b < i_len6;b++)
					{
						var j = file.instances[b];
						
						if is_real(j.object)
							j.object = cyopconvertlist[$ (real(j.object) - 1)] != undefined ? cyopconvertlist[$ (real(j.object) - 1)] : "obj_null";
						if j.object == "obj_iceblockOLD" 
							j.object = "obj_iceblock_strongcold";
						if j.object == "obj_doorG" 
							j.object = "epicboogaloo";
						if j.object == "obj_soundtest_gus" 
							j.object = "obj_sprite";
						
						var hobject = asset_get_index(j.object);
						
						if !is_array(global.afomobjects[$ rm]) 
							global.afomobjects[$ rm] = [];
						
						if (hobject == -1 || hobject == obj_startgate) && !j.deleted
						{
							array_push(global.afomobjects[$ rm], 
							{
								object : room_instance_add(rm, j.variables.x - file.roomX, j.variables.y - file.roomY, obj_text),
								variables : {x : j.variables.x, y : j.variables.y, levelName : variable_struct_exists(j.variables, "levelName") ? j.variables.levelName : "", bgsprite : variable_struct_exists(j.variables, "bgsprite") ? j.variables.bgsprite : "spr_null", sprite_index : variable_struct_exists(j.variables, "sprite_index") ? j.variables.sprite_index : "spr_null", text : j.object} 
							}); 
						} 
						else if hobject != -1 && hobject != obj_startgate && !j.deleted
						{
							array_push(global.afomobjects[$ rm], 
							{
								object : room_instance_add(rm, j.variables.x - file.roomX, j.variables.y - file.roomY, hobject),
								variables : j.variables
							});
						} 
					}
					
					var room_name = global.levelmemory[i].room_name;
					
				    global.levelmemory[i].room_index = rm;
				    global.rooms[$ room_name] = rm;
				} 
				exit;
			}
		}
		
		
		with obj_player1
		{
			if state == 16 
				instance_destroy(instance_place(x + move_h, y + move_v, obj_destructibles));
			if state == 34
				instance_destroy(instance_place(x + sign(hsp), y, obj_ratblock));
			if place_meeting(x, y, obj_startgate) && key_up && grounded && (state == 0 or state == 104 or state == 121) && !instance_exists(obj_noisesatellite) && !instance_exists(obj_fadeout) && state != 98 && state != 95 && obj_player1.spotlight == 1 
			{
				var startgateid = instance_place(x, y, obj_startgate);
				global.levelname = startgateid.levelName;
				
				var rom_name = variable_struct_get_names(global.rooms);
				for (var i = 0;i < array_length(rom_name);i++) 
				{
					var roms = rom_name[i];
					if room_exists(global.rooms[$ roms]) 
						room_instance_clear(global.rooms[$ roms]);
				}
				global.afomobjects = {};
				global.rooms = {};
				
				for (var rooms = file_find_first(other.path + other.levels[other.selected].name + "/levels/" + global.levelname + "/rooms" + "/*.json", 0);rooms != "";rooms = file_find_next())
				{
					var file = json_parse(other.scr_load_file(other.path + other.levels[other.selected].name + "/levels/" + global.levelname + "/rooms/" + rooms));
					var meini_file = other.path + other.levels[other.selected].name + "/levels/" + global.levelname + "/level.ini"; 
					var _song = -4;
					
					if variable_global_exists(file.properties.song) 
						_song = variable_global_get(file.properties.song);
					else if variable_struct_exists(other.music_map, file.properties.song) 
						_song = other.music_map[$ file.properties.song];
					
					ini_open(meini_file);
					
					var escapelen = ini_read_real("data", "escape", 0);
					var reqscore = ini_read_real("data", "pscore", 0);
					
				    array_push(global.levelmemory,
					{
				        room_name : string_replace(rooms, ".json", ""),
				        width : file.properties.levelWidth + abs(file.properties.roomX),
				        height : file.properties.levelHeight + abs(file.properties.roomY),
						song : _song, 
				        roomX : file.properties.roomX, 
				        roomY : file.properties.roomY, 
				        instances : file.instances,
				        tile_data : file.tile_data,
						backgrounds : file.backgrounds, 
						escape : escapelen, 
						pscore : reqscore
				    });
					
					ini_close();
				}
				
				file_find_close();
				other.add_afom_rooms();
				
				var my_target = variable_struct_exists(global.rooms, "main_wfixed") ? global.rooms[$ "main_wfixed"] : global.rooms[$ "main"];
				
				with startgateid
					targetRoom = my_target;
				
				global.leveltorestart = my_target; 
			} 
		} 
		with obj_tutorialbook if showgranny
		{
			if place_meeting(x, y, obj_player) 
				sprite_index = talkspr;
			else
				sprite_index = idlespr;
		} 
		if !ds_queue_empty(download_queue) && !downloading
		{
			var d = ds_queue_head(download_queue);

			if !file_exists(d.name)
			{
				downloading = true;
			    http_get_file(d.file, d.name);
			} 
			else
			{
				variable_global_set(string_replace_all(d.name, ".png", ""), sprite_add(d.name, 0, 0, 0, 0, 0));
				ds_queue_dequeue(download_queue);
			} 
		} 
		if levelLoaded
			exit;
		scr_getinput();
		move = (key_down2 - key_up2);
		if move != 0
		{
			selected += move;
			scr_soundeffect(sfx_step);
		}
		// i know i couldve handled the tab system better but i dont know how i wouldve did it
		var current_tab_len = (tab == 0 ? array_length(levels) : array_length(options));
		selected = cycle(selected, 0, current_tab_len);
		if key_shoot2
			tab++;
		tab = cycle(tab, 0, array_length(tabs) - 1);
		if key_jump
		{
			if tab == 0 
			{
				instance_activate_all();
				audio_stop_sound(mu_editor);
				audio_resume_all();
				scr_soundeffect(sfx_collectpizza);
				var my_ini = file_find_first(path + levels[selected].name + "/*.ini", 0);
				file_find_close();
				// show_message_async(my_ini);
				ini_open(path + levels[selected].name + "/" + my_ini);
				global.levelname = ini_read_string("properties", "mainlevel", "Ass");
				ini_close();
				
				for (var audios = file_find_first(path + levels[selected].name + "/audio/*.ogg", 0);audios != "";audios = file_find_next())
				{
					var audio = audio_create_stream(path + levels[selected].name + "/audio/" + audios);
					variable_global_set(string_replace(audios, ".ogg", ""), audio);
				}
				for (var rooms = file_find_first(path + levels[selected].name + "/levels/" + global.levelname + "/rooms" + "/*.json", 0);rooms != "";rooms = file_find_next())
				{
					var file = json_parse(scr_load_file(path + levels[selected].name + "/levels/" + global.levelname + "/rooms/" + rooms));
					var meini_file = path + levels[selected].name + "/levels/" + global.levelname + "/level.ini"; 
					var _song = -4;
					
					if variable_global_exists(file.properties.song) 
						_song = variable_global_get(file.properties.song);
					else if variable_struct_exists(music_map, file.properties.song) 
						_song = music_map[$ file.properties.song];
					
					ini_open(meini_file);
					var escapelen = ini_read_real("data", "escape", 0);
					var reqscore = ini_read_real("data", "pscore", 0);
				    array_push(global.levelmemory,
					{
				        room_name : string_replace(rooms, ".json", ""),
				        width : file.properties.levelWidth + abs(file.properties.roomX),
				        height : file.properties.levelHeight + abs(file.properties.roomY),
						song : _song, 
				        roomX : file.properties.roomX, 
				        roomY : file.properties.roomY, 
				        instances : file.instances,
				        tile_data : file.tile_data,
						backgrounds : file.backgrounds, 
						escape : escapelen, 
						pscore : reqscore
				    });
					ini_close();
				}
				file_find_close();
				
				if loadcustomsprites
				{
					if self[$ "find_files_recursive"] == undefined
					{
						find_files_recursive = function(folder, ext, max)
						{
						    var dirQueue = ds_queue_create();
						    var fileArray = [];
						    ds_queue_enqueue(dirQueue, folder);
						    var startDepth = string_count("/", folder);
						    
						    while !ds_queue_empty(dirQueue)
						    {
						        var currDir = ds_queue_dequeue(dirQueue);
						        for (var fold = file_find_first(currDir + "*", fa_directory);fold != "";fold = file_find_next())
						        {
						            var check = fold + "/";
						            if directory_exists(currDir + check)
						            {
						                if max == undefined or string_count("/", currDir + check) - startDepth <= max
						                    ds_queue_enqueue(dirQueue, currDir + check);
						            }
						        }
						        file_find_close();
						        
						        var file = file_find_first(currDir + "*" + ext, 0);
						        for (var file = file_find_first(currDir + "*" + ext, 0);file != "";file = file_find_next())
						        {
						            if !directory_exists(currDir + file)
						                array_push(fileArray, currDir + file);
						        }
						        file_find_close();
						    }
						    
						    return fileArray;
						}
					}
					var sprites = find_files_recursive(path + levels[selected].name + "/sprites/", ".png");
					for (var i = 0, sprite_len = array_length(sprites);i < sprite_len;i++)
					{
						var ini_file = string_replace(sprites[i], ".png", ".ini");
						var offset = [0, 0];
					    var centered = false;
					    var my_width = 0;
						var frames = 1;
						var tileset = false;
						var tile_size = 0;
						if file_exists(ini_file) 
						{
							ini_open(ini_file);
							offset = [ini_read_real("offset", "x", 0), ini_read_real("offset", "y", 0)];
							frames = ini_read_real("properties", "images", 0);
							centered = ini_read_real("offset", "centered", false);
							my_width = ini_read_real("properties", "image_width", 0);
							if ini_section_exists("tileset") 
							{
								tileset = true;
								tile_size = abs(int64(ini_read_real("tileset", "size", 0)));
							} 
							ini_close();
						} 
						if my_width > 0
					    {
					        var fake_peppino = sprite_add(sprites[i], 1, 0, 0, 0, 0);
					        frames = sprite_get_width(fake_peppino) / my_width;
					        sprite_delete(fake_peppino);
					    }
						var spr = sprite_add(sprites[i],frames, 0, 0, 0, 0);
						sprite_set_speed(spr, 60, 60);
						if centered
					    {
					        offset[0] += sprite_get_width(spr) / 2;
					        offset[1] += sprite_get_height(spr) / 2;
					    }
					    sprite_set_offset(spr, offset[0], offset[1])
						if tileset
							global.tileset_sizes[$ spr] = tile_size;
						var sprname = string_copy(string_replace(sprites[i], levels[selected].name + "/sprites/", ""), string_pos(levels[selected].name + "/sprites/", sprites[i]), string_length(sprites[i]));
						global.sprites[$ string_replace(sprname, ".png", "")] = spr;
					}
				}
				
				add_afom_rooms();
				
				var my_target = variable_struct_exists(global.rooms, "main_wfixed") ? global.rooms[$ "main_wfixed"] : global.rooms[$ "main"];
				
				with obj_player
				{
					state = 95;
					movespeed = 0;
					hsp = 0;
					vsp = 0;
					targetRoom = my_target;
					targetDoor = "A";
					global.leveltorestart = my_target;
				}
				
				instance_create(0, 0, obj_fadeout);
				levelLoaded = true;
			} 
			else
			{
				variable_instance_set(id, options[selected].variable, !variable_instance_get(id, options[selected].variable));
				options[selected].enabled = !options[selected].enabled;
				scr_soundeffect(sfx_enemyprojectile);
			} 
		}
	';
	event.draw[0] = @'
		if !levelLoaded
			exit;
		if self[$ "draw_sprite_tiled_direction"] == undefined // NO IDEA HOW THIS WORKED
		{
			draw_sprite_tiled_direction = function(spr, ind, _x, _y, tilx, tily)
			{
			    var w = sprite_get_width(spr);
			    var h = sprite_get_height(spr);
			    if tilx && tily
			        draw_sprite_tiled(spr, ind, _x, _y);
			    else
			    {
			        var xx = _x;
			        var yy = _y;
			        var cx = camera_get_view_x(view_camera[0]);
			        var cy = camera_get_view_y(view_camera[0]);
			        var cw = camera_get_view_width(view_camera[0]);
			        var ch = camera_get_view_height(view_camera[0]);
			        
			        if tilx
			        {
			            while (xx < cx - w)
			                xx += w;
			            while (xx > cx - w)
			                xx -= w;
			            for (var i = xx; i < cx + cw + w; i += w)
			                draw_sprite(spr, ind, i, yy);
			        }
			        else if tily
			        {
			            while (yy < cy - h)
			                yy += h;
			            while (yy > cy - h)
			                yy -= h;
			            for (var i = yy; i < cy + ch + h; i += h)
			                draw_sprite(spr, ind, xx, i);
			        }
					if !tilx && !tily
						draw_sprite(spr, ind, _x, _y);
			    }
				exit;
			} 
		}
		var m_len = array_length(global.levelmemory);
		for (var m = 0;m < m_len;m++)
		{
			var lev = -1;
			if room == global.levelmemory[m].room_index
			{
			    lev = m;
			    break;
			}
		}
		if tilebetterload
		{
			if loadtimer > 0
				loadtimer--;
			for (var m2 = 0;m2 < m_len;m2++) 
			{
				var file = global.levelmemory[m2]
				if !variable_struct_exists(file, "tileset_sprite") && loadtimer <= 0
				{
					if surface_exists(tilemap_surface)
						surface_free(tilemap_surface);
					if !surface_exists(tilemap_surface)
						tilemap_surface = surface_create(clamp(file.width, 0, 16384), clamp(file.height, 0, 16384));
					
					var j = file.tile_data;
							
					if variable_struct_names_count(j) > 0
					{
						surface_set_target(tilemap_surface);
						draw_clear_alpha(c_black, 0);  
						var arr_names1_all = variable_struct_get_names(j);
						var o_len = array_length(arr_names1_all);
						for (var i = 1;i < o_len;i++)
						{
							var this = arr_names1_all[i];
						    var z = i - 1;
						    while (z >= 0 && real(arr_names1_all[z]) < real(this))
						    {
						        arr_names1_all[z + 1] = arr_names1_all[z];
						        z--;
						    }
						    arr_names1_all[z + 1] = this;
						}
						
						for (var o = 0;o < o_len;o++)
						{
							var arr_names1 = arr_names1_all[o];
							var arr_names2_all = variable_struct_get_names(j[$ arr_names1]);
							
							if real(arr_names1) <= -5
								continue;
							
							for (var n = 0, n_len = array_length(arr_names2_all);n < n_len;n++)
							{
							    var arr_names2 = arr_names2_all[n];
							    var data = j[$ arr_names1][$ arr_names2];
							    var pos = string_split(arr_names2 + "_", "_"); // die sr perez Die
								var customsprlol = variable_struct_exists(global.sprites, data.tileset);
								
								var tile_x = real(pos[1]) - file.roomX;
								var tile_y = real(pos[2]) - file.roomY;
								var tile_size = 32;
								
								if customsprlol 
									tile_size = variable_struct_exists(global.tileset_sizes, global.sprites[$ data.tileset]) ? global.tileset_sizes[$ global.sprites[$ data.tileset]] : 32;
								
								var flipX = variable_struct_exists(data, "flipX") ? data.flipX : 1; // does this exist in old cyop?
								var flipY = variable_struct_exists(data, "flipY") ? data.flipY : 1;
								if flipX == -1
									tile_x += tile_size;
								if flipY == -1
									tile_y += tile_size;
							    draw_sprite_part_ext(customsprlol ? global.sprites[$ data.tileset] : (asset_get_index(data.tileset) != -1 ? asset_get_index(data.tileset) : global.missingspr), 0, data.coord[0] * tile_size, data.coord[1] * tile_size, tile_size, tile_size, tile_x, tile_y, flipX, flipY, c_white, 1);
							}
						}
						surface_reset_target();
						global.levelmemory[m2].tileset_sprite = sprite_create_from_surface(tilemap_surface, 0, 0, surface_get_width(tilemap_surface), surface_get_height(tilemap_surface), false, false, 0, 0);
						loadtimer = 1;
					}
					else
						global.levelmemory[m2].tileset_sprite = spr_null;
				}
			} 
		} 
		if lev != -1
		{
			var file = global.levelmemory[lev];
			var bg = file.backgrounds;
			var p_len = array_length(bg_names);
			var p = 0;
			while (p < p_len)
			{
				var bg_name = bg_names[p];
				var data = bg[$ bg_name];
				var customsprlol = variable_struct_exists(global.sprites, data.sprite);
				var cam_x = camera_get_view_x(view_camera[0]);
				var cam_y = camera_get_view_y(view_camera[0]); 
				data.x += data.hspeed;
				data.y += data.vspeed;
				if data[$ "ind"] == undefined
					data.ind = 0;
				data.ind += data.image_speed / 60;
				draw_sprite_tiled_direction(customsprlol ? global.sprites[$ data.sprite] : (asset_get_index(data.sprite) != -1 ? asset_get_index(data.sprite) : bg_space1), data.ind, data.x + cam_x * (1 - data.scroll_x), data.y + cam_y * (1 - data.scroll_y), data.tile_x, data.tile_y);
				p++;
			} 
			if !surface_exists(tilemap_surface)
				tilemap_surface = surface_create(clamp(file.width, 0, 16384), clamp(file.height, 0, 16384));
			if !tilebetterload
			{
				if !variable_struct_exists(file, "tileset_sprite")
				{
					if !surface_exists(tilemap_surface)
						tilemap_surface = surface_create(clamp(file.width, 0, 16384), clamp(file.height, 0, 16384));
					var j = file.tile_data;
					if variable_struct_names_count(j) > 0
					{
						surface_set_target(tilemap_surface);
						draw_clear_alpha(c_black, 0);  
						var arr_names1_all = variable_struct_get_names(j);
						var o_len = array_length(arr_names1_all);
						for (var i = 1;i < o_len;i++)
						{
						    var this = arr_names1_all[i];
						    var z = i - 1;
						    while (z >= 0 && real(arr_names1_all[z]) < real(this))
						    {
						        arr_names1_all[z + 1] = arr_names1_all[z];
						        z--;
						    }
						    arr_names1_all[z + 1] = this;
						}
						
						for (var o = 0;o < o_len;o++)
						{
							var arr_names1 = arr_names1_all[o];
							var arr_names2_all = variable_struct_get_names(j[$ arr_names1]);
							
							if real(arr_names1) <= -5
								continue;
							
							for (var n = 0, n_len = array_length(arr_names2_all);n < n_len;n++)
							{
							    var arr_names2 = arr_names2_all[n];
							    var data = j[$ arr_names1][$ arr_names2];
							    var pos = string_split(arr_names2 + "_", "_"); // die sr perez Die
								var customsprlol = variable_struct_exists(global.sprites, data.tileset);
								
								var tile_x = real(pos[1]) - file.roomX;
								var tile_y = real(pos[2]) - file.roomY;
								var tile_size = 32;
								
								if customsprlol 
									tile_size = variable_struct_exists(global.tileset_sizes, global.sprites[$ data.tileset]) ? global.tileset_sizes[$ global.sprites[$ data.tileset]] : 32;
								
								var flipX = variable_struct_exists(data, "flipX") ? data.flipX : 1; // does this exist in old cyop?
								var flipY = variable_struct_exists(data, "flipY") ? data.flipY : 1;
								if flipX == -1
									tile_x += tile_size;
								if flipY == -1
									tile_y += tile_size;
							    draw_sprite_part_ext(customsprlol ? global.sprites[$ data.tileset] : (asset_get_index(data.tileset) != -1 ? asset_get_index(data.tileset) : global.missingspr), 0, data.coord[0] * tile_size, data.coord[1] * tile_size, tile_size, tile_size, tile_x, tile_y, flipX, flipY, c_white, 1);
							}
						}
						surface_reset_target();
						global.levelmemory[lev].tileset_sprite = sprite_create_from_surface(tilemap_surface, 0, 0, surface_get_width(tilemap_surface), surface_get_height(tilemap_surface), false, false, 0, 0);
					}
					else
						global.levelmemory[lev].tileset_sprite = spr_null;
				}
			}
			draw_sprite(file.tileset_sprite, 0, 0, 0);
		} 
		with obj_tutorialbook if image_visible 
			draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	';
	event.draw_gui[0] = @'
		draw_set_font(-1);
		draw_set_color(c_red);
		draw_set_halign(fa_left);
		draw_set_valign(fa_bottom);
		if array_length(global.errorlist) > 0
		{
			for (var i = 0, i_len = array_length(global.errorlist);i < i_len;i++) 
			{
				var errorlist = string(global.errorlist[i]);
				draw_text(16, display_get_gui_height() + (16 * i) - array_length(global.errorlist) * 16, errorlist);
			} 
		} 
		with obj_tutorialbook if text_y > -(text_sprite_height * text_yscale)
		{
			var xx = text_borderpad + text_wave_x;
			var yy = text_y + text_wave_y;
			var text_xscale_fixed = (display_get_gui_width() - 64) / sprite_get_width(spr_tutorialbubble);
			tex_x -= 0.5;
			var w = (sprite_get_width(bubble_spr) * text_xscale_fixed);
		    var h = (sprite_get_height(bubble_spr) * text_yscale);
			
		    if !surface_exists(surfclip)
		        surfclip = surface_create(w, h);
		    if !surface_exists(surffinal)
		        surffinal = surface_create(w, h);
			
		    surface_set_target(surfclip);
		    draw_clear_alpha(c_black, 1);
			gpu_set_blendmode(bm_subtract);
		    draw_sprite_ext(bubble_spr, 0, 0, 0, text_xscale_fixed, text_yscale, 0, c_white, 1);
			gpu_set_blendmode(bm_normal);
		    surface_reset_target();
		
		    surface_set_target(surffinal);
			draw_clear_alpha(c_black, 0);
		    draw_sprite_tiled(background_spr, 0, tex_x, tex_x);
			gpu_set_blendmode(bm_subtract);
		    draw_surface(surfclip, 0, 0);
			gpu_set_blendmode(bm_normal);
		    surface_reset_target();
			
		    draw_surface(surffinal, xx, yy);
			draw_sprite_ext(bubble_spr, 1, xx, yy, text_xscale_fixed, text_yscale, 0, c_white, 1);
			draw_set_halign(0);
			draw_set_valign(0);
			draw_set_font(font);
			scr_draw_text_arr(xx + text_contentpad, yy + text_contentpad, text_arr, text_color,  2);
		} 
		if levelLoaded
			exit;
		if levels[selected].bg == "none" || tab == 1
			draw_sprite(variable_global_exists("spr_nighttower") ? global.spr_nighttower : spr_null, 0, 0, 0);
		if levels[selected].bg != "none" && tab == 0
			draw_sprite(levels[selected].bg, 0, 0, 0);
		draw_set_font(global.bigfont);
		draw_set_valign(fa_middle);
		draw_set_halign(fa_right);
		if tab == 0
		{
			for (var a = 0;a < array_length(levels);a++)
			{
				draw_set_color(a == selected ? c_white : c_gray);
				var width = string_width(string_upper(levels[a].ininame));
				var xscale = min(width, display_get_gui_width() - 20) / width;
				scrolling = lerp(scrolling, -selected * 32, 0.05);
				draw_text_transformed(16 + (width * xscale) + (levels[a].icon != "none" ? sprite_get_width(levels[a].icon) : 0), display_get_gui_height() / 2 + scrolling + ((string_height(global.bigfont) + 4) * a), string_upper(levels[a].ininame), xscale, 1, 0);
				if levels[a].icon != "none" 
					draw_sprite(levels[a].icon, 0, 16, display_get_gui_height() / 2 + scrolling + ((string_height(global.bigfont) + 4) * a) - sprite_get_height(levels[a].icon) / 2);
			} 
		} 
		else 
		{
			for (var i = 0, opti_len = array_length(options);i < opti_len;i++) 
			{
				draw_set_color(i == selected ? c_white : c_gray);
				var width = string_width(concat(options[i].text, " : ", options[i].enabled ? "ON" : "OFF"));
				var xscale = min(width, display_get_gui_width() - 20) / width;
				draw_text(16 + width, display_get_gui_height() / 2 + ((string_height(global.bigfont) + 4) * i), concat(options[i].text, " : ", options[i].enabled ? "ON" : "OFF"));
			} 
		} 
	';
	event.http[0] = @'
		var status = async_load[? "status"];
		if status == 0
		{
		    var d = ds_queue_head(download_queue);
			
			if file_exists(d.name)
				variable_global_set(string_replace_all(d.name, ".png", ""), sprite_add(d.name, 0, 0, 0, 0, 0));
			ds_queue_dequeue(download_queue);
			downloading = false;
		}
		else
		{
			ds_queue_dequeue(download_queue);
			downloading = false;
		} 
	';
	docommand("reload_gml");
}
