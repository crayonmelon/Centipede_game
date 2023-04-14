extends CanvasLayer

var main_game = "res://scenes/Core/world.tscn"

func _on_start_pressed():
	
	GLOBALS.Reset()
	TRANSITION.Transistion_Intro(main_game, self)

func _on_settings_pressed():
	get_tree().get_root().add_child(preload("res://scenes/Core/Pause_Menu.tscn").instantiate())
