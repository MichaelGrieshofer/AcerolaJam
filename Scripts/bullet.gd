extends Node2D

@onready var spark = preload("res://Nodes/Effects/sparks.tscn")

@onready var screen_vis: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var area: Area2D = $Area2D

var dir: Vector2 = Vector2.RIGHT
var speed: float = 500


func _ready():
	await get_tree().process_frame
	$Area2D/CollisionShape2D.disabled = false


func set_collision_layers_to_player_bullet():
	area.set_collision_layer_value(1,true)
	area.set_collision_layer_value(2,false)
	area.set_collision_mask_value(1,true)
	area.set_collision_mask_value(2,false)


func _physics_process(delta):
	global_position += dir*speed*delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if !body.is_in_group("Mech") and !body.is_in_group("Player"):
		die(false)


func _on_area_2d_area_entered(area):
	if area is Hurtbox:
		die(true)


func die(hit):
	var new_spark = spark.instantiate()
	new_spark.global_position = global_position
	if hit:
		new_spark.hit = true
	Bullets.add_child(new_spark)
	queue_free()
