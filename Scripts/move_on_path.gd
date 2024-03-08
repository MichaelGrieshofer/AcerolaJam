class_name MoveOnPath
extends PathFollow2D

@export var speed: float = 50
@export var wrap_around: bool = false

@export_enum("left:-1", "right:1") var dir: int = 1


func _physics_process(delta):
	if progress_ratio == 1 or progress_ratio == 0:
		if wrap_around:
			progress_ratio = -dir
		else:
			dir *= -1
	progress += speed * dir * delta
