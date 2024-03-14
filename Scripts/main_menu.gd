extends Control


func _on_tab_container_tab_changed(tab):
	SoundManager.play_click()
