extends Node2D

@export var cam_limit_left: int = -10000000
@export var cam_limit_top: int = -10000000
@export var cam_limit_right: int = 10000000
@export var cam_limit_bottomt: int = 10000000


func _ready():
	Signals.player_left_mech.connect(indentify_last_mech_area)
	Signals.player_entered_area_without_mech.connect(handle_mech_placement)
	Signals.save_scene_path.connect(save_scene_path)
	
	if !Transition.transition_active:
		Signals.pilot_mech.emit()
	
	await get_tree().process_frame
	
	Signals.set_camera_limits.emit(cam_limit_left,cam_limit_top,cam_limit_right,cam_limit_bottomt)


func indentify_last_mech_area(pos):
	Transition.last_mech_area = scene_file_path


func save_scene_path():
	Save.game_data["level_path"] = scene_file_path


func handle_mech_placement():
	if Transition.last_mech_area == scene_file_path:
		GameManager.cannot_remote_control = false
		Signals.place_mech.emit(Transition.last_mech_position)
	else:
		GameManager.cannot_remote_control = true
		Signals.place_mech.emit(Vector2.DOWN*1000000)
