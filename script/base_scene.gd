extends Node2D

@onready var sky: Sprite2D = $"background/blue-background"

var background = {
	"afternoon": preload("res://resources/gfx/afternoon-sky.png"),
	"night":     preload("res://resources/gfx/night-sky.png"),
	"sunrise":   preload("res://resources/gfx/sunrise-sky.png"),
	"sunset":    preload("res://resources/gfx/sunset-sky.png")
}

var current_period: String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_sky()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_update_sky()

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
