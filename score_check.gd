extends CanvasLayer

@onready var score_meter = $score_meter
var current_score = 0
@onready var angery_meter = $angery_meter
var current_angery = 0

@onready var combo_timer = $combo_timer
@onready var combo_meter = $combo_meter
var current_combo = 1

func increase_score(val):
	
	current_score += val * current_combo
	score_meter.text = "SCORE: " + str(current_score)

func combo_controller():
	combo_timer.start()
