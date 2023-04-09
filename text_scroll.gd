extends Label
@onready var timer = $Timer

var full_text = ""
var text_displayed = ""
var max_text_size = 62
var text_step = 0
var text_options = ["WEATHER WARNING: CENTIPEDE", "A fully equipped adult centipede can have between 15 and 177 pairs of legs", "MILATARY ALERT: MAYBE A CENTIPEDE"]

func _ready():
	combine_array()

func combine_array():
	for text in text_options:
		full_text += text + " -- "
	pass

func _on_timer_timeout():
	text_displayed = ""
	text_step += 1
	
	if text_step >= full_text.length():
		text_step = 0
	
	var overflow = 0
	
	for _i in range(text_step, max_text_size+ text_step):
		if full_text.length() > _i:
			text_displayed += full_text[_i]
		else:
			text_displayed += full_text[overflow]
			overflow+= 1
	text = text_displayed
