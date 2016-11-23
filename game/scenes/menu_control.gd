extends Control

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	pass

func _on_quit_button_pressed():
	get_tree().quit()


func _on_start_button_pressed():	
	var scene_game = load("res://scenes/game.tscn")
	var game = scene_game.instance()
	get_node("/root/main").add_child(game)
