extends StaticBody2D

var speed = 50

func _process(delta):
	position += transform.y * speed * delta

func _on_timer_timeout():
	die()

func die():
	GLOBALS.EXPLODE_EFFECT(self.position)
	
	queue_free()
