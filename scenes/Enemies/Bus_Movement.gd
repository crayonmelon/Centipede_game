extends StaticBody2D

var speed = 80
var score = 10
var civ = preload("res://scenes/collateral/civilian.tscn")
var boom_sound = preload("res://Audio/Explosion/carcrash.ogg")


func _process(delta):
	position.x -= delta * speed
	position.x = wrapf(position.x,GLOBALS.WORLD_BORDER_X_MIN, GLOBALS.WORLD_BORDER_X_MAX)
	position.y = wrapf(position.y,GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX)

func die():
	$CollisionShape2D.disabled = true
	
	GLOBALS.EXPLODE_EFFECT(self.global_position)
	GLOBALS.PLAY_BOOM(self.global_position, boom_sound)
	
	GLOBALS.UPDATE_SCORE(score)
	
	for n in range(20):
		var people = civ.instantiate()
		people.position = global_position
		people.run = true
		get_tree().get_root().add_child(people)
	
	queue_free()

