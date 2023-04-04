extends Node2D

var civ = preload("res://scenes/civilian.tscn")
var explosion = preload("res://scenes/explosions/explosion_4.tscn")
var corpse = preload("res://scenes/buildingCorpse.tscn")
var started = false

var explosions = [preload("res://Audio/Explosion/explosion_0.ogg"), preload("res://Audio/Explosion/explosion_1.ogg"), preload("res://Audio/Explosion/explosion_2.ogg")]

func _on_body_entered(body):
	if !started:
		started = true
		_spawn_people()
		
		$AudioStreamPlayer2D.stream = explosions[randi_range(0, explosions.size()-1)]
		$AudioStreamPlayer2D.play()
		
		$Buildin/AnimationPlayer.play("buildingExplode")
		

		
		await $Buildin/AnimationPlayer.animation_finished
		
		var new_corpse = corpse.instantiate()
		new_corpse.position = global_position
		

		
		await $AudioStreamPlayer2D.finished
		
		get_tree().get_root().add_child(new_corpse)
		queue_free()

func _spawn_people():
	
	for x in range(randf_range(1,3)):
		add_child(GLOBALS.EXPLOSIONS[randi_range(0,GLOBALS.EXPLOSIONS.size()-1)].instantiate())
	
	for n in range(randf_range(10,20)):
		var people = civ.instantiate()
		people.position = global_position
		people.run = true
		get_tree().get_root().add_child(people)
