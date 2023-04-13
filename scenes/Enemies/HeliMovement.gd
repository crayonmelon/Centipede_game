extends StaticBody2D

var speed = 80
var score = 10

var civ = preload("res://scenes/collateral/civilian.tscn")
var boom_sound = preload("res://Audio/Explosion/carcrash.ogg")

var missile = preload("res://scenes/bomb.tscn")
var going_left = true

func _process(delta):
	
	# Movement 
	if going_left: 
		position.x += delta * speed
	else:
		position.x -= delta * speed
			
	# Check Location
	if position.x > GLOBALS.WORLD_BORDER_X_MAX+ 30 and going_left:
		Flip()
	elif position.x < GLOBALS.WORLD_BORDER_X_MIN - 30 and !going_left:
		Flip()
		
func Flip():
	going_left = !going_left
	$Sprite2D.flip_h = !going_left
	
	if going_left:
		$Sprite2D.rotation = 13
	else:
		$Sprite2D.rotation = -13
		
	
	position = Vector2(position.x, randi_range(GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX))

func die():
	print("piss")

func _on_timer_timeout():
	var missile_inst = missile.instantiate()
	missile_inst.position = global_position
	missile_inst.fall_left = going_left
	
	get_tree().get_root().add_child(missile_inst)
	
