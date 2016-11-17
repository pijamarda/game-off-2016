
extends Node2D


# member variables here, example:
# var a=2
# var b="textvar"
var screen_size
var horse_speed = 150
var horse_direction = Vector2(1, 0)
var TOP_POSITION_Y = 64
var MID_POSITION_Y = 288
var BOT_POSITION_Y = 480
var horse_state = 0 # -1 means top, 0 mid, 1 bottom
var horse_pos = Vector2(32,288)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	set_process_input(true)
	set_process(true)
	
func _input(event):
	
	if(event.is_action("horse_up") and event.is_pressed() and !event.is_echo() ):
		print("pulso arriba")
		if (horse_state == 0):
			horse_pos.y = TOP_POSITION_Y
			horse_state = -1
		elif (horse_state == 1):
			horse_pos.y = MID_POSITION_Y
			horse_state = 0
	if(event.is_action("horse_down") and event.is_pressed() and !event.is_echo() ):
		print("pulso abajo")
		if (horse_state == -1):
			horse_pos.y = MID_POSITION_Y
			horse_state = 0
		elif (horse_state == 0):
			horse_pos.y = BOT_POSITION_Y
			horse_state = 1

func _process(delta):
	#horse_pos = get_node("map/horse").get_pos()
	horse_pos += horse_direction * horse_speed * delta
	
	if (horse_pos.x < 32 or horse_pos.x > screen_size.x - 32):
	    horse_direction.x = -horse_direction.x
	get_node("map/horse").set_pos(horse_pos)
	
	
func _draw():
	
	pass


