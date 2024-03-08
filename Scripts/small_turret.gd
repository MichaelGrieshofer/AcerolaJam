extends Node2D


@export var offset: float = 0.0
@export var reload: float = 1.0
@export var rotation_advance: float = 0.0

@onready var bullet: = preload("res://Nodes/Actors/small_turret_bullet.tscn")

@onready var marker: Marker2D = $Marker2D
@onready var reload_timer: Timer = $Reload
@onready var offset_timer: Timer = $Offset
@onready var vis: VisibleOnScreenNotifier2D = $VisibleOnScreenEnabler2D


func _ready():
	reload_timer.wait_time = reload
	if offset > 0.0:
		offset_timer.wait_time = offset
		offset_timer.start()
	else:
		reload_timer.start()


func shoot():
	var new_bullet = bullet.instantiate()
	new_bullet.dir = Vector2.RIGHT.rotated(global_rotation)
	new_bullet.global_position = marker.global_position
	Bullets.add_child(new_bullet)
	rotation += deg_to_rad(rotation_advance)


func _on_timer_timeout():
	if vis.is_on_screen():
		shoot()


func _on_offset_timeout():
	reload_timer.start()


func _on_health_manager_health_depleted():
	queue_free()
