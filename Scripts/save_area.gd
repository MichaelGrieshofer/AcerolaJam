extends Area2D

@export var save_tag: String = ""


func _ready():
	if Transition.transition_active:
		return
	await get_tree().process_frame
	if Save.game_data.get("save_tag") == save_tag:
		Signals.place_mech.emit(global_position)
		Signals.place_player.emit(global_position)
		Signals.pilot_mech.emit()


func _on_area_entered(area):
	if area is Mech or area is Player:
		Signals.save_scene_path.emit()
		Save.game_data["save_tag"] = save_tag
		Save.save_game()
