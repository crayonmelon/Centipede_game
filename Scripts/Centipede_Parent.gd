extends Node2D

var Centipede_Parts = []

var motion = Vector2.ZERO
var parent = null
var number_of_parts = 50
var centipede_part = preload("res://scenes/centipede_body.tscn")

@export var Icons: Array[RichTextLabel] = []


func _ready():

	for j in range(number_of_parts):
		add_child(centipede_part.instantiate())
	
	New_Centipede()
	


func New_Centipede():
	for _i in self.get_children():
		Centipede_Parts.append(_i)

	#Fist Parent
	Centipede_Parts[0].is_parent = true
	GLOBALS.CAMERA_TRACK.append(Centipede_Parts[0])
	GLOBALS.CAMERA_TRACK.append(Centipede_Parts[Centipede_Parts.size()-1])
	
	for i in len(Centipede_Parts):
		if i == 0:
			continue
		
		var unit = Centipede_Parts[i]
		unit.is_parent = false
		unit.following = Centipede_Parts[i-1]


func Died(node):
	var node_index = -1
	#Find Node ID
	if Centipede_Parts.has(node):
		node_index = Centipede_Parts.find(node)
	else:
		return
	
	if GLOBALS.CAMERA_TRACK.has(node):
		GLOBALS.CAMERA_TRACK.erase(node)
		
	
	#remove from camera_track
	if node.is_parent:
		GLOBALS.CAMERA_TRACK.erase(node)
	
	#Release Node:
	if Centipede_Parts.size() > node_index+1 && node.is_parent:
		Add_Parent(Centipede_Parts[node_index + 1])


	elif Centipede_Parts.size() > node_index+1:
		Centipede_Parts[node_index + 1].is_missile = true
	
	Count_Centipede_Size()
	
	#Destroy Node:
	Centipede_Parts[node_index].queue_free()
	Centipede_Parts.remove_at(node_index)

func Count_Centipede_Size():
	
	#count the size of every ssegment
	var size = 0
	var Centipede_Parents = []

	#break up centipede
	for part in reverse_array(Centipede_Parts):
		if part.is_parent or part.is_missile:
			Centipede_Parents.append([part, size])
			size = 0
		size+=1	
		
	Centipede_Parents.sort_custom(func(a, b): return a[1] > b[1])
	
	if Centipede_Parents[0][0].is_parent:
		return
	
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
	
	Change_Colour()
	
	
func Set_Sibling_Wrapping(node):
	
	GLOBALS.EDGING = false
	
	var node_index = -1
	#Find Node ID
	if Centipede_Parts.has(node):
		node_index = Centipede_Parts.find(node)
	else:
		return
	
	if Centipede_Parts.size() > node_index+1:
		Centipede_Parts[node_index + 1].wrapping = true
		GLOBALS.EDGING = true
		
	else:
		GLOBALS.EDGING = false

func Set_Sibling_Tunneling(node):
	
	GLOBALS.EDGING = false
	
	var node_index = -1
	#Find Node ID
	if Centipede_Parts.has(node):
		node_index = Centipede_Parts.find(node)
	else:
		return
	
	if Centipede_Parts.size() > node_index+1:
		Centipede_Parts[node_index + 1].Start_Tunneling()
		

func Add_Parent(node):
	node.is_parent = true
	
	GLOBALS.CAMERA_TRACK.append(node)
	node.controls_val = 0
	
func Change_Colour():
	print("color ")
	
	var col_val = 0
	
	for i in range(Centipede_Parts.size()):
		
		if Centipede_Parts[i].is_parent:
			col_val = 0
		elif Centipede_Parts[i].is_missile:
			col_val = 2

		Centipede_Parts[i].get_node("Sprite2D").material.set("shader_parameter/color_tint", GLOBALS.C_COLOURS[col_val])

func reverse_array(array):
	var new_array = []
	
	for i in array:
		new_array.push_front(i)
		
	return new_array
	
func sort_descending(a, b):
	if a[0] > b[0]:
		return true
	return false



