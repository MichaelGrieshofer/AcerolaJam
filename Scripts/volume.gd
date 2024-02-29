extends HSlider

@export var bus: String = "Master" 

var bus_index

func _ready():
	bus_index = AudioServer.get_bus_index(bus)
	if bus_index != -1:
		var v = AudioServer.get_bus_volume_db(bus_index)
		value = db_to_linear(v)


func _on_value_changed(value):
	if bus_index != -1:
		if Save.settings_data.has("audio_server"):
			change_value(bus_index,linear_to_db(value))
		else:
			Save.settings_data["audio_server"] = {}
			change_value(bus_index,linear_to_db(value))
	else:
		print("No bus called: *",bus, "* exists")


func change_value(bus_index,value):
	var server = Save.settings_data.get("audio_server") as Dictionary
	server[bus_index] = value
	Save.save_settings()
	Settings.load_audio_settings()



func _on_drag_ended(value_changed):
	SoundManager.play_click()
