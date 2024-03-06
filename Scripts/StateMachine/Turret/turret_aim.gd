extends State


@export var rot: Node2D
@export var ray: RayCast2D

var time_on_target: float = 0.0

func enter_state():
	super()


func physics_update(delta):
	var vec: Vector2 = Vector2.ZERO
	if actor.mech_target:
		vec = GameManager.mech_position - rot.global_position
	if actor.player_target:
		vec = GameManager.player_position - rot.global_position
	vec = vec.rotated(-actor.global_rotation)
	var desired_angle = vec.angle()
	rot.rotation = lerp_angle(rot.rotation,desired_angle,actor.aim_speed)
	rot.rotation_degrees = clamp(fmod(rot.rotation_degrees, 360), -actor.rotation_clamp-90, actor.rotation_clamp-90)
	if ray.is_colliding():
		if ray.get_collider().is_in_group("Mech") or ray.get_collider().is_in_group("Player"):
			time_on_target += delta
		else:
			time_on_target = 0
		if time_on_target >= actor.aim_confirm_time:
			switch_state.emit(actor.shoot)
			time_on_target = 0
