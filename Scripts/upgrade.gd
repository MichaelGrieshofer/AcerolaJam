extends Node2D

@export var ability: Ability

@onready var sprite = $Upgrade
@onready var ia = $InteractionArea


func _ready():
	if Save.game_data.get("abilities").has(ability.resource_path):
		empty()


func _on_interaction_area_interaction_triggered():
	Save.game_data.get("abilities").insert(Save.game_data.get("abilities").size(),ability.resource_path)
	empty()


func empty():
	sprite.frame = 1
	ia.queue_free()
