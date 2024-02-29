extends HBoxContainer


func _ready():
	if Save.settings_data.has("vsync"):
		var vs = Save.settings_data.get("vsync")
		$CheckButton.button_pressed = vs


func _on_check_button_toggled(button_pressed):
	SoundManager.play_click()
	Save.settings_data["vsync"] = button_pressed
	Save.save_settings()
	Settings.load_vsync_setting()
