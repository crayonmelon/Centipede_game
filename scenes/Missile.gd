extends StaticBody2D

var speed = 50

var fall_left = false

func _ready():
	if fall_left:
		$AnimationPlayer.play("bomb_curve")
	else:
		$AnimationPlayer.play("bomb_curve_flipped")
		
func _process(delta):
	position += transform.y * speed * delta

func _on_timer_timeout():
	die()

func die():
	GLOBALS.EXPLODE_EFFECT(self.position, true)
	queue_free()
