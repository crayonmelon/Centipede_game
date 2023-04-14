extends Area2D

var screams = [preload("res://Audio/Scream/screams_1.ogg"), preload("res://Audio/Scream/screams_2.ogg"), preload("res://Audio/Scream/scream_3.ogg"), preload("res://Audio/Scream/scream_4.ogg"), preload("res://Audio/Scream/scream_5.ogg")]
var splat = preload("res://Audio/Effects/splatt.ogg")
var goto = Vector2(0,0)
var run = false

@export var invinso_frames = 1
var invisible = true

func _ready():
	$civ/AnimationPlayer.play("run" if run else "walk")
	invinso_event()
	walk()
	
	if run and randf() >.5:
		$ScreamPlayer.stream = screams[randi_range(0,screams.size()-1)]
		$ScreamPlayer.play()

func walk():
	var tween = create_tween()
	tween.tween_property(self, "position", rand_Vector(100), randf_range(2,4))
	await tween.finished
	walk()

func _on_body_entered(body):
	if !invisible:
		$CollisionShape2D.queue_free()
		GLOBALS.UPDATE_SCORE(1)
		GLOBALS.ADD_KILLS(GLOBALS.Enemy_Type.CIVILIAN)
		_random_death()
		

func _random_death():
	var rand = randf()

	$ScreamPlayer.stream = splat
	$ScreamPlayer.play()

	if rand > .5:
		$civ/AnimationPlayer.play("die_2")
		await $civ/AnimationPlayer.animation_finished
	else:
		$civ.visible = false
		$DiggingParticle.emitting = true
		await get_tree().create_timer(1).timeout
	
	queue_free()
	
func rand_Vector(range):
	return Vector2(
		clamp(randi_range(global_position.x-range, global_position.x+range),GLOBALS.WORLD_BORDER_X_MIN,GLOBALS.WORLD_BORDER_X_MAX), 
		clamp(randi_range(global_position.y-range, global_position.y+range),GLOBALS.WORLD_BORDER_Y_MIN,GLOBALS.WORLD_BORDER_Y_MAX)
		)

func invinso_event():
	await get_tree().create_timer(invinso_frames).timeout
	invisible = false
