extends Node2D

var Centipede_Parts = []
var Centipede_parents = []

var motion = Vector2.ZERO
var parent = null
var number_of_parts = 100
var centipede_part = preload("res://scenes/centipede_body.tscn")


func _ready():
	
	for j in range(number_of_parts):
		add_child(centipede_part.instantiate())
	
	New_Centipede()
	Change_Colour(0)

func New_Centipede():
	for _i in self.get_children():
		Centipede_Parts.append(_i)

	#Fist Parent
	Centipede_Parts[0].is_parent = true
	Centipede_parents.append(Centipede_Parts[0])
	
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
		
	#remove from parents
	if node.is_parent:
		Centipede_parents.erase(node)
		
	#Release Node:
	if Centipede_Parts[node_index + 1] != null:
		Add_Parent(Centipede_Parts[node_index + 1])
	

	#Destroy Node:
	Centipede_Parts[node_index].queue_free()
	Centipede_Parts.remove_at(node_index)
	
	Change_Colour(node_index)
	
func Add_Parent(node):
	node.is_parent = true
	
	Centipede_parents.append(node)
	print(str(Centipede_parents.size()) + " parents")
	print(Centipede_parents.size() % GLOBALS.C_CONTROLS.size())

	node.controls_val = Centipede_parents.size() % GLOBALS.C_CONTROLS.size()
	

func Change_Colour(start_val):
	var col_val = 0
	
	for i in range(start_val, Centipede_Parts.size()):
		
		if Centipede_Parts[i].controls_val > col_val:
			col_val = Centipede_Parts[i].controls_val
		
		Centipede_Parts[i].get_node("Sprite2D").modulate = GLOBALS.C_COLOURS[col_val]
		
