extends Label
@onready var timer = $Timer

var full_text = ""
var text_displayed = ""
var max_text_size = 62
var text_step = 0
var text_options = ["WEATHER WARNING: CENTIPEDE", 
"A fully equipped adult centipede can have between 15 and 177 pairs of legs", 
"Despite common misconceptions, centipedes tend not to be particularly massive",
"Centipede make up over 80% of global shoe sales",
"The average centipede yawns for a total of 10 seconds at a time. That is why it is important for centipedes to get no less than eight hours of sleep.",
"Aside from having over 100 legs, a fully developed adult centipede also has two fully functional arms. They choose, however, to hide this fact due to embarrassment."]

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
