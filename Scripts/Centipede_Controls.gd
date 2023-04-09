extends CharacterBody2D

var health = 3

@export var is_parent = false
@export var is_missile = false
@export var following : Node
@export var controls_val = 0

@export var rotation_speed = 1.5
var speed = 100
var rotation_direction = 0
var turn_speed = 2

var wrapping = false
var follow_target = Vector2(0,0)

func _parent_move():
	rotation_direction = Input.get_axis(GLOBALS.C_CONTROLS[controls_val][0], GLOBALS.C_CONTROLS[controls_val][1]) * turn_speed
	velocity = transform.x * speed

func _child_move(delta):
	
	if !wrapping:
		follow_target = following.global_position
		global_position = global_position.lerp(follow_target,.22)
		look_at(follow_target)
		
	else:
		global_position += transform.x * speed * delta

func _missile_move(delta):
	rotation_direction = 0
	global_position += transform.x * speed * delta

func _process(delta):
	if is_parent:
		_parent_move()
	elif is_missile:
		_missile_move(delta)
	else:
		_child_move(delta)
	
	rotation += rotation_direction * rotation_speed * delta
	
	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().get_collision_layer() == 2:
			Dies()
			collision.get_collider().die()
	
	screen_wrap()

func Dies():
	health -= 1
	
	if health <=0:
		GLOBALS.EXPLODE_EFFECT(self.global_position)
		get_parent().Died(self)
		#is_parent = true

func screen_wrap():

	if (position.x > GLOBALS.WORLD_BORDER_X_MAX or position.x < GLOBALS.WORLD_BORDER_X_MIN or 
	position.y > GLOBALS.WORLD_BORDER_Y_MAX or position.y < GLOBALS.WORLD_BORDER_Y_MIN):

		get_parent().Set_Sibling_Wrapping(self)
		wrapping = false

	position.x = wrapf(position.x,GLOBALS.WORLD_BORDER_X_MIN, GLOBALS.WORLD_BORDER_X_MAX)
	position.y = wrapf(position.y,GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX)
