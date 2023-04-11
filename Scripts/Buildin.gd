extends Node2D

var building_types = [preload("res://Sprite/building/building_1.png"), preload("res://Sprite/building/building_2.png"), preload("res://Sprite/building/building_3.png"), preload("res://Sprite/building/building_4.png")]

var civ = preload("res://scenes/collateral/civilian.tscn")
var explosion = preload("res://scenes/explosions/explosion_4.tscn")
var started = false

var explosions = [preload("res://Audio/Explosion/explosion_0.ogg"), preload("res://Audio/Explosion/explosion_1.ogg"), preload("res://Audio/Explosion/explosion_2.ogg")]

func _ready():
	$Buildin.texture = building_types[randi_range(0, building_types.size()-1)]
	
func _on_body_entered(body):
	if !started:
		started = true
		_spawn_people()
		$CollisionShape2D.queue_free()
		GLOBALS.UPDATE_SCORE(10)
		
		$AudioStreamPlayer2D.stream = explosions[randi_range(0, explosions.size()-1)]
		$AudioStreamPlayer2D.play()
		
		$Buildin/AnimationPlayer.play("buildingExplode")
		
		await $Buildin/AnimationPlayer.animation_finished
		_corpseafy()
		


func _spawn_people():
	
	for x in range(randf_range(1,3)):
		add_child(GLOBALS.EXPLOSIONS[randi_range(0,GLOBALS.EXPLOSIONS.size()-1)].instantiate())
	
	for n in range(randf_range(10,20)):
		var people = civ.instantiate()
		people.position = global_position
		people.run = true
		get_tree().get_root().add_child(people)


func _corpseafy():
	
	$Buildin.frame = randi_range(3,7)
