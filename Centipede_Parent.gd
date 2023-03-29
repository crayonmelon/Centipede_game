extends Node2D

var Centipede_Parts = []

var motion = Vector2.ZERO
var parent = null

func _ready():
	New_Centipede()


func New_Centipede():
	for _i in self.get_children():
		Centipede_Parts.append(_i)

	parent = Centipede_Parts[0]
	
	Centipede_Parts[0].is_parent = true
	
	for i in len(Centipede_Parts):
		if i == 0:
			continue
		
		var unit = Centipede_Parts[i]
		unit.is_parent = false
		unit.following = Centipede_Parts[i-1]
		
