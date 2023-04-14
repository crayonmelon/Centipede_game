extends Node2D
var motion = Vector2.ZERO
var parent = null
var number_of_parts = 50
var centipede_part = preload("res://scenes/centipede_body.tscn")


@export var Icons: Array[RichTextLabel] = []

@export var is_menu = false

func _ready():

	for j in range(number_of_parts):
		add_child(centipede_part.instantiate())
	
	New_Centipede()


func New_Centipede():
	for _i in self.get_children():
		GLOBALS.CENTIPEPE_PARTS.append(_i)

	#Fist Parent
	GLOBALS.CENTIPEPE_PARTS[0].is_parent = true
	GLOBALS.CAMERA_TRACK.append(GLOBALS.CENTIPEPE_PARTS[0])
	GLOBALS.CAMERA_TRACK.append(GLOBALS.CENTIPEPE_PARTS[GLOBALS.CENTIPEPE_PARTS.size()-1])
	
	
	for i in len(GLOBALS.CENTIPEPE_PARTS):
		if i == 0:
			continue
		
		var unit = GLOBALS.CENTIPEPE_PARTS[i]
		unit.is_parent = false
		unit.following = GLOBALS.CENTIPEPE_PARTS[i-1]

	if is_menu:
		for i in len(GLOBALS.CENTIPEPE_PARTS):
			var unit = GLOBALS.CENTIPEPE_PARTS[i]
			unit.use_custom_screen_wrap = true

func Died(node):
	var node_index = -1
	#Find Node ID
	if GLOBALS.CENTIPEPE_PARTS.has(node):
		node_index = GLOBALS.CENTIPEPE_PARTS.find(node)
	else:
		return
	
	if GLOBALS.CAMERA_TRACK.has(node):
		GLOBALS.CAMERA_TRACK.erase(node)
		
	
	#remove from camera_track
	if node.is_parent:
		GLOBALS.CAMERA_TRACK.erase(node)
	
	#Release Node:
	if GLOBALS.CENTIPEPE_PARTS.size() > node_index+1 && node.is_parent:
		Add_Parent(GLOBALS.CENTIPEPE_PARTS[node_index + 1])


	elif GLOBALS.CENTIPEPE_PARTS.size() > node_index+1:
		GLOBALS.CENTIPEPE_PARTS[node_index + 1].is_missile = true
	
	Count_Centipede_Size()
	
	#Destroy Node:
	GLOBALS.CENTIPEPE_PARTS[node_index].queue_free()
	GLOBALS.CENTIPEPE_PARTS.remove_at(node_index)
	GLOBALS.UPDATE_TEXT()
	
	if GLOBALS.CENTIPEPE_PARTS.size() <= 3:
		get_tree().paused = true
		TRANSITION.Change_Scene("res://scenes/Core/Game_Over.tscn", self)

func Count_Centipede_Size():
	
	#count the size of every ssegment
	var size = 0
	var Centipede_Parents = []

	#break up centipede
	for part in reverse_array(GLOBALS.CENTIPEPE_PARTS):
		if part.is_parent or part.is_missile:
			Centipede_Parents.append([part, size])
			size = 0
		size+=1	
		
	Centipede_Parents.sort_custom(func(a, b): return a[1] > b[1])
	
	#if Centipede_Parents[0][0].is_parent:
	#	return
	
	##NEW PARENTS PAST THIS POINT##
	
	Centipede_Parents[0][0].is_parent = true
	
	#make smallest missiles
	for i in range(Centipede_Parents.size()):
		if i == 0:
			continue
			
		Centipede_Parents[i][0].is_parent = false
		Centipede_Parents[i][0].is_missile = true
		
	GLOBALS.CAMERA_TRACK = []
	GLOBALS.CAMERA_TRACK.append(Centipede_Parents[0][0])
	#GLOBALS.CAMERA_TRACK.append(Centipede_Parents[0][GLOBALS.CENTIPEPE_PARTS[0][GLOBALS.CENTIPEPE_PARTS.size()-1]])
	Change_Colour()
	
	
func Set_Sibling_Wrapping(node):
	
	GLOBALS.EDGING = false
	
	var node_index = -1
	#Find Node ID
	if GLOBALS.CENTIPEPE_PARTS.has(node):
		node_index = GLOBALS.CENTIPEPE_PARTS.find(node)
	else:
		return
	
	if GLOBALS.CENTIPEPE_PARTS.size() > node_index+1:
		GLOBALS.CENTIPEPE_PARTS[node_index + 1].wrapping = true
		GLOBALS.EDGING = true
		
	else:
		GLOBALS.EDGING = false

func Set_Sibling_Tunneling(node):
	
	GLOBALS.EDGING = false
	
	var node_index = -1
	#Find Node ID
	if GLOBALS.CENTIPEPE_PARTS.has(node):
		node_index = GLOBALS.CENTIPEPE_PARTS.find(node)
	else:
		return
	
	if GLOBALS.CENTIPEPE_PARTS.size() > node_index+1:
		GLOBALS.CENTIPEPE_PARTS[node_index + 1].Start_Tunneling()
		

func Add_Parent(node):
	node.is_parent = true
	
	GLOBALS.CAMERA_TRACK.append(node)
	node.controls_val = 0
	
func Change_Colour():
	print("color ")
	
	var col_val = 0
	
	for i in range(GLOBALS.CENTIPEPE_PARTS.size()):
		
		if GLOBALS.CENTIPEPE_PARTS[i].is_parent:
			col_val = 0
		elif GLOBALS.CENTIPEPE_PARTS[i].is_missile:
			col_val = 2

		GLOBALS.CENTIPEPE_PARTS[i].get_node("Sprite2D").material.set("shader_parameter/color_tint", GLOBALS.C_COLOURS[col_val])

func reverse_array(array):
	var new_array = []
	
	for i in array:
		new_array.push_front(i)
		
	return new_array
	
func sort_descending(a, b):
	if a[0] > b[0]:
		return true
	return false



