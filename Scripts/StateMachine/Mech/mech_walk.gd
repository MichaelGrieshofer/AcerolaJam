extends WalkState


func physics_update(delta):
	super(delta)
	anim.speed_scale = (actor.velocity.x/speed)*2 * helper.look_dir
	if abs(anim.speed_scale) < 0.3:
		if anim.speed_scale < 0:
			anim.speed_scale = -0.3
		elif anim.speed_scale >= 0:
			anim.speed_scale = 0.3
	anim.speed_scale = clamp(anim.speed_scale,-1,1)


func exit_state():
	anim.speed_scale = 1
