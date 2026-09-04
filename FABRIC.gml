// this code base is horrible to work with

global.characters = {}; // character code : struct
global.customObjects = {};

instance_destroy(obj_custom_object);
instance_destroy(obj_custom_object_ext);

with (instance_create(0, 0, obj_custom_object))
{
	persistent = 1;
	image_alpha = 0;
	depth = -9999;
	mods = [];
	
	get_user_directory = function() // simple function that i will not be using for all of time probably
	{
		switch os_type
		{
			case os_windows:
				return "C:/Users/" + environment_get_variable("USERNAME") + "/Documents/pizza tower android/";
			break;
			
			case os_android:
				return "/storage/emulated/0/Documents/pizza tower android/";
			break;
		}
	}
	
	game_directory = get_user_directory();
	path = game_directory + "mods/";
	
	if !directory_exists(game_directory)
		directory_create(game_directory);
	
	if !directory_exists(path)
		directory_create(path);
	
	show_message_async(path);
	
	selected = 0;
	scrolling = 0;
	
	scr_load_file = function(filename)
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
	
	Mod_object = function(_path) constructor
	{
		file_path = _path;
		events = {};
	}
	
	init_function = function()
	{
		var m = self;
		var api = "globalvar MOD_PATH = \"" + m.file_path + "\";#globalvar MOD_GLOBAL = {};#";
		
		var snippet = live_snippet_create(string_hash_to_newline(api + "#") + scr_load_file(m.file_path + "/init.gml"));
		if live_snippet_call(snippet){} else get_string_async("Your mod fucked up!", "Runtime error for mod \"" + m.name + "\" init.gml :\n" + global.live_result);
	}
	
	Mod = function(_file_path, _name, _desc, _enabled, _icon, _init = init_function) constructor // constructors my beloved
	{
		file_path = _file_path;
		name = _name;
		desc = _desc;
		enabled = _enabled;
		was_enabled = _enabled;
		icon = _icon;
		
		objects = {};
		
		init = method(self, _init);
	}
	
	scr_mod_process_objects = function(struct)
	{
		if directory_exists(struct.file_path + "/objects")
		{
			for (var object_names = file_find_first(struct.file_path + "/objects/" + "*", fa_directory); object_names != ""; object_names = file_find_next())
			{
				if asset_get_index(object_names) != -1
				{
					show_message_async("Object error for \"" + object_names + "\" : Cannot have a object with the same name as an already existing object");
					break;
				}
								
				global.customObjects[$ object_names] = new Mod_object(struct.file_path + "/objects/" + object_names + "/");
			}
							
			file_find_close();
							
			for (var j = 0, names = variable_struct_get_names(global.customObjects), glen = array_length(names); j < glen; j++)
			{
				for (var event_names = file_find_first(global.customObjects[$ names[j]].file_path + "*.gml", 0); event_names != ""; event_names = file_find_next())
					global.customObjects[$ names[j]].events[$ string_replace_all(event_names, ".gml", "_event")] = scr_load_file(global.customObjects[$ names[j]].file_path + event_names);
				file_find_close();
						
				trace("Setting ", names[j], " to ", global.customObjects[$ names[j]]);
				
				var obj = global.customObjects[$ names[j]];
				
				live_variable_add(names[j], method(obj, function()
				{
					return self;
				}));
			}
		}
	}
	
	for (var mods_name = file_find_first(path + "*", fa_directory); mods_name != ""; mods_name = file_find_next())
	{
		var _path = path + mods_name;
		
		var icon = spr_null;
		var jsonstruct =
		{
			name : mods_name,
			desc : "Description is missing."
		};
		
		if file_exists(_path + "/mod.json")
			jsonstruct = json_parse(scr_load_file(_path + "/mod.json"));
		
		if file_exists(_path + "/icon.png")
			icon = sprite_add(_path + "/icon.png", 0, 0, 0, 0, 0);
		
		ini_open(_path + "/mod.ini");
		array_push(mods, new Mod(_path, jsonstruct.name, jsonstruct.desc, ini_read_real("Mod", "enabled", 0), icon));
		ini_close();
	}
	
	file_find_close();
	drawgui_event = @'
		draw_set_color(c_black);
		draw_set_alpha(0.5);
		draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false); 

		if array_length(mods) > 0
		{
			for (var i = 0, len = array_length(mods); i < len; i++)
			{
				var m = mods[i];
				
				draw_set_alpha(1);
				draw_set_color(i == selected ? c_white : c_gray);
				
				draw_set_font(global.bigfont);
				
				draw_set_valign(fa_middle);
				draw_set_halign(fa_left);
				
				var width = string_width(concat(string_upper(m.name), " : ", m.enabled ? "ON" : "OFF"));
				var xscale = min(width, display_get_gui_width() - 20) / width;
				var height = string_height("A");
				
				draw_text_transformed(16, display_get_gui_height() / 2 + (i * (height + 8)) + (scrolling * (height + 8)), concat(string_upper(m.name), " : ", m.enabled ? "ON" : "OFF"), xscale, 1, 0);
			}
			
			draw_set_alpha(0.6);
			draw_set_color(c_black);
			
			draw_rectangle(0, 480, display_get_gui_width(), display_get_gui_height(), false);
			
			draw_set_alpha(1);
			draw_set_color(c_white);
			
			draw_set_font(global.smallfont);
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_bottom);
			
			draw_text_ext_transformed(display_get_gui_width() / 2, 500 + string_height(string_upper(mods[selected].desc)), string_upper(mods[selected].desc), 16, 900, 1, 1, 0);
			
			draw_sprite_stretched(mods[selected].icon, 0,  display_get_gui_width() - 120, 70, 100, 100);
		} 
		else
		{
			draw_set_alpha(1);
			draw_set_font(-1);
			
			draw_set_color(c_white);
			draw_set_valign(fa_center);
			draw_set_halign(fa_middle);
			
			draw_text_transformed(display_get_gui_width() / 2, display_get_gui_height() / 2, string_hash_to_newline("NO MODS FOUND#PRESS X TO EXIT"), 2, 2, 0);
		} 
	';
	step_event = @'
		scr_getinput();
		
		if array_length(mods) == 0
		{
			if key_slap
			{
				instance_destroy();
				scr_soundeffect(sfx_enemyprojectile); 
			}
			exit;
		}
		
		with obj_player1
			state = 18;
		
        move = (key_down2 - key_up2);
        selected += move;
		scrolling = lerp(scrolling, selected, 0.1);
        selected = cycle(selected, 0, array_length(mods));
		
        if key_jump
        {
	        mods[selected].enabled = !mods[selected].enabled;
			ini_open(mods[selected].file_path + "/mod.ini");
			ini_write_real("Mod", "enabled", mods[selected].enabled);
			ini_close();
		}
		
        if key_slap2
        {
	        for (var i = 0, len = array_length(mods); i < len; i++)
			{
				var m = mods[i];
				
				if m.enabled
				{
					scr_mod_process_objects(m);
					
					live_function_add("instance_create(arg0, arg1, arg2)", function(arg0, arg1, arg2)
					{
						if is_struct(arg2)
						{
							var inst = instance_create_depth(arg0, arg1, object_get_depth(obj_custom_object), obj_custom_object, arg2.events);
							
							with inst
							{
								if step_event != ""
									step_event_saved = live_snippet_create(step_event);
								if draw_event != ""
									draw_event_saved = live_snippet_create(draw_event);
								if drawgui_event != ""
									drawgui_event_saved = live_snippet_create(drawgui_event);
								if roomstart_event != ""
									roomstart_event_saved = live_snippet_create(roomstart_event);
								
								if create_event != undefined && create_event != ""
								{
									snippet = live_snippet_create(create_event);
									_func = asset_get_index(script_get_name(method(self, live_snippet_call))); // prevent game from going bat shit insane
									_func(snippet);
								}
							}
						}
						else
						{
							var myDepth = object_get_depth(arg2);
							var inst = instance_create_depth(arg0, arg1, myDepth, arg2);
						}
						
						if (instance_exists(obj_fakeeditor))
						{
							with(obj_fakeeditor)
							{
								if(in_play_mode)
								{
									instances[instances_len] = inst
									instances_len++
								}
							}
						}
						
						return inst;
					});
					
					if file_exists(m.file_path + "/init.gml")
						m.init();
				}
				else if m.was_enabled != m.enabled && !m.enabled && file_exists(m.file_path + "/cleanup.gml")
				{
					var api = "";
					api += string("globalvar MOD_PATH = \"" + m.file_path + "\";#globalvar MOD_GLOBAL = {};#");
					var snippet = live_snippet_create(string_hash_to_newline(api + "#") + scr_load_file(m.file_path + "/cleanup.gml"))
					if live_snippet_call(snippet){} else get_string_async("Your mod fucked up!", "Runtime error for mod \"" + m.name + "\" in cleanup.gml :\n" + global.live_result);
				}
			}
			instance_destroy();
			scr_soundeffect(sfx_enemyprojectile);
			obj_player.state = 0;
		}
    ';docommand("reload_gml")
}
