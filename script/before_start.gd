extends Node2D

var screen_size
var base_pos: Vector2           # original label position
var float_timer: float = 0.0    # for floating animation

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size

	# Center Label
	base_pos = Vector2(
		screen_size.x / 2 - $Label.size.x / 2,
		screen_size.y / 2 - $Label.size.y / 2
	)

	$Label.position = base_pos

	# --- NEW: label2 20px below label ---
	$Label2.position = base_pos + Vector2(0, 20)
	# -------------------------------------


func _process(delta: float) -> void:
	# Floating animation (moves up/down by 5 px)
	float_timer += delta
	var offset_y = sin(float_timer * 2.0) * 5

	# animate Label
	$Label.position = base_pos + Vector2(0, offset_y)

	# animate Label2 equally
	$Label2.position = base_pos + Vector2(0, 100 + offset_y)


func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_label_pressed()
		get_tree().change_scene_to_file("res://scene/main.tscn")

	if event is InputEventScreenTouch and event.pressed:
		_on_label_pressed()
		get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_label_pressed():
	$launch.play()
