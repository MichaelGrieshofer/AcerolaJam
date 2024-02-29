extends Control

@onready var progress_bar = $Contents/ProgressBar
@onready var anim = $Contents/AnimationPlayer

var progress = []
var scene_load_status = 0

func _ready():
	anim.play("fade")
	Transition.fade_in()
	ResourceLoader.load_threaded_request(Transition.next_scene)


func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(Transition.next_scene,progress)
	if progress[0] * 100 > progress_bar.value:
		progress_bar.value = progress[0] * 100
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var new_scene = ResourceLoader.load_threaded_get(Transition.next_scene)
		if !anim.is_playing():
			anim.play_backwards("fade")
		await  anim.animation_finished
		get_tree().change_scene_to_packed(new_scene)
		Transition.fade_out()
		#queue_free()
