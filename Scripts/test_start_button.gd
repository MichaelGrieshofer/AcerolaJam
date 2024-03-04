extends Button



func _on_pressed():
	if Save.game_data.has("level_path"):
		Transition.transition_with_loading_screen(Save.game_data.get("level_path"))
	else:
		Transition.transition_with_loading_screen("res://Scenes/Levels/test_level.tscn")
