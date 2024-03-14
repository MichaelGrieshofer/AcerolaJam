@tool
class_name InsideArea
extends Polygon2D

@export var generate: bool = false


func _ready():
	if Engine.is_editor_hint():
		color = Color(31,31,31,139)
	else:
		show()
		z_index = -50
		texture = load("res://Textures/Sprites/background.png")
		texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED


func _physics_process(delta):
	if Engine.is_editor_hint():
		if generate:
			
			if get_child_count() != 0:
				for i in get_children():
					i.queue_free()
			
			generate = false
			hide()
			set_meta("_edit_group_", true)
			set_meta("_edit_lock_", true)
			
			var new_area = Area2D.new()
			new_area.name = "Area2D"
			new_area.add_to_group("Inside",true)
			add_child(new_area)
			new_area.owner = get_tree().edited_scene_root
			
			var new_collision_polygon = CollisionPolygon2D.new()
			new_collision_polygon.name = "CollisionPolygon2D"
			new_collision_polygon.polygon = polygon
			new_area.add_child(new_collision_polygon)
			new_collision_polygon.owner = get_tree().edited_scene_root
			
			var new_light_occluder = LightOccluder2D.new()
			new_light_occluder.name = "LightOccluder2D"
			add_child(new_light_occluder)
			new_light_occluder.owner = get_tree().edited_scene_root
			
			var new_occluder_polygon = OccluderPolygon2D.new()
			new_occluder_polygon.polygon = polygon
			new_light_occluder.occluder = new_occluder_polygon
