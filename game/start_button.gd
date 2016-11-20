
extends Button

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input_event(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON and ev.button_index==BUTTON_LEFT and ev.pressed):
		if get_tree().is_paused():
			get_node("/root/main/menu").hide()
			#get_node("menu_control").hide()
			get_tree().set_pause(false)
		else:
			get_node("/root/main/menu").hide()
			var scene_game = load("res://scenes/game.tscn")
			var game = scene_game.instance()
			get_node("/root/main").add_child(game)
		
		
		
