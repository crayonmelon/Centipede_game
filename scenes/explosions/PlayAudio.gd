extends Node2D

var audio_stream = preload("res://Audio/Effects/splatt.ogg")

func _ready():
	
	$AudioStreamPlayer2D.stream = audio_stream
	$AudioStreamPlayer2D.play()
	await $AudioStreamPlayer2D.finished
	queue_free()
