class_name Boosters
extends Node2D


@onready var boost1 = $Boost
@onready var boost2 = $Boost2
@onready var boost3 = $Boost3
@onready var boost4 = $Boost4


func emit(active):
	boost1.emitting = active
	boost2.emitting = active
	boost3.emitting = active
	boost4.emitting = active
