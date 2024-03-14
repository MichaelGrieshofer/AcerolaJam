extends Node
class_name RandomAudioStreamPlayer

@export var min_pitch = 0.85 
@export var max_pitch = 1.15 


func play():
	var child_count = get_child_count()
	if child_count != 0:
		var random = randi_range(0,child_count-1)
		var player = get_child(random)
		if player is AudioStreamPlayer:
			player.pitch_scale = randf_range(min_pitch,max_pitch)
			player.play()
	else:
		print(self," has no audio sources")


func stop():
	for player in get_children():
		if player is AudioStreamPlayer:
			player.stop()
