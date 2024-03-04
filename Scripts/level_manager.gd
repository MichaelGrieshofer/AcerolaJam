extends Node2D


func _ready():
	Signals.player_left_mech.connect(indentify_last_mech_area)
	Signals.player_entered_area_without_mech.connect(handle_mech_placement)
	Signals.save_scene_path.connect(save_scene_path)


func indentify_last_mech_area(pos):
	Transition.last_mech_area = scene_file_path


func save_scene_path():
	Save.game_data["level_path"] = scene_file_path


func handle_mech_placement():
	if Transition.last_mech_area == scene_file_path:
		Signals.place_mech.emit(Transition.last_mech_position)
	else:
		Signals.place_mech.emit(Vector2.DOWN*1000000)
