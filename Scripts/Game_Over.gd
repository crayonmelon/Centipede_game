extends CanvasLayer

@onready var kill_count = $KILL_COUNT

var main_menu = preload("res://scenes/Core/Main_Menu.tscn")

func _ready():
	_set_kill_count() 

func _set_kill_count():
	var full_list = ""
	
	for item in GLOBALS.ENEMY_KILLS.keys():

		var name = str(GLOBALS.Enemy_Type.keys()[item])
		
		var new = name + ("S: " if name[name.length()-1] != "S" else "ES: ") + str(GLOBALS.ENEMY_KILLS[item]) + "\n" 
		
		full_list += new
	kill_count.text = full_list
	print(full_list)
	

func _on_start_pressed():
	get_tree().paused = false
	GLOBALS.Reset()
	
	get_tree().change_scene_to_packed(main_menu)

