extends Camera2D

var screen_size = 220

var max_size = false

var target = Vector2(0,0)

func _process(delta):
	camera_pos()
	camera_scale(delta)

func camera_pos():
	
	# MidPoint Formula
	var x_vals = 0 
	var y_vals = 0
	
#	for point in GLOBALS.CAMERA_TRACK:
#		x_vals += point.global_position.x
#		y_vals += point.global_position.y
	
#	var midPoint = Vector2((x_vals/GLOBALS.CAMERA_TRACK.size()), (y_vals/GLOBALS.CAMERA_TRACK.size()))
	
#	if max_size:
#		midPoint = Vector2(0,0)
		
	target = GLOBALS.CAMERA_TRACK[0].position
	
	global_position = global_position.lerp(target,.1)

func camera_scale(delta):
	
	var scale = 3
	zoom.x = scale
	zoom.y = scale
	var furthest_distance = 0
	
	for point in GLOBALS.CAMERA_TRACK:
		var x_dis = abs(position.x - point.global_position.x) 
		var y_dis = abs(position.y - point.global_position.y)
		
		if x_dis > furthest_distance || y_dis > furthest_distance:
			furthest_distance = x_dis if x_dis > y_dis else y_dis
	
	scale = ((screen_size)/furthest_distance)
	
	if GLOBALS.CAMERA_TRACK.size() > 2:
		max_size = true
		zoom.x = lerpf(zoom.x,.8, 1)
		zoom.y = lerpf(zoom.y,.8, 1)
	
	elif scale < 3: 
		max_size = false
		zoom.x = scale
		zoom.y = scale
