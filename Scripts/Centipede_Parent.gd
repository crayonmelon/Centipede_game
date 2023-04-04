extends Node2D

var Centipede_Parts = []

var motion = Vector2.ZERO
var parent = null
var number_of_parts = 50
var centipede_part = preload("res://scenes/centipede_body.tscn")

@export var Icons: Array[RichTextLabel] = []


func _ready():
	
	for icon in $"../CanvasLayer".get_children():
		Icons.append(icon)
	
	print(Icons.size())
	
	for j in range(number_of_parts):
		add_child(centipede_part.instantiate())
	
	New_Centipede()
	Change_Colour(0)


func New_Centipede():
	for _i in self.get_children():
		Centipede_Parts.append(_i)

	#Fist Parent
	Centipede_Parts[0].is_parent = true
	GLOBALS.CENTIPEDES_PARENTS.append(Centipede_Parts[0])
	GLOBALS.CENTIPEDES_ENDS.append(Centipede_Parts[Centipede_Parts.size()-1])
	
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
		GLOBALS.CENTIPEDES_PARENTS.erase(node)
	
	if GLOBALS.CENTIPEDES_ENDS.has(node):
		GLOBALS.CENTIPEDES_ENDS.erase(node)
	
	#Release Node:
	if Centipede_Parts.size() > node_index+1:
		Add_Parent(Centipede_Parts[node_index + 1])
	
	if node_index -1 > 0:
		GLOBALS.CENTIPEDES_ENDS.append(Centipede_Parts[node_index-1])
	
	#Destroy Node:
	Centipede_Parts[node_index].queue_free()
	Centipede_Parts.remove_at(node_index)
	
	Change_Colour(node_index)


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


func Add_Parent(node):
	node.is_parent = true
	
	GLOBALS.CENTIPEDES_PARENTS.append(node)
	node.controls_val = GLOBALS.CENTIPEDES_PARENTS.size() % GLOBALS.C_CONTROLS.size()
	set_icon(GLOBALS.CENTIPEDES_PARENTS.size() % GLOBALS.C_CONTROLS.size(), true)
	
	
func Change_Colour(start_val):
	var col_val = 0
	
	for i in range(start_val, Centipede_Parts.size()):
		
		if Centipede_Parts[i].controls_val > col_val:
			col_val = Centipede_Parts[i].controls_val
		
		Centipede_Parts[i].get_node("Sprite2D").modulate = GLOBALS.C_COLOURS[col_val]


func set_icon(id, enable):
	for icon in Icons:
		if icon.id == id:
			icon.enable_text(enable)
			return
