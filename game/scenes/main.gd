
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	var menu_scene = load("res://scenes/menu_control.tscn")
	var menu = menu_scene.instance()
	get_node(".").add_child(menu)
		
	pass


