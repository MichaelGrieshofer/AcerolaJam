class_name HealthManager
extends Node

@export var max_health: float = 100
@export var print_health: bool = false

signal health_modified(amount,new_hp)
signal took_damage(amount,new_hp)
signal recieved_healing(amount,new_hp)
signal health_depleted

var current_hp: float = 0


func _ready():
	set_health(max_health)


func _physics_process(delta):
	if print_health:
		print(current_hp)


func set_health(new_health):
	current_hp = new_health


func modify_health(amount):
	current_hp += amount
	health_modified.emit(amount,current_hp)
	if amount > 0:
		recieved_healing.emit(amount,current_hp)
	elif amount < 0:
		took_damage.emit(amount,current_hp)
	if current_hp <= 0:
		health_depleted.emit()
	current_hp = clamp(current_hp,0,max_health)
