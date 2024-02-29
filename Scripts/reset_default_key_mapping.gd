extends Button


func _on_pressed():
	SoundManager.play_click()
	InputMapping.revert_mapping()
