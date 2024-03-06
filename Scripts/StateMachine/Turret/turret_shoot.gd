extends State

@onready var bullet = preload("res://Nodes/Actors/bullet.tscn")

@export var aim_speed: float = 0.01
@export var rot: Node2D
@export var shot_speed: Timer
@export var reload: Timer
@export var marker: Marker2D

var bullets_shot: int = 0


func _ready():
	await get_tree().process_frame
	shot_speed.wait_time = actor.time_between_shots
	reload.wait_time = actor.reload_speed
	reload.timeout.connect(end_reload)
	shot_speed.timeout.connect(_on_timer_timeout)


func enter_state():
	super()
	bullets_shot = 0
	shot_speed.start()

func physics_update(delta):
	var vec: Vector2 = Vector2.ZERO
	if actor.mech_target:
		vec = GameManager.mech_position - rot.global_position
	if actor.player_target:
		vec = GameManager.player_position - rot.global_position
	vec = vec.rotated(-actor.global_rotation)
	var desired_angle = vec.angle()
	rot.rotation = lerp_angle(rot.rotation,desired_angle,aim_speed)
	rot.rotation_degrees = clamp(fmod(rot.rotation_degrees, 360), -actor.rotation_clamp-90, actor.rotation_clamp-90)


func _on_timer_timeout():
	var new_bullet = bullet.instantiate()
	new_bullet.dir = Vector2.RIGHT.rotated(rot.rotation).rotated(actor.global_rotation)
	new_bullet.global_position = marker.global_position
	Bullets.add_child(new_bullet)
	bullets_shot += 1
	if bullets_shot >= actor.bullet_salve:
		reload.start()
	else:
		shot_speed.start()

func end_reload():
	switch_state.emit(actor.aim)
