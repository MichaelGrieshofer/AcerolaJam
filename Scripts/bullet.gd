extends Node2D

@export var spark = preload("res://Nodes/Effects/sparks.tscn")

@onready var screen_vis: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hitbox: Hitbox = $Hitbox

var dir: Vector2 = Vector2.RIGHT
var speed: float = 500


func _physics_process(delta):
	global_position += dir*speed*delta


func die(hit):
	var new_spark = spark.instantiate()
	new_spark.global_position = global_position
	if hit:
		new_spark.hit = true
	Bullets.add_child(new_spark)
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	die(false)


func _on_hitbox_hit():
	die(true)
