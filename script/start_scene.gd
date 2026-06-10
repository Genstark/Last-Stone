extends Node2D

var screen_size

func _ready() -> void:
	$start.play()
	screen_size = get_viewport().get_visible_rect().size
	# Center Label

func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().quit()
