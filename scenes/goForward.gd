extends Node2D

@export var speed = 100

func _process(delta):
	position += transform.x * speed * delta
