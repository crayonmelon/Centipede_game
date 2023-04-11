extends CanvasLayer

@onready var warning_level = $Warning_Level
@onready var scroll = $Scroll
@onready var announcement = $Announcement


var full_text = ""
var text_displayed = ""
var max_text_size = 20
var text_step = 0

var wave_val = 0

var threat_levels = ["MAYBE A CENTIPEDE?! ", "OH FUCK A CENTIPEDE ", "FEAR THE CENTIPEDE ", "OH SHIT OH FUCK OH SHIT OH FUCK " ,"WE GONNA USE THE NUKES "]

func _ready():
	wave_update(wave_val)
	
	await get_tree().create_timer(5).timeout 
	
	queue_free()


func wave_update(WAVE):
	full_text = threat_levels[WAVE-1]
	warning_level.text = "THREAT LEVEL " +  str(WAVE)


func _on_scroll_timer_timeout():
	text_displayed = ""
	text_step += 1
	
	if text_step >= full_text.length():
		text_step = 0
	
	var overflow = 0
	
	for _i in range(text_step, max_text_size + text_step):
		if full_text.length() > _i:
			text_displayed += full_text[_i]
		else:
			text_displayed += full_text[overflow]
			overflow+= 1
	scroll.text = text_displayed
