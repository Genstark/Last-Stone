extends Node2D

var screen_size
@onready var sky: Sprite2D = $background

var background = {
	"afternoon": preload("res://resources/start-background-afternoon.png"),
	"night":     preload("res://resources/start-background-night.png"),
	"sunrise":   preload("res://resources/start-background-sunrise.png"),
	"sunset":    preload("res://resources/start-background-sunset.png")
}

var current_period: String = ""

func _ready() -> void:
	$start.play()
	screen_size = get_viewport().get_visible_rect().size
	_update_sky()

func _process(_delta: float) -> void:
	_update_sky()


func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_quit_button_button_up() -> void:
	get_tree().quit()



func _get_period() -> String:
	var hour: int = Time.get_time_dict_from_system()["hour"]
	if hour >= 5 and hour < 8:
		return "sunrise"
	elif hour >= 8 and hour < 17:
		return "afternoon"
	elif hour >= 17 and hour < 20:
		return "sunset"
	else:
		return "night"

func _update_sky() -> void:
	var period: String = _get_period()
	if period == current_period:
		return
	current_period = period
	sky.texture = background[period]
