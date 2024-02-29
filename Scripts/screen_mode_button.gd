extends OptionButton


func _ready():
	add_item("fullscreen")
	add_item("borderless fullscreen")
	add_item("windowed")
	if Save.settings_data.has("screen_mode_settings"):
		var index = Save.settings_data.get("screen_mode_settings")
		select(index)


func _on_item_selected(index):
	SoundManager.play_click()
	Save.settings_data["screen_mode_settings"] = index
	Save.save_settings()
	Settings.load_screen_mode_settings()


func _on_pressed():
	SoundManager.play_click()
