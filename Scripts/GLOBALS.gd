extends Node
# C = CENTIPEDE

@export var C_CONTROLS = [["1_left", "1_right"]]
@export var C_COLOURS = [Color("FFFFFF"), Color("00FFFF"), Color("FF00FF"), Color("FFFF00")]
@export var CAMERA_TRACK = []
@export var CENTIPEDE_PARENTS = []
@export var WORLD_BORDER_X_MIN = -300
@export var WORLD_BORDER_X_MAX = 300

@export var WORLD_BORDER_Y_MIN = -300
@export var WORLD_BORDER_Y_MAX = 300

@export var EXPLOSIONS = [preload("res://scenes/explosions/explosion_1.tscn"), preload("res://scenes/explosions/explosion_2.tscn"), preload("res://scenes/explosions/explosion_3.tscn"), preload("res://scenes/explosions/explosion_4.tscn")]
@export var EXPLOSIONS_SOUND = [preload("res://Audio/Explosion/explosion_0.ogg"), preload("res://Audio/Explosion/explosion_1.ogg"), preload("res://Audio/Explosion/explosion_2.ogg")]

var Audio_node = preload("res://scenes/explosions/Audio.tscn")
var EDGING = false

func UPDATE_SCORE(val):
	get_tree().get_root().get_node("LEVEL_MANAGER").increase_score(val)
	
func EXPLODE_EFFECT(pos, sound = false):
	var explode = EXPLOSIONS[randi_range(0,GLOBALS.EXPLOSIONS.size()-1)].instantiate()
	explode.position = pos

	if sound:
		PLAY_BOOM(pos, EXPLOSIONS_SOUND[0],true)
	
	get_tree().get_root().add_child(explode)

func PLAY_BOOM(pos, audio, play_rand_sound = false):
	
	var noise = Audio_node.instantiate()
	if play_rand_sound:
		noise.audio_stream = EXPLOSIONS_SOUND[randi_range(0, EXPLOSIONS_SOUND.size()-1)]
	else:
		noise.audio_stream = audio
		
	noise.position = pos
	
	get_tree().get_root().add_child(noise)
	
enum Enemy_Type {BUILDING, CIVILIAN, TANK, GUNNER, BUS, HELICOPTER}
var ENEMY_KILLS = {Enemy_Type.BUILDING: 0, Enemy_Type.CIVILIAN: 0, Enemy_Type.TANK:0, Enemy_Type.GUNNER:0, Enemy_Type.BUS: 0, Enemy_Type.HELICOPTER: 0}

func ADD_KILLS(enemy_type : Enemy_Type):
	ENEMY_KILLS[enemy_type] += 1

func FIND_KILLS(enemy_type : Enemy_Type):
	return ENEMY_KILLS[enemy_type]

var Colour_Material_O = preload("res://Shader/Colour_0_Material.tres")

func CHANGE_COLOUR(colour):
	Colour_Material_O.set("shader_parameter/color_tint", colour)
