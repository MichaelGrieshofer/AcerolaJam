extends Node2D


@onready var screen_vis: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var dir: Vector2 = Vector2.RIGHT
var speed: float = 500


func _physics_process(delta):
	global_position += dir*speed*delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	queue_free()
