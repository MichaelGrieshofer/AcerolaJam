extends CharacterBody2D

@onready var anim: AnimationPlayer = %AnimationPlayer

@export var speed: float = 80
@export var upward_speed: float = 140
@export var gravity: float = 200
@export var acceleration: float = 0.02
@export var deceleration: float = 0.02
@export var comfort_range: float = 100
@export var comfort_range_width: float = 20
@export var drive_up_walls: bool = false

func _physics_process(delta):
	var dir: Vector2 = Vector2.ZERO
	if GameManager.player_outside_mech:
		dir = GameManager.player_position - global_position
	else:
		dir = GameManager.mech_position - global_position
	if abs(dir.x) >= comfort_range+comfort_range_width/2:
		dir = dir.normalized()
		velocity.x = lerp(velocity.x,speed*dir.x,acceleration)
	elif abs(dir.x) <= comfort_range-comfort_range_width/2:
		dir = dir.normalized()
		velocity.x = lerp(velocity.x,speed*-dir.x,deceleration)
	else:
		velocity.x = lerp(velocity.x,0.0,deceleration)
	if !is_on_floor():
		velocity.y += gravity*delta
	if is_on_wall() and drive_up_walls:
		velocity.y = -upward_speed
	anim.speed_scale = velocity.x/speed*2
	move_and_slide()


func _on_health_manager_health_depleted():
	queue_free()
