extends Node


func _ready():
	load_audio_settings()
	load_screen_mode_settings()
	load_vsync_setting()
	load_msaa_settings()
	load_taa_settings()


func load_audio_settings():
	if Save.settings_data.has("audio_server"):
		var server = Save.settings_data.get("audio_server") as Dictionary
		for i in server:
			AudioServer.set_bus_volume_db(i, server[i])


func load_screen_mode_settings():
	if Save.settings_data.has("screen_mode_settings"):
		var index = Save.settings_data.get("screen_mode_settings")
		match  index:
			0:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			1:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			2:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		Save.settings_data["screen_mode_settings"] = 2
		Save.save_settings()


func load_vsync_setting():
	if Save.settings_data.has("vsync"):
		var vs = Save.settings_data.get("vsync")
		if vs:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		else:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	else:
		Save.settings_data["vsync"] = true


func load_msaa_settings():
	if Save.settings_data.has("msaa"):
		var index = Save.settings_data.get("msaa")
		match index:
			0:
				RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(),RenderingServer.VIEWPORT_MSAA_DISABLED)
			1:
				RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(),RenderingServer.VIEWPORT_MSAA_2X)
			2:
				RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(),RenderingServer.VIEWPORT_MSAA_4X)
			3:
				RenderingServer.viewport_set_msaa_3d(get_viewport().get_viewport_rid(),RenderingServer.VIEWPORT_MSAA_8X)
	else:
		Save.settings_data["msaa"] = 2


func load_taa_settings():
	if Save.settings_data.has("taa"):
		var taa = Save.settings_data.get("taa")
		RenderingServer.viewport_set_use_taa(get_viewport().get_viewport_rid(),taa)
	else:
		Save.settings_data["taa"] = true

