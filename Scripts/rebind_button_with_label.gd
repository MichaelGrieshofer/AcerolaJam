extends HBoxContainer

@export var key : InputMapping.input_map_keys
@onready var action = InputMapping.input_map_keys.keys()[key]

func _ready():
	for i in get_children():
		if i.is_in_group("KeyRebindButton"):
			i.key = key
			i._ready()
		if i.is_in_group("ActionLabel"):
			i.text = str(action).capitalize()



