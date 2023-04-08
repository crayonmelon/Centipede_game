extends Node

@onready var spawner = $Spawner
@onready var score_controller = $SCORE_CONTROLLER
@onready var spawn_timer = $SpawnEnemy


var enemy_fella = preload("res://scenes/Enemy.tscn")
var enemy_tank = preload("res://scenes/Tank.tscn")

var enemies_cost = [[enemy_fella, 5], [enemy_tank, 15]]

var current_angery = 1
var current_score = 0

var difficulty = 0
var started = false

var budget = 0

func difficulty_check(val):
	
	if started: return
	
	if current_score > 100:
		started = true
		difficulty +=1
		Enemy_Spawner()

func increase_score(val):
	current_score += val * current_angery
	budget += val * current_angery
	difficulty_check(current_score)
	score_controller.increase_score(current_score)

func Enemy_Spawner():
	
	# Difficulty check and valuer
	print("budget: ",budget)
	while budget > 0:
		var ran = randi_range(0, enemies_cost.size()-1)
		budget -= enemies_cost[ran][1]
		
		if enemies_cost[ran][1] < budget:
			Spawn_Stuff(enemies_cost[ran][0], 1)
	
	
	spawn_timer.start(randi_range(5,7))
	
	await spawn_timer.timeout
	
	Enemy_Spawner()
	

func Spawn_Stuff(spawny, num):
	for n in range(num):
		var obj = spawny.instantiate()
		obj.global_position = rand_Vector()
		add_child(obj)

func rand_Vector():

	return Vector2(
		randi_range(GLOBALS.WORLD_BORDER_X_MIN, GLOBALS.WORLD_BORDER_X_MAX), 
		randi_range(GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX))
