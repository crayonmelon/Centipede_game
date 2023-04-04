extends RichTextLabel

@export var id = 0
@export var show = false

var prompts = ["[center]A/D", "[center]←/→", "[center]J/L", "[center]F/H"]

func _ready():
	modulate = GLOBALS.C_COLOURS[id]
	text = prompts[id]
	enable_text(show)

func enable_text(enable):
	visible = enable

func _input(event):
	if event.is_action_pressed(GLOBALS.C_CONTROLS[id][0]) or event.is_action_pressed(GLOBALS.C_CONTROLS[id][1]):
		$AnimationPlayer.play("bounce")
