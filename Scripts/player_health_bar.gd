extends ProgressBar


func _ready():
	Signals.player_health_changed.connect(update_health)
	Signals.max_player_health_changed.connect(update_max_health)


func update_health(new_health):
	value = new_health


func update_max_health(new_health):
	max_value = new_health
