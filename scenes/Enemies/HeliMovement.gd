extends Area2D

var speed = 80
var score = 100

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

func _on_timer_timeout():
	var missile_inst = missile.instantiate()
	missile_inst.position = global_position
	missile_inst.fall_left = going_left
	
	get_tree().get_root().add_child(missile_inst)
	
func _on_body_entered(body):
	$CollisionShape2D.disabled = true
	
	GLOBALS.EXPLODE_EFFECT(self.global_position)
	GLOBALS.PLAY_BOOM(self.global_position, boom_sound)
	GLOBALS.ADD_KILLS(GLOBALS.Enemy_Type.HELICOPTER)
	GLOBALS.UPDATE_SCORE(score)
	
	for n in range(3):
		var people = civ.instantiate()
		people.position = global_position
		people.run = true
		get_tree().get_root().add_child(people)
	
	queue_free()

