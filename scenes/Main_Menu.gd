extends Node2D

var main_game = preload("res://scenes/Core/world.tscn")

func _ready():
	pass


func _process(delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_packed(main_game)
