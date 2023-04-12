extends Node2D

@export var speed = 100

func _process(delta):
	position += transform.y * speed * delta

func die():
	queue_free()
