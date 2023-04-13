extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(self, "volume_db", 0, 5).set_ease(Tween.EASE_IN)


func _process(delta):
	pass
