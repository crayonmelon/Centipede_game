extends CanvasLayer

@onready var score_meter = $score_meter

@onready var angery_meter = $angery_meter


func increase_score(val):
	
	score_meter.text = "CARNAGE: " + str(val)
