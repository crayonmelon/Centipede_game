extends Node2D

var target = null
var bullet = preload("res://scenes/bullet.tscn")

func _process(delta):
	
	var closest_fucker_distance = 999999
	var closest_fucker = Vector2(0,0)
	for centipede in GLOBALS.CAMERA_TRACK:
		
		var distance = position.distance_to(centipede.position) 
		
		if distance < closest_fucker_distance:
			closest_fucker_distance = distance
			closest_fucker = centipede.position
	
	target = closest_fucker
	look_at(target)


func _on_timer_timeout():
	var bullet_inst = bullet.instantiate()
	bullet_inst.position = global_position
	bullet_inst.rotation = global_rotation
	get_tree().get_root().add_child(bullet_inst)
