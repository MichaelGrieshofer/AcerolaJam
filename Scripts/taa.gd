extends HBoxContainer


func _ready():
	if Save.settings_data.has("taa"):
		var taa = Save.settings_data.get("taa")
		$CheckButton.button_pressed = taa


func _on_check_button_toggled(button_pressed):
	SoundManager.play_click()
	Save.settings_data["taa"] = button_pressed
	Save.save_settings()
	Settings.load_taa_settings()
