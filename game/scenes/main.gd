extends Node

func _ready():
	
	#	Funcion principal de entrada al programa
	#	desde esta funcion llamamos al menu principal
	
	var menu_scene = load("res://scenes/menu_control.tscn")
	var menu = menu_scene.instance()
	get_node(".").add_child(menu)