extends CharacterBody2D

@export var is_parent = false
@export var following : Node
@export var controls_val = 0

@export var rotation_speed = 1.5
var speed = 100
var rotation_direction = 0
var turn_speed = 2

func _parent_move():
	rotation_direction = Input.get_axis(GLOBALS.C_CONTROLS[controls_val][0], GLOBALS.C_CONTROLS[controls_val][1]) * turn_speed
	velocity = transform.x * speed


func _child_move(delta):
	global_position = global_position.lerp(following.global_position,.22)
	look_at(following.global_position)


func _process(delta):
	if is_parent:
		_parent_move()
	else:
		_child_move(delta)
	
	if Input.is_action_pressed("Click"):
		if (get_viewport().get_mouse_position().x > global_position.x-6 and 
			get_viewport().get_mouse_position().x < global_position.x+6 and
			get_viewport().get_mouse_position().y > global_position.y-6 and 
			get_viewport().get_mouse_position().y < global_position.y+6):
				
			Dies()
			
	rotation += rotation_direction * rotation_speed * delta
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().get_collision_layer() == 2:
			Dies()
			collision.get_collider().queue_free()

func Dies():
	get_parent().Died(self)
	is_parent = true
