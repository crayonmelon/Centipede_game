extends CanvasLayer

var paused = false

func _ready():
	$Chromatic_ab/HSlider.step = $Chromatic_ab/HSlider/CanvasModulate.material.get("shader_parameter/offset")
	_paused()

func _process(delta):
	if Input.is_action_just_pressed("PAUSE") and paused:
		_unpaused()

func _paused():
	get_tree().paused = true
	paused = true

func _unpaused():
	get_tree().paused = false
	queue_free()

func _on_h_slider_value_changed(value):
	$Chromatic_ab/HSlider/CanvasModulate.material.set("shader_parameter/offset", value)

func _on_reset_pressed():
	_on_h_slider_value_changed(1)
	$Chromatic_ab/HSlider.step = 1

func _on_settings_pressed():
	_unpaused()
