class_name HealthManager
extends Node

@export var max_health: float = 100
@export var print_health: bool = false
@export var death_effect = preload("res://Nodes/Effects/explosion.tscn")

signal health_modified(amount,new_hp)
signal took_damage(amount,new_hp)
signal recieved_healing(amount,new_hp)
signal health_depleted

var current_hp: float = 0

var dead: bool = false


func _ready():
	set_health(max_health)


func _physics_process(delta):
	if print_health:
		print(current_hp)


func set_health(new_health):
	current_hp = new_health
	health_modified.emit(current_hp,current_hp)


func modify_health(amount):
	current_hp += amount
	health_modified.emit(amount,current_hp)
	if amount > 0:
		recieved_healing.emit(amount,current_hp)
	elif amount < 0:
		took_damage.emit(amount,current_hp)
	if current_hp <= 0:
		health_depleted.emit()
		spawn_death_effect()
	current_hp = clamp(current_hp,0,max_health)


func spawn_death_effect():
	if death_effect != null and !dead:
		dead = true
		var new_death_effect = death_effect.instantiate()
		new_death_effect.global_position = get_parent().global_position
		Bullets.add_child(new_death_effect)
