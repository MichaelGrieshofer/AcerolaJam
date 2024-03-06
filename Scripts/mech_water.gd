extends TextureProgressBar


@export var end: Node2D


func _ready():
	Signals.mech_fuel_changed.connect(update_fuel)
	Signals.max_mech_fuel_changed.connect(update_max_fuel)


func update_fuel(new_fuel):
	value = new_fuel


func update_max_fuel(new_fuel):
	max_value = new_fuel
	var num = (max_value/50)*6
	stretch_margin_left = num/2
	stretch_margin_right = num/2
	end.position.x = num+0.5
