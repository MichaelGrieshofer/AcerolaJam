class_name Hurtbox
extends Area2D

@export var health_manager: HealthManager
@export var enemy: bool = true
@export var player: bool = true
@export var mech: bool = true

signal destroy_player_triggered

func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(area: Area2D):
	if area is Hitbox:
		if area.hurts_enemies and enemy:
			health_manager.modify_health(-area.damage)
		if area.hurts_mech and mech:
			health_manager.modify_health(-area.damage)
		if area.hurts_player and player:
			if area.destroy_player:
				destroy_player_triggered.emit()
			health_manager.modify_health(-area.damage)
