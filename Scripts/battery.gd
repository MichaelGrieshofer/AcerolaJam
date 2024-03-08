extends Node2D


func _on_interaction_area_interaction_triggered():
	Signals.refill_player_health.emit()
