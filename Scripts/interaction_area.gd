class_name InteractionArea
extends Area2D

@export var interaction_icon: CanvasItem

signal interaction_triggered

var player_inside: bool = false

func _ready():
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)


func _input(event):
	if (event.is_action_pressed("interact") or event.is_action_pressed("jinteract")) and player_inside:
		interaction_triggered.emit()


func on_area_entered(area):
	if area is Player:
		player_inside = true
		var tween = get_tree().create_tween()
		tween.tween_property(interaction_icon,"modulate",Color.WHITE,0.2)


func on_area_exited(area):
	if area is Player:
		player_inside = false
		var tween = get_tree().create_tween()
		tween.tween_property(interaction_icon,"modulate",Color.TRANSPARENT,0.2)
