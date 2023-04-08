extends Node2D

var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Walk_To_player()
	pass # Replace with function body.

func _process(delta):
	position.x = move_toward(position.x, target.x,delta*10)
	position.y = move_toward(position.y, target.y,delta*10)
	
func Walk_To_player():
	
	var closest_fucker_distance = 999999
	var closest_fucker = Vector2(0,0)
	for centipede in GLOBALS.CENTIPEDES_PARENTS:
		
		var distance = position.distance_to(centipede.position) 
		
		if distance < closest_fucker_distance:
			closest_fucker_distance = distance
			closest_fucker = centipede.position
	
	target = closest_fucker


func _on_timer_timeout():
	Walk_To_player()
	pass # Replace with function body.


func _on_body_entered(body):
	add_child(GLOBALS.EXPLOSIONS[randi_range(0,GLOBALS.EXPLOSIONS.size()-1)].instantiate())
	queue_free()
	GLOBALS.UPDATE_SCORE(1)
	pass # Replace with function body.
