extends Node2D

@export var frame_max = 7
@export var frame_min = 3

func _ready():
	$Buildin.frame = randi_range(frame_min, frame_max)
