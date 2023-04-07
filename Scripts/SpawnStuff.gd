extends Node2D

var peopleSpawn = 10

var buildin = preload("res://scenes/buildings/buildin.tscn")
var civ = preload("res://scenes/civilian.tscn")

var enemy_1 = preload("res://scenes/Enemy.tscn")

func _ready():
	Spawn_Stuff(buildin,30)
	Spawn_Stuff(civ,15)
	
	Spawn_Enemies(enemy_1,3) 

func Spawn_Stuff(spawny, num):
	for n in range(num):
		var obj = spawny.instantiate()
		obj.global_position = rand_Vector()
		add_child(obj)

func rand_Vector():

	return Vector2(
		randi_range(GLOBALS.WORLD_BORDER_X_MIN, GLOBALS.WORLD_BORDER_X_MAX), 
		randi_range(GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX))

func Spawn_Enemies(spawny, num):
	$SpawnEnemy.start(3)
	
	for n in range(num):
		var obj = spawny.instantiate()
		obj.global_position = rand_Vector()
		add_child(obj)

