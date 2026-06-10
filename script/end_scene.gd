extends Node2D

@onready var score_label = $ScoreLabel
@onready var restart_label = $RestartLabel

func _ready() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	var center = Vector2(screen_size.x / 2, screen_size.y / 2)
	score_label.position = Vector2(center.x - score_label.size.x / 2, center.y - score_label.size.y / 2)
	restart_label.position = Vector2(center.x - restart_label.size.x / 2, score_label.position.y + score_label.size.y - 30)
	# Read data from scene tree meta
	var total_shots = get_tree().get_meta("total_shots")
	score_label.text = "Total Shots: " + str(total_shots)

func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		get_tree().change_scene_to_file("res://scene/start_scene.tscn")
