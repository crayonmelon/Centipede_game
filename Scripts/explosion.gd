extends Node2D

func _ready():
		
	position.x += randf_range(-10, 10)
	position.y += randf_range(-10, 10)
	
	$Sprite2D/AnimationPlayer.speed_scale = randf_range(1, 2)
	$Sprite2D/AnimationPlayer.play("explosion_1")
	await $Sprite2D/AnimationPlayer.animation_finished

	queue_free()
