extends Node2D

@onready var anim = $Door/AnimationPlayer

@export var interaction_button: InteractionButton

func _ready():
	interaction_button.already_triggered.connect(already)
	interaction_button.button_triggered.connect(triggered)


func already():
	open()


func triggered():
	open()


func open():
	anim.play("open")
