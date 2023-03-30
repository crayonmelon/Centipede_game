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
	Change_Colour()

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
		
	#Release Node:
	if Centipede_Parts[node_index + 1] != null:
		print(Centipede_Parts[node_index + 1].name)
		Add_Parent(Centipede_Parts[node_index + 1])
	
	if Centipede_parents.has(node):
		Centipede_parents.erase(node)
		
	#Destroy Node:
	Centipede_Parts[node_index].queue_free()
	Centipede_Parts.erase(node)
	
	
func Add_Parent(node):
	node.is_parent = true
	Centipede_parents.append(node)
	print((Centipede_parents.size()+1) % GLOBALS.C_CONTROLS.size())
	
	if Centipede_parents.size() > GLOBALS.C_CONTROLS.size():
		return ((Centipede_parents.size()) % GLOBALS.C_CONTROLS.size())
	else:
		Centipede_parents.size()


func Change_Colour():
	for parts in Centipede_Parts:
		parts.Sprite2D.modulate = GLOBALS.C_COLOURS[0]
	pass
