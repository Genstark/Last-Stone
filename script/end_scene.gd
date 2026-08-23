extends Node2D

@onready var score_label = $ScoreLabel
@onready var restart_label = $RestartLabel
@onready var base_scene = $"base-scene"

func _ready() -> void:
	var background_music: AudioStreamPlayer2D = $"end-music"
	background_music.finished.connect(background_music.play)
	background_music.play()
	_clear_button_style(restart_label)
	_update_text_color()
	var screen_size = get_viewport().get_visible_rect().size
	var center = Vector2(screen_size.x / 2, screen_size.y / 2)
	score_label.position = Vector2(center.x - score_label.size.x / 2, center.y - score_label.size.y / 2)
	restart_label.position = Vector2(center.x - restart_label.size.x / 2, score_label.position.y + score_label.size.y - 30)
	# Read data from scene tree meta
	var total_shots = get_tree().get_meta("total_shots")
	score_label.text = "Total Shots: " + str(total_shots)

func _update_text_color() -> void:
	var text_color = Color("#f7f1df") if base_scene.current_period in ["night", "sunset"] else Color("#17212b")
	score_label.add_theme_color_override("font_color", text_color)
	restart_label.add_theme_color_override("font_color", text_color)

func _clear_button_style(btn: Button) -> void:
	btn.focus_mode = Control.FOCUS_NONE
	btn.mouse_filter = Control.MOUSE_FILTER_PASS
	btn.add_theme_stylebox_override("normal",  StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("hover",   StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("focus",   StyleBoxEmpty.new())

#func _input(event):
	#if event is InputEventScreenTouch and event.pressed:
		#get_tree().change_scene_to_file("res://scene/start_scene.tscn")


func _on_restart_label_pressed() -> void:
	get_tree().change_scene_to_file("res://scene/start_scene.tscn")
