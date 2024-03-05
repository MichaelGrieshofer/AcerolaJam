extends ProgressBar


func _ready():
	Signals.mech_fuel_changed.connect(update_fuel)
	Signals.max_mech_fuel_changed.connect(update_max_fuel)


func update_fuel(new_fuel):
	value = new_fuel


func update_max_fuel(new_fuel):
	max_value = new_fuel
