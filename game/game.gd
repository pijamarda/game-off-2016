
extends Node2D


# member variables here, example:
# var a=2
# var b="textvar"
var screen_size
var horse_speed = 150
var horse_direction = 1
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
	set_fixed_process(true)
	
func _input(event):
	
	if(event.is_action("horse_up") and event.is_pressed() and !event.is_echo() ):
		print("pulso arriba")
		if (horse_state == 0):
			var temp = get_node("map/horse/kinematic_horse").get_pos().x
			get_node("map/horse/kinematic_horse").move_to(Vector2(temp,TOP_POSITION_Y))
			horse_state = -1
		elif (horse_state == 1):
			var temp = get_node("map/horse/kinematic_horse").get_pos().x
			get_node("map/horse/kinematic_horse").move_to(Vector2(temp,MID_POSITION_Y))
			horse_state = 0
	if(event.is_action("horse_down") and event.is_pressed() and !event.is_echo() ):
		print("pulso abajo")
		if (horse_state == -1):
			var temp = get_node("map/horse/kinematic_horse").get_pos().x
			get_node("map/horse/kinematic_horse").move_to(Vector2(temp,MID_POSITION_Y))
			horse_state = 0
		elif (horse_state == 0):
			var temp = get_node("map/horse/kinematic_horse").get_pos().x
			get_node("map/horse/kinematic_horse").move_to(Vector2(temp,BOT_POSITION_Y))
			horse_state = 1
	if(event.is_action("horse_left") and event.is_pressed() and !event.is_echo() ):
		print("pulso left")
		horse_direction = -1
	if(event.is_action("horse_right") and event.is_pressed() and !event.is_echo() ):
		print("pulso right")
		horse_direction = 1

func _fixed_process(delta):
	if get_node("map/horse/kinematic_horse").is_colliding():
		print("Mueres")
		get_node("map/horse").set_pos(Vector2(16,304))
		#get_node("map/horse/kinematic_horse").set_pos(Vector2(16,304))
	else:
		get_node("map/horse/kinematic_horse").move(Vector2(horse_direction,0))
		if (get_node("map/horse/kinematic_horse").get_pos().x < 0 or get_node("map/horse/kinematic_horse").get_pos().x > screen_size.x - 32):
		    horse_direction = -horse_direction
	
func _draw():
	
	pass


