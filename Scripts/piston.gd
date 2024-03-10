extends Node2D

@export var pressure_plate: PressurePlate
@onready var piston: Node2D = $Piston

var end_position: float = 0.0

func _ready():
	pressure_plate.mech_entered.connect(move_up)
	pressure_plate.mech_exited.connect(move_down)


func move_up():
	end_position = -40
	var tween = get_tree().create_tween()
	tween.tween_property(piston,"position",Vector2(0,end_position),0.4)


func move_down():
	end_position = 0
	var tween = get_tree().create_tween()
	tween.tween_property(piston,"position",Vector2(0,end_position),0.4)
