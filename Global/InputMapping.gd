extends Node


enum input_map_keys {
	left,
	right,
	jump,
	divekick,
	surf,
	enter_mech,
	aim,
	shoot,
	dash,
	interact,
	remote_control
	}

signal  disable_focus_mode
signal  enable_focus_mode
signal mappings_applied

func _ready():
	apply_mapping()
	create_default_mapping()


func apply_mapping():
	if Save.settings_data.has("key_bindings"):
		var bindings = Save.settings_data.get("key_bindings")
		for i in bindings:
			InputMap.action_erase_events(i)
			var bind = Save.settings_data.get("key_bindings")[i]
			if bind.x == 0:
				var new_event = InputEventKey.new()
				new_event.keycode = bindings[i].y
				InputMap.action_add_event(i,new_event)
			if bind.x == 1:
				var new_event = InputEventMouseButton.new()
				new_event.button_index = bindings[i].y
				InputMap.action_add_event(i,new_event)
	mappings_applied.emit()
	Save.save_settings()


func create_default_mapping():
	if !Save.settings_data.has("default_key_bindings"):
		Save.settings_data["default_key_bindings"] = {}
		for i in input_map_keys.keys():
			var event = InputMap.action_get_events(i)[0]
			if event is InputEventKey:
				Save.settings_data.get("default_key_bindings")[i] = Vector2(0,event.keycode)
			if event is InputEventMouseButton:
				Save.settings_data.get("default_key_bindings")[i] = Vector2(1,event.button_index)
			Save.save_settings()


func revert_mapping():
	if Save.settings_data.has("default_key_bindings"):
		if Save.settings_data.has("key_bindings"):
			var bindings = Save.settings_data.get("key_bindings")
			for i in bindings:
				InputMap.action_erase_events(i)
				var bind = Save.settings_data.get("default_key_bindings")[i]
				if bind.x == 0:
					var new_event = InputEventKey.new()
					new_event.keycode = bind.y
					bindings[i].x = 0
					bindings[i].y = new_event.keycode
				if bind.x == 1:
					var new_event = InputEventMouseButton.new()
					new_event.button_index = bind.y
					bindings[i].x = 1
					bindings[i].y = new_event.button_index
		apply_mapping()
	get_tree().call_group("KeyRebindButton","display_key")
