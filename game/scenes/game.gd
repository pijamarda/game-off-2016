
extends Node2D


# member variables here, example:
# var a=2
# var b="textvar"
var screen_size
var horse_speed = 3
var horse_direction = Vector2(horse_speed,0)
var TOP_POSITION_Y = 144
var MID_POSITION_Y = 288
var BOT_POSITION_Y = 480
var PAUSE_TIME = 1
var horse_state = 0 # -1 means top, 0 mid, 1 bottom
var horse_pos = Vector2(32,288)
var horse_moving = false
var computers_remaining = 3
var time_left = PAUSE_TIME
var bajando = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	set_process_input(true)
	set_fixed_process(true)
	var scene_map = load("res://scenes/levels/level_1_1.tscn")
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
				bajando = false
	if(event.is_action("horse_down") and event.is_pressed() and !event.is_echo() ):
		if (not horse_moving):
			if (horse_state == -1):
				horse_direction = Vector2(horse_speed,horse_speed)
				horse_state = 0
				horse_moving = true
				bajando = true
			elif (horse_state == 0):
				horse_state = 1
				horse_direction = Vector2(horse_speed,horse_speed)
				horse_moving = true
	if(event.is_action("horse_left") and event.is_pressed() and !event.is_echo() ):
		print("pulso left")
	if(event.is_action("horse_right") and event.is_pressed() and !event.is_echo() ):
		print("pulso right")
	if(event.is_action("escape") and event.is_pressed() and !event.is_echo()):
		var temp_global = get_node("/root/main/game/map/horse/kinematic_horse").get_global_pos()
		temp_global.x = temp_global.x - 100
		temp_global.y = temp_global.y - 100
		get_node("/root/main/game/popupmenu").set_global_pos(temp_global)
		print("pulso escape")
		get_tree().set_pause(true)
		get_node("/root/main/game/popupmenu").show()

func _fixed_process(delta):
	if get_node("map/horse/kinematic_horse").is_colliding():
		var collision_object = get_node("map/horse/kinematic_horse").get_collider()
		var collision_name = collision_object.get_name()
		print(collision_name)
		if (collision_name == "firewall" or collision_name == "infected" or collision_name == "cable"):
			get_node("SamplePlayer").play("grito")
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
			if (time_left < 0 ):
				computers_remaining = computers_remaining - 1
				var pos_collider = collision_object.get_global_pos()
				print(pos_collider)
				collision_object.get_parent().free()
				var infected_res = load("res://scenes/infected.tscn")
				var infected = infected_res.instance()
				infected.set_global_pos(pos_collider)
				get_node("map").add_child(infected)
				get_node("map/horse").free()
				var scene = load("res://scenes/horse.tscn")
				var horse = scene.instance()
				get_node("map").add_child(horse)
				horse_state = 0
				horse_moving = false
				horse_direction = Vector2(horse_speed,0)
				time_left = PAUSE_TIME
			else:
				#print(time_left)
				time_left = time_left - delta
			
	else:
		if (horse_moving):
			var temp = get_node("map/horse/kinematic_horse").get_global_pos().y
			#print(temp)
			if horse_state == -1:
				if temp > TOP_POSITION_Y:
					#print("keep moving to -1")
					pass
				else:
					horse_moving = false
					horse_direction = Vector2(horse_speed,0)
			elif (horse_state == 0):
				if bajando:
					if temp < MID_POSITION_Y:
						pass
					else:
						horse_moving = false
						horse_direction = Vector2(horse_speed,0)
				else:
					if temp > MID_POSITION_Y:
						pass
					else:
						horse_moving = false
						horse_direction = Vector2(horse_speed,0)
			elif horse_state == 1:
				if temp < BOT_POSITION_Y:
					pass
					
				else:
					horse_moving = false
					horse_direction = Vector2(horse_speed,0)
		
		get_node("map/horse/kinematic_horse").move(horse_direction)
	if (computers_remaining == 0):
		computers_remaining = 3
		get_node("map/horse").free()
		get_node("map").free()
		var scene_map = load("res://scenes/levels/level_1_2.tscn")
		var map = scene_map.instance()
		get_node(".").add_child(map)
		var scene = load("res://scenes/horse.tscn")
		var horse = scene.instance()
		get_node("map").add_child(horse)
func _draw():
	
	pass


