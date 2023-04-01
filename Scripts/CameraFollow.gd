extends Camera2D

var screen_size = 160

var max_size = false

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
	
	if max_size:
		midPoint = Vector2(0,0)
		
	target = midPoint
	
	global_position = global_position.lerp(target,.1)


func camera_scale():
	
	var scale = 1.5
	zoom.x = scale
	zoom.y = scale
	var furthest_distance = 0
	
	for point in GLOBALS.CENTIPEDES_PARENTS + GLOBALS.CENTIPEDES_ENDS:
		var x_dis = abs(position.x - point.global_position.x) 
		var y_dis = abs(position.y - point.global_position.y)
		
		if x_dis > furthest_distance || y_dis > furthest_distance:
			furthest_distance = x_dis if x_dis > y_dis else y_dis
	
	scale = ((screen_size)/furthest_distance)
	
	if GLOBALS.EDGING or scale < .6:
		max_size = true
		zoom.x = lerpf(zoom.x,.5, .9)
		zoom.y = lerpf(zoom.y,.5, .9)
	
	elif scale < 1.5: 
		max_size = false
		zoom.x = lerpf(zoom.x,scale, .9)
		zoom.y = lerpf(zoom.y,scale, .9)
		
