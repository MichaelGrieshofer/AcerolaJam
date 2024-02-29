extends Button

@export var show_icon = true
@onready var action = InputMapping.input_map_keys.keys()[key]
@onready var action_icon = $ActionIcon

var key : InputMapping.input_map_keys
var moused_over = false
var is_input_ready = false
var has_icon = true

func _ready():
	InputMapping.disable_focus_mode.connect(func(): focus_mode = Control.FOCUS_NONE )
	InputMapping.enable_focus_mode.connect(func(): focus_mode = Control.FOCUS_ALL )
	InputMapping.mappings_applied.connect(func(): has_icon = true)
	display_key()


func display_key():
	if show_icon and has_icon:
		action_icon.action_name = action
		action_icon.visible = true
		text = ""
	else:
		var event = InputMap.action_get_events(action)[0]
		text = str(event.as_text())
		action_icon.visible = false


func _on_pressed():
	if !is_input_ready:
		call_deferred("input_ready")


func input_ready():
	InputMapping.disable_focus_mode.emit()
	is_input_ready = true
	disabled = true
	text = "..."
	action_icon.visible = false
	SoundManager.play_click()


func disable_input_ready():
	InputMapping.enable_focus_mode.emit()
	is_input_ready = false
	disabled = false
	display_key()
	SoundManager.play_click()
	grab_focus()


func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		if is_input_ready:
			remap_key(event)
			call_deferred("disable_input_ready")


func remap_key(event):
	if !Save.settings_data.has("key_bindings"):
		Save.settings_data["key_bindings"] = {}
	save_mapping(event)


func save_mapping(event):
	var bindings = Save.settings_data.get("key_bindings") as Dictionary
	if event is InputEventKey:
		bindings[action] = Vector2(0,event.keycode)
	if event is InputEventMouseButton:
		bindings[action] = Vector2(1,event.button_index)
	InputMapping.apply_mapping()


func _on_action_icon_no_icon_found():
	has_icon = false
	call_deferred("display_key")
