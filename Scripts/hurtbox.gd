class_name Hurtbox
extends Area2D

@export var health_manager: HealthManager

func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D):
	if area.is_in_group("Danger"):
		health_manager.modify_health(-10)
