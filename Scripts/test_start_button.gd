extends HBoxContainer

@export var save_path: String = "user://save_data.dat"
@export var text: String = "Save 1"
@onready var delete = %Delete
@onready var button = %SavePath


func _ready():
	button.text = text
	if !check_path():
		delete.disabled = true


func _on_delete_pressed():
	SoundManager.play_click()
	Save.game_save_path = save_path
	Save.load_game()
	Save.game_data = {}
	Save.add_basics()
	Save.save_game()
	if !check_path():
		delete.disabled = true


func check_path():
	Save.game_save_path = save_path
	Save.load_game()
	return Save.game_data.has("started")


func _on_save_path_pressed():
	SoundManager.play_click()
	Save.game_save_path = save_path
	Save.load_game()
	Transition.load_level()
	Save.game_data["started"] = true
