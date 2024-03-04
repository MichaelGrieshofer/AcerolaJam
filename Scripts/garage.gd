extends Node2D

@export var tag: String = ""

@onready var save_area = $SaveArea
@onready var transition = $TransitionArea

func _ready():
	save_area.save_tag = tag
	transition.tag = tag


func _on_transition_area_entered():
	Transition.last_garage_area = get_parent().scene_file_path
	Transition.last_garage_tag = tag


func _on_transition_area_exited():
	await get_tree().process_frame
	Signals.place_mech.emit(save_area.global_position)
