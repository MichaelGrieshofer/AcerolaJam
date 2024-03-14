extends GPUParticles2D


var hit: bool = false

@export var hit_sound: RandomAudioStreamPlayer
@export var hit_target_sound: RandomAudioStreamPlayer


func _ready():
	emitting = true
	if hit:
		$GPUParticles2D.emitting = true
		if hit_target_sound:
			hit_target_sound.play()
	else:
		if hit_sound:
			hit_sound.play()


func _on_finished():
	queue_free()
