extends Camera2D

func _ready():
	
	pass # Replace with function body.

var target = Vector2(0,0)

func _process(delta):
	camera_pos()
	camera_scale()

func camera_pos():
		# MidPoint Formula
	var x_vals = 0 
	var y_vals = 0
	
	for point in GLOBALS.CENTIPEDES_PARENTS:
		x_vals += point.global_position.x
		y_vals += point.global_position.y
	
	var midPoint = Vector2((x_vals/GLOBALS.CENTIPEDES_PARENTS.size()), (y_vals/GLOBALS.CENTIPEDES_PARENTS.size()))
	
	target = midPoint
	
	global_position = global_position.lerp(target,.2)
	pass

var screen_size = 320

func camera_scale():
	
	var scale = 1
	
	var furthest_distance = 0
	
	for point in GLOBALS.CENTIPEDES_PARENTS:
		var x_dis = abs(position.x - point.global_position.x)
		var y_dis = abs(position.y - point.global_position.y)
		
		if x_dis > furthest_distance || y_dis > furthest_distance:
			furthest_distance = x_dis if x_dis > y_dis else y_dis
	
	scale = ((screen_size)/furthest_distance)
	
	if scale < 1: 
		zoom.x = scale
		zoom.y = scale
	
	print(scale)
