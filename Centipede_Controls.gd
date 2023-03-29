extends CharacterBody2D

@export var is_parent = false
@export var following : Node

@export var rotation_speed = 1.5
var speed = 100
var rotation_direction = 0
var turn_speed = 2

func _parent_move():
	rotation_direction = Input.get_axis("Left", "Right") * turn_speed
	velocity = transform.x *speed
	
	move_and_slide()

func _child_move(delta):
	global_position = global_position.lerp(following.global_position,.1)
	look_at(following.global_position)
	pass

func _process(delta):
	if is_parent:
		_parent_move()
	else:
		_child_move(delta)
		
func _physics_process(delta):
	rotation += rotation_direction * rotation_speed * delta
	
	pass
	
func Dies():
	is_parent = true
	pass

func _input_event(viewport, event, shape_idx):
	if event.is_pressed():
		print("wow")
