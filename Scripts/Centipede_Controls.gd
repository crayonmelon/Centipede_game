extends CharacterBody2D

var health = 3

@export var is_parent = false
@export var is_missile = false

var started_tunneling = false
var tunneling = false

@export var following : Node
@export var controls_val = 0

@export var rotation_speed = 1.5
var speed = 100
var rotation_direction = 0
var turn_speed = 2

var wrapping = false
var follow_target = Vector2(0,0)

@export var use_custom_screen_wrap = false
var custom_screen_wrap_val : Vector4 = Vector4i(0,480,0,480)


func _parent_move():
	rotation_direction = Input.get_axis(GLOBALS.C_CONTROLS[controls_val][0], GLOBALS.C_CONTROLS[controls_val][1]) * turn_speed
	velocity = transform.x * (speed + (100 if Input.is_action_pressed("1_faster") else 0) * 0 if !started_tunneling else 1)
	
	if Input.is_action_just_pressed("1_dig"):
		Start_Tunneling()
	
func _child_move(delta):
	
	if started_tunneling:
		global_position = global_position
	elif !wrapping:
		follow_target = following.global_position
		global_position = global_position.lerp(follow_target,.22)

		look_at(follow_target)
	else:
		global_position += transform.x * speed * delta

func _missile_move(delta):
	rotation_direction = 0
	global_position += transform.x * speed * delta
	velocity = transform.x
	
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
		if collision.get_collider().get_collision_layer() == 2 and !tunneling:
			Dies()
			collision.get_collider().die()
	
	
	if use_custom_screen_wrap:
		screen_wrap_custom()
	else:
		screen_wrap()
func Dies():
	health -= 1
	if health <=0:
		GLOBALS.EXPLODE_EFFECT(self.global_position)
		get_parent().Died(self)
		#is_parent = true
	Change_Shader_Params()
	
func Change_Shader_Params():
	print("healths", health)
	if health == 3:
		$Sprite2D.material.set("shader_parameter/sensitivity", 0)
	elif health == 2:
		$Sprite2D.material.set("shader_parameter/sensitivity", .5)
	elif health == 1:
		$Sprite2D.material.set("shader_parameter/sensitivity", .75)
	
func screen_wrap_custom():
	if (position.x > custom_screen_wrap_val.y or position.x < custom_screen_wrap_val.x or 
	position.y > custom_screen_wrap_val.w or position.y < custom_screen_wrap_val.z):

		get_parent().Set_Sibling_Wrapping(self)
		wrapping = false

	position.x = wrapf(position.x,custom_screen_wrap_val.x, custom_screen_wrap_val.y)
	position.y = wrapf(position.y,custom_screen_wrap_val.z, custom_screen_wrap_val.w)

	
func screen_wrap():

	if (position.x > GLOBALS.WORLD_BORDER_X_MAX or position.x < GLOBALS.WORLD_BORDER_X_MIN or 
	position.y > GLOBALS.WORLD_BORDER_Y_MAX or position.y < GLOBALS.WORLD_BORDER_Y_MIN):

		get_parent().Set_Sibling_Wrapping(self)
		wrapping = false

	position.x = wrapf(position.x,GLOBALS.WORLD_BORDER_X_MIN, GLOBALS.WORLD_BORDER_X_MAX)
	position.y = wrapf(position.y,GLOBALS.WORLD_BORDER_Y_MIN, GLOBALS.WORLD_BORDER_Y_MAX)

func Start_Tunneling():
	
	#BEGIN THE TUNNELING  - started_tunneling: used for transition effect
	$Sprite2D/AnimationPlayer.play("Tunneling")
	started_tunneling = true

	#bring to stop
	velocity = Vector2.ZERO
	
	#Add effects
	if !is_parent:
		$Sprite2D.visible = false
	
	await get_tree().create_timer(.1).timeout
	$DiggingParticle.emitting = true
	$CollisionShape.disabled = true
	started_tunneling = false 
	tunneling = true
	
	get_parent().Set_Sibling_Tunneling(self)
	
	# Wait till tunneling over
	await $Sprite2D/AnimationPlayer.animation_finished
	
	#reset everything
	$DiggingParticle.emitting = false
	$Sprite2D.visible = true
	tunneling = false
	$CollisionShape.disabled = false
	
	
	Change_Shader_Params()
	$Sprite2D/AnimationPlayer.play("centipede_anim")
	
func _on_tunneling_timer_timeout():
	$Sprite2D.visible = true
	pass
