class_name TriggerCanvasItemArea
extends Area2D

@export var check_for_ability: String = ""

var inside_area: int = 0

var canvas_item_vis: bool = false

func _ready():
	modulate = Color.TRANSPARENT
	area_entered.connect(enter)
	area_exited.connect(exit)


func _physics_process(delta):
	if inside_area > 0 and !canvas_item_vis:
		show_item()
		canvas_item_vis = true
	if inside_area == 0 and canvas_item_vis:
		hide_item()
		canvas_item_vis = false


func show_item():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate",Color.WHITE,0.3)


func hide_item():
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate",Color.TRANSPARENT,0.3)


func enter(area):
	if area is Player or area is Mech:
		inside_area += 1


func exit(area):
	if area is Player or area is Mech:
		inside_area -= 1
