extends CanvasLayer

@onready var score_meter = $score_meter
@onready var angery_meter = $angery_meter
@onready var centipede_parts = $centipede_parts


func increase_score(val):
	score_meter.text = "CARNAGE: " + str(val)


func update_health():
	centipede_parts.text = str(GLOBALS.CENTIPEPE_PARTS.size()) +"/50"
	#camera shake + effects ig
