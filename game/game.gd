
extends Node2D


# member variables here, example:
# var a=2
# var b="textvar"
var screen_size
var horse_speed = 4
var horse_direction = Vector2(horse_speed,0)
var TOP_POSITION_Y = 64
var MID_POSITION_Y = 288
var BOT_POSITION_Y = 480
var horse_state = 0 # -1 means top, 0 mid, 1 bottom
var horse_pos = Vector2(32,288)
var horse_moving = false


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	set_process_input(true)
	set_fixed_process(true)
	var scene_map = load("res://scenes/map3.tscn")
	var map = scene_map.instance()
	get_node(".").add_child(map)
	var scene = load("res://scenes/horse.tscn")
	var horse = scene.instance()
	get_node("map").add_child(horse)
	#get_node("map/horse").set_global_pos(Vector2(0,BOT_POSITION_Y))
	var popup_menu_scene = load("res://scenes/popup_menu.tscn")
	var popup_menu = popup_menu_scene.instance()
	get_node(".").add_child(popup_menu)
	
	
func _input(event):
	
	if(event.is_action("horse_up") and event.is_pressed() and !event.is_echo() ):
		if (not horse_moving):
			if (horse_state == 0):
				print("move up")
				horse_direction = Vector2(horse_speed,-horse_speed)
				horse_state = -1
				horse_moving = true
			elif (horse_state == 1):
				horse_direction = Vector2(horse_speed,-horse_speed)
				horse_state = 0
				horse_moving = true
	if(event.is_action("horse_down") and event.is_pressed() and !event.is_echo() ):
		if (not horse_moving):
			if (horse_state == -1):
				horse_direction = Vector2(horse_speed,horse_speed)
				horse_state = 0
				horse_moving = true
			elif (horse_state == 0):
				horse_state = 1
				horse_direction = Vector2(horse_speed,horse_speed)
				horse_moving = true
	if(event.is_action("horse_left") and event.is_pressed() and !event.is_echo() ):
		print("pulso left")
	if(event.is_action("horse_right") and event.is_pressed() and !event.is_echo() ):
		print("pulso right")
	if(event.is_action("escape") and event.is_pressed() and !event.is_echo() ):
		print("pulso escape")
		get_tree().set_pause(true)
		get_node("/root/main/game/popupmenu").show()

func _fixed_process(delta):
	if get_node("map/horse/kinematic_horse").is_colliding():
		var collision_object = get_node("map/horse/kinematic_horse").get_collider()
		var collision_name = object.get_name()
		if (collision_name == "firewall"):
			print("Mueres")
			get_node("map/horse").free()
			var scene = load("res://scenes/horse.tscn")
			var horse = scene.instance()
			get_node("map").add_child(horse)
			horse_state = 0
			horse_moving = false
			horse_direction = Vector2(horse_speed,0)
		elif (collision_name == "computer"):
			print("Capturas computer")
			var pos_collider = object.get_global_pos()
			collision_object.free()
			get_node("map/horse").free()
			var scene = load("res://scenes/horse.tscn")
			var horse = scene.instance()
			get_node("map").add_child(horse)
			horse_state = 0
			horse_moving = false
			horse_direction = Vector2(horse_speed,0)
			
	else:
		if (horse_moving):
			var temp = get_node("map/horse/kinematic_horse").get_global_pos().y
			print(temp)
			if horse_state == -1:
				if temp > TOP_POSITION_Y:
					print("keep moving to -1")
				else:
					horse_moving = false
					horse_direction = Vector2(horse_speed,0)
			elif horse_state == 0:
				if temp != MID_POSITION_Y:
					print("keep moving to 0")
				else:
					horse_moving = false
					horse_direction = Vector2(horse_speed,0)
			elif horse_state == 1:
				if temp < BOT_POSITION_Y:
					print("keep moving to 1")
					
				else:
					horse_moving = false
					horse_direction = Vector2(horse_speed,0)
		
		get_node("map/horse/kinematic_horse").move(horse_direction)
		
func _draw():
	
	pass


