extends Node2D

@export var ability: Ability

@onready var sprite = $Upgrade
@onready var ia = $InteractionArea


func _ready():
	ia.interaction_triggered.connect(_on_interaction_area_interaction_triggered)
	if Save.game_data.get("abilities").has(ability.resource_path):
		empty()


func _on_interaction_area_interaction_triggered():
	Save.game_data.get("abilities").insert(Save.game_data.get("abilities").size(),ability.resource_path)
	Signals.update_mech_fuel.emit()
	Signals.update_mech_max_health.emit()
	Signals.update_player_max_health.emit()
	Signals.upgrade_message_display.emit(ability.message)
	empty()


func empty():
	sprite.frame = 1
	ia.queue_free()
