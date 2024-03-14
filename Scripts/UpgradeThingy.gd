extends ColorRect


func _ready():
	Signals.upgrade_message_display.connect(show_thingy)


func show_thingy(message):
	$Label.text = message
	$AnimationPlayer.play("slide_in")
