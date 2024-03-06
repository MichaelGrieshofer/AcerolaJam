extends Node2D


func _on_health_manager_health_depleted():
	queue_free()
