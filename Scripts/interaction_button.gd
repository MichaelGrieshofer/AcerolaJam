class_name InteractionButton
extends Node2D

@onready var sprite = $Button
@onready var interaction_area = $InteractionArea

@export var tag: String

signal button_triggered
signal already_triggered

var triggered: bool = false


func  _ready():
	await get_tree().process_frame
	if Save.game_data.get("buttons").has(tag):
		interaction_area.queue_free()
		triggered = true
		already_triggered.emit()
		sprite.frame = 1


func _on_interaction_area_interaction_triggered():
	if !triggered:
		interaction_area.queue_free()
		triggered = true
		Save.game_data.get("buttons").insert(0,tag)
		sprite.frame = 1
		button_triggered.emit()
