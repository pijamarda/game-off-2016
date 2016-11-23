extends PopupMenu

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_popupmenu_item_pressed( ID ):
	if ( ID == 0 ):
		get_tree().set_pause(false)
		get_node(".").hide()
	else:
		get_tree().quit()
	
