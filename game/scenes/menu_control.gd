extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass

func _input(ev):
	if (ev.is_action("escape") and ev.pressed):
		print("escape")
