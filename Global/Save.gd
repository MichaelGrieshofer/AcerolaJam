extends Node


var game_data = {}
var settings_data = {}


var game_save_path = "user://save_data.dat"
var settings_save_path = "user://settings_data.dat"



func _ready():
	load_settings()
	load_game()


func save_game():
	var file = FileAccess.open(game_save_path,FileAccess.WRITE)
	file.store_var(game_data)
	file = null


func load_game():
	if FileAccess.file_exists(game_save_path):
		var file = FileAccess.open(game_save_path,FileAccess.READ)
		game_data = file.get_var()
		return game_data


func save_settings():
	var file = FileAccess.open(settings_save_path,FileAccess.WRITE)
	file.store_var(settings_data)
	file = null


func load_settings():
	if FileAccess.file_exists(settings_save_path):
		var file = FileAccess.open(settings_save_path,FileAccess.READ)
		settings_data = file.get_var()
		return settings_data
