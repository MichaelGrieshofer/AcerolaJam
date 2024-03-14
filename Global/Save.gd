extends Node


var game_data = {}
var settings_data = {}


var game_save_path = "user://save_data.dat"
var settings_save_path = "user://settings_data.dat"



func _ready():
	load_settings()
	load_game()
	add_basics()


func add_basics():
	if !Save.game_data.has("abilities"):
		Save.game_data["abilities"] = []
	if !Save.game_data.has("buttons"):
		Save.game_data["buttons"] = []


func check_for_ability(resource_path):
	return Save.game_data.get("abilities").has(resource_path)


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
