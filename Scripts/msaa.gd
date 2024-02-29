extends HBoxContainer


@onready var options_button = $OptionsButton


func _ready():
	options_button.add_item("off")
	options_button.add_item("x 2")
	options_button.add_item("x 4")
	options_button.add_item("x 8")
	if Save.settings_data.has("msaa"):
		var index = Save.settings_data.get("msaa")
		options_button.select(index)


func _on_check_button_item_selected(index):
	SoundManager.play_click()
	Save.settings_data["msaa"] = index
	Save.save_settings()
	Settings.load_msaa_settings()


func _on_check_button_pressed():
	SoundManager.play_click()
