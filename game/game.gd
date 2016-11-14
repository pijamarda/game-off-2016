
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var screen_size
var horse_speed = 150
var horse_direction = Vector2(1, 0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	screen_size = get_viewport_rect().size
	set_process(true)
	
	
func _process(delta):
	if(Input.is_action_pressed("horse_up")):
		var cur_pos = self.get_pos()
		cur_pos.x += 1
		self.set_pos(cur_pos)
	var horse_pos = get_node("map/horse").get_pos()
	if(Input.is_action_pressed("horse_up")):
		horse_pos.y = horse_pos.y - 50
	if(Input.is_action_pressed("horse_down")):
		horse_pos.y = horse_pos.y + 50
	horse_pos += horse_direction * horse_speed * delta
	
	if (horse_pos.x < 32 or horse_pos.x > screen_size.x - 32):
	    horse_direction.x = -horse_direction.x
	get_node("map/horse").set_pos(horse_pos)
	
	
func _draw():
	
	pass


