extends Area2D

var goto = Vector2(0,0)
var run = false

@export var invinso_frames = 1
var invisible = true

func _ready():
	$civ/AnimationPlayer.play("run" if run else "walk")
	invinso_event()
	walk()

func walk():
	var tween = create_tween()
	tween.tween_property(self, "position", rand_Vector(100), randf_range(2,4))
	await tween.finished
	walk()

func _on_body_entered(body):
	if !invisible:
		$civ/AnimationPlayer.play("die_2")
		await $civ/AnimationPlayer.animation_finished
		
		queue_free()

func rand_Vector(range):
	return Vector2(
		clamp(randi_range(global_position.x-range, global_position.x+range),GLOBALS.WORLD_BORDER_X_MIN,GLOBALS.WORLD_BORDER_X_MAX), 
		clamp(randi_range(global_position.y-range, global_position.y+range),GLOBALS.WORLD_BORDER_Y_MIN,GLOBALS.WORLD_BORDER_Y_MAX)
		)

func invinso_event():
	await get_tree().create_timer(invinso_frames).timeout
	invisible = false
