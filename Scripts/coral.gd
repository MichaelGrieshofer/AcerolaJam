@tool
class_name CoralLine
extends Line2D

@export var generate: bool = false

func _ready():
	if Engine.is_editor_hint():
		pass


func _physics_process(delta):
	if Engine.is_editor_hint():
		if generate:
			generate = false
			
			z_index = -1
			texture = load("res://Textures/Sprites/coral_line.tres")
			texture_mode = Line2D.LINE_TEXTURE_TILE
			width = 16
			texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
			
			if get_child_count() != 0:
				for i in get_children():
					i.queue_free()
			set_meta("_edit_group_", true)
			
			var new_area = Area2D.new()
			new_area.name = "Area2D"
			new_area.add_to_group("Danger",true)
			add_child(new_area)
			new_area.owner = get_tree().edited_scene_root
			
			var index: int = 0
			var last_point: Vector2 = Vector2.ZERO
			for i in points:
				if index != 0:
					var new_collision_shape = CollisionShape2D.new()
					new_collision_shape.name = str("CollisionShape",index)
					new_area.add_child(new_collision_shape)
					new_collision_shape.owner = get_tree().edited_scene_root
					var new_segment = SegmentShape2D.new()
					new_segment.a = last_point
					new_segment.b = i
					new_collision_shape.shape = new_segment
				last_point = i
				index += 1
