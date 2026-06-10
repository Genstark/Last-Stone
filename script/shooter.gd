extends CharacterBody2D

const SPEED := 300.0

var right := false
var left := false

func _physics_process(_delta: float) -> void:
	# Keyboard support
	var direction = Input.get_axis("ui_left", "ui_right")
	# Mobile buttons override keyboard
	if right:
		direction = 1
	elif left:
		direction = -1

	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

# ✅ Shoot ONLY when touch is NOT on UI buttons
func _unhandled_input(event):
	if event is InputEventScreenTouch and event.pressed:
		$"../launch".play()

# ✅ Left button
func _on_left_button_button_down() -> void:
	left = true

func _on_left_button_button_up() -> void:
	left = false

# ✅ Right button
func _on_right_button_button_down() -> void:
	right = true

func _on_right_button_button_up() -> void:
	right = false
