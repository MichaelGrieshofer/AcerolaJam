extends Button


@export var scene: String = "res://Scenes/Levels/test_scene.tscn"


func _on_pressed():
	SoundManager.play_click()
	Transition.transition_with_loading_screen(scene)
