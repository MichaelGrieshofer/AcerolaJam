@tool
extends Area2D

@export var target_scene: String
@export var tag: String
@export var create_exit_position_node: bool = false
@export var exit_pos_node: Node2D

var in_area: bool = false
signal entered
signal exited


func _ready():
	if Engine.is_editor_hint():
		return
	if !Transition.transition_active:
		return
	await get_tree().process_frame
	if Transition.tag == tag:
		exited.emit()
		if Transition.only_transition_player:
			Signals.place_player.emit(exit_pos_node.global_position)
			Signals.player_entered_area_without_mech.emit()
		else:
			Signals.place_mech.emit(exit_pos_node.global_position)
			Signals.place_player.emit(exit_pos_node.global_position)
			Signals.pilot_mech.emit()
		Transition.tag = ""
		Transition.transition_active = false


func _physics_process(delta):
	if Engine.is_editor_hint():
		if create_exit_position_node:
			create_pos()
			create_exit_position_node = false


func create_pos():
	var exit_pos = Node2D.new()
	exit_pos.name = "ExitPosition"
	add_child(exit_pos)
	exit_pos.owner = get_tree().edited_scene_root
	exit_pos_node = exit_pos
	var coll_shape = CollisionShape2D.new()
	add_child(coll_shape)
	coll_shape.owner = get_tree().edited_scene_root
	var new_shape = RectangleShape2D.new()
	coll_shape.shape = new_shape
	set_meta("_edit_group_", true)


func _input(event):
	if Engine.is_editor_hint():
		return
	if (event.is_action_pressed("interact") or event.is_action_pressed("jinteract")) and in_area:
		entered.emit()
		Transition.transition_with_loading_screen(target_scene)
		Transition.only_transition_player = true
		Transition.tag = tag
		Transition.transition_active = true


func _on_area_entered(area):
	if Engine.is_editor_hint():
		return
	if area is Player:
		in_area = true


func _on_area_exited(area):
	if Engine.is_editor_hint():
		return
	if area is Player:
		in_area = false
