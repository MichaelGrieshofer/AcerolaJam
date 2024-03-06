class_name Hitbox
extends Area2D

@export var damage: int = 10

@export var hurts_enemies: bool = false
@export var hurts_player: bool = true
@export var hurts_mech: bool = true

@export var destroy_player: bool = false

signal hit

func _ready():
	area_entered.connect(hit_hurtbox)


func hit_hurtbox(area):
	if area is Hurtbox:
		if area.enemy and hurts_enemies:
			hit.emit()
		if area.player and hurts_player:
			hit.emit()
		if area.mech and hurts_mech:
			hit.emit()
