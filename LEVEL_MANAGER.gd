extends Node

@onready var spawner = $Spawner
@onready var score_controller = $SCORE_CONTROLLER
@onready var spawn_timer = $SpawnEnemy

enum DIR {NORTH, SOUTH, EAST, WEST, NONE}

var WAVE = 0
var WAVES_GOALS = ["CARNAGE", "DESTROY 10 TANKS", "DESTROY THE HELICOPTER", "BEES?!"]

var warning_system = preload("res://scenes/warningsytem.tscn")

var enemy_fella = preload("res://scenes/Enemies/Enemy_gunner.tscn")
var enemy_tank = preload("res://scenes/Enemies/Tank.tscn")
var enemy_bus = preload("res://scenes/Enemies/Enemy_Bus.tscn")
var enemy_heli = preload("res://scenes/Enemies/Enemy_Heli.tscn")

var enemy_collection = [[enemy_fella, 5, DIR.NONE], [enemy_tank, 15, DIR.NONE], [enemy_bus, 25, DIR.EAST], [enemy_heli, 50, DIR.WEST]]

var current_angery = 1
var current_score = 0

var difficulty = 0
var started = false

var budget = 0

func _ready():
	DisplayServer.window_set_size(Vector2(958, 720))
	
func _process(delta):
	
	# Task text 
	
	if WAVE == 1:
		$SCORE_CONTROLLER/angery_meter.text = "TASK: " + " DESTROY " + str(5 - (GLOBALS.FIND_KILLS(GLOBALS.Enemy_Type.TANK) ) ) + " Tanks"


func Wave_Update(val):
	
	if current_score > 100 and WAVE <= 0:
		Wave_Change(1)
	elif current_score > 1000 and WAVE <= 1:
		Wave_Change(2)
		
func Wave_Change(wave_val):
	WAVE = wave_val
	
	var warn_system = warning_system.instantiate()
	warn_system.wave_val = wave_val
	add_child(warn_system)
	
	$SCORE_CONTROLLER/angery_meter.text = "TASK: " + str(WAVES_GOALS[WAVE])
	$SCORE_CONTROLLER/angery_meter/AnimationPlayer.play("Shake")
	WAVE_SPAWN()

func WAVE_SPAWN():
	
	if WAVE == 1:
		Enemy_Spawner([enemy_collection[0],enemy_collection[1]])
		
		if GLOBALS.FIND_KILLS(GLOBALS.Enemy_Type.TANK) >= 5: 
			Wave_Change(2)
		
	elif WAVE == 2:
		if GLOBALS.FIND_KILLS(GLOBALS.Enemy_Type.HELICOPTER) >= 1: 
			Wave_Change(3)
		Enemy_Spawner([enemy_collection[2]])
	pass

func increase_score(val):
	current_score += val * current_angery
	budget += val * current_angery
	Wave_Update(current_score)
	score_controller.increase_score(current_score)

func tank_count():
	pass

func Enemy_Spawner(enemySpawnList):
	
	# Difficulty check and valuer
	print("budget: ",budget)
	while budget > 0:
		var ran = randi_range(0, enemySpawnList.size()-1)
		budget -= enemySpawnList[ran][1]
		
		if enemySpawnList[ran][1] < budget:
			var obj = enemySpawnList[ran][0].instantiate()

			obj.global_position = rand_outside_border(enemySpawnList[ran][2])
			add_child(obj)

	spawn_timer.start(randi_range(5,7)) 
	await spawn_timer.timeout
	
	WAVE_SPAWN()

func Spawn_Stuff(spawny, num):
	for n in range(num):
		var obj = spawny.instantiate()
		obj.global_position = rand_Vector()
		add_child(obj)

func rand_Vector():

	return Vector2(
		randi_range(GLOBALS.WORLD_BORDER_X_MIN, GLOBALS.WORLD_BORDER_X_MAX), 
		randi_range(GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX))
		
func rand_outside_border(direction = DIR.NONE):
	
	if direction == DIR.NONE:
		direction = DIR.values()[randi_range(0,3)]
		
	if direction == DIR.NORTH:
		return Vector2(randi_range(GLOBALS.WORLD_BORDER_X_MIN, GLOBALS.WORLD_BORDER_X_MAX), GLOBALS.WORLD_BORDER_Y_MIN)
		
	elif direction == DIR.EAST:
		return Vector2(GLOBALS.WORLD_BORDER_X_MAX, randi_range(GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX))
			
	elif direction == DIR.SOUTH:
		return Vector2(randi_range(GLOBALS.WORLD_BORDER_X_MIN, GLOBALS.WORLD_BORDER_X_MAX), GLOBALS.WORLD_BORDER_Y_MAX)
		
	elif direction == DIR.WEST:
		return Vector2(GLOBALS.WORLD_BORDER_X_MIN, randi_range(GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX))
		
	else:
		return Vector2(0,0)
