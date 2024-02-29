extends Control


var loading_screen = "res://Scenes/Menus/loading_screen.tscn"
var next_scene = "res://Scenes/Levels/test_scene.tscn"

@onready var anim = $AnimationPlayer
@onready var color = $CanvasLayer/ColorRect


func transition(scene: String = "res://Scenes/Levels/test_scene.tscn"):
	anim.play("fade")
	await anim.animation_finished
	get_tree().change_scene_to_file(scene)
	anim.play_backwards("fade")

func transition_instantly(scene: String = "res://Scenes/Levels/test_scene.tscn"):
	await get_tree().process_frame
	get_tree().change_scene_to_file(scene)


func transition_with_loading_screen(scene: String = "res://Scenes/Levels/test_scene.tscn"):
	anim.play("fade")
	await anim.animation_finished
	get_tree().change_scene_to_file(loading_screen)
	next_scene = scene
	color.hide()


func fade_in():
	color.hide()
	anim.play("fade")


func fade_out():
	color.show()
	anim.play_backwards("fade")


func fade_in_out():
	color.hide()
	anim.play("fade")
	await anim.animation_finished
	anim.play_backwards("fade")
