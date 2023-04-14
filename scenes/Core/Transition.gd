extends CanvasLayer

var main_music = preload("res://Audio/Music/CENTIPEDE.ogg")
var intro = preload("res://Audio/Music/Intro_Music.ogg")

func Transistion_Intro(target: String, scene) -> void:
	$AudioStreamPlayer.stream = intro
	
	$Background_Background/AnimationPlayer.play("TransitionEffec")
	await $Background_Background/AnimationPlayer.animation_finished
	scene.queue_free()
	
	$VideoStreamPlayer.play()
	$AudioStreamPlayer.play()
	
	await $AudioStreamPlayer.finished
	$AudioStreamPlayer.stream = main_music
	$AudioStreamPlayer.play()
	
	await $VideoStreamPlayer.finished
	
	$Background_Background/AnimationPlayer.play_backwards("TransitionEffec")
	
	get_tree().change_scene_to_file(target)


func Change_Scene(target: String, scene) -> void:
	$AudioStreamPlayer.stop()
	scene.queue_free()
	$Background_Background/AnimationPlayer.play("TransitionEffec")
	
	await $Background_Background/AnimationPlayer.animation_finished

	
	$Background_Background/AnimationPlayer.play_backwards("TransitionEffec")

	get_tree().change_scene_to_file(target)
