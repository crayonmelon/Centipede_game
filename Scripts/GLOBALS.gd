extends Node
# C = CENTIPEDE

@export var C_CONTROLS = [["1_left", "1_right"], ["2_left", "2_right"], ["3_left", "3_right"], ["4_left", "4_right"]]
@export var C_COLOURS = [Color("FFFFFF"), Color("00FFFF"), Color("FF00FF"), Color("FFFF00")]
@export var CAMERA_TRACK = []
@export var CENTIPEDE_PARENTS = []
@export var WORLD_BORDER_X_MIN = -300
@export var WORLD_BORDER_X_MAX = 300

@export var WORLD_BORDER_Y_MIN = -300
@export var WORLD_BORDER_Y_MAX = 300

@export var EXPLOSIONS = [preload("res://scenes/explosions/explosion_1.tscn"), preload("res://scenes/explosions/explosion_2.tscn"), preload("res://scenes/explosions/explosion_3.tscn"), preload("res://scenes/explosions/explosion_4.tscn")]

var EDGING = false

func UPDATE_SCORE(val):
	get_tree().get_root().get_node("LEVEL_MANAGER").increase_score(val)
	
func EXPLODE_EFFECT(pos):
	var explode = EXPLOSIONS[randi_range(0,GLOBALS.EXPLOSIONS.size()-1)].instantiate()
	explode.position = pos

	get_tree().get_root().add_child(explode)

