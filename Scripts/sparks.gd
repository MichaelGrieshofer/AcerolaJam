extends GPUParticles2D


var hit: bool = false


func _ready():
	emitting = true
	if hit:
		$GPUParticles2D.emitting = true


func _on_finished():
	queue_free()
