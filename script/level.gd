extends Node2D

var shootMove = false
var bulletReverse = false
var is_spawning = false

@onready var bird = preload("res://scene/main-seen/bird.tscn")
@onready var box = preload("res://scene/main-seen/box.tscn")

var allBirds = []
var allBoxes = []

var main = null
var bullet_start_pos: Vector2
var shooter_start_pos: Vector2
@onready var bullet = $bullets
@onready var shooter = $shooter
@onready var shoot_button = $"shoot-Button"
@onready var left_button = $"left-Button"
@onready var right_button = $"right-Button"

func _ready() -> void:
	main = get_parent()
	bullet_start_pos = $bullets.position
	shooter_start_pos = $shooter.position

	shoot_button.focus_mode = Control.FOCUS_NONE
	shoot_button.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	shoot_button.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	shoot_button.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	shoot_button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())

	left_button.focus_mode = Control.FOCUS_NONE
	left_button.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	left_button.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	left_button.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	left_button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())

	right_button.focus_mode = Control.FOCUS_NONE
	right_button.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	right_button.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	right_button.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	right_button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())

	check_level_and_birds()

func _process(_delta: float) -> void:
	if bullet and not shootMove and not bulletReverse:
		bullet.position.x = shooter.position.x

	if bulletReverse:
		if bullet.position.y >= bullet_start_pos.y:
			bulletReverse = false
			bullet.position = bullet_start_pos
			shooter.position = shooter_start_pos
			shoot_button.disabled = false
			shoot_button.visible = true

func _physics_process(_delta: float) -> void:
	if shootMove:
		bullet.position.y -= 7
	elif bulletReverse:
		bullet.position.y += 7

func removeAllBird():
	for birds in allBirds:
		if is_instance_valid(birds):
			birds.queue_free()
	allBirds.clear()

func removeAllBoxes():
	for b in allBoxes:
		if is_instance_valid(b):
			b.queue_free()
	allBoxes.clear()

func check_level_and_birds():
	if is_spawning:
		return
	is_spawning = true
	removeAllBird()
	removeAllBoxes()

	await get_tree().process_frame

	if main.level == 1:
		$"base-scene/wire-2".visible = false
		var b = bird.instantiate()
		b.position = Vector2(521, 160)
		add_child(b)
		allBirds.append(b)

	elif main.level == 2:
		var b = bird.instantiate()
		b.position = Vector2(521, 160)
		b.flip(1)
		b.move = true
		var spr = b.get_node_or_null("Sprite2D")
		if spr:
			spr.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b)
		allBirds.append(b)

	elif main.level == 3:
		$"base-scene/wire-2".visible = true
		var b1 = bird.instantiate()
		b1.position = Vector2(521, 160)
		add_child(b1)
		allBirds.append(b1)
		var b2 = bird.instantiate()
		b2.position = Vector2(521, 280)
		add_child(b2)
		allBirds.append(b2)

	elif main.level == 4:
		var b1 = bird.instantiate()
		b1.position = Vector2(521, 160)
		b1.flip(1)
		b1.move = true
		var spr = b1.get_node_or_null("Sprite2D")
		if spr:
			spr.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b1)
		allBirds.append(b1)
		var b2 = bird.instantiate()
		b2.position = Vector2(521, 280)
		add_child(b2)
		allBirds.append(b2)

	elif main.level == 5:
		var b1 = bird.instantiate()
		b1.position = Vector2(521, 160)
		b1.flip(1)
		b1.move = true
		b1.speed = 2
		var spr = b1.get_node_or_null("Sprite2D")
		if spr:
			spr.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b1)
		allBirds.append(b1)
		var b2 = bird.instantiate()
		b2.position = Vector2(521, 280)
		b2.move = true
		b2.speed = 2
		b2.flip(-1)
		var spr2 = b2.get_node_or_null("Sprite2D")
		if spr2:
			spr2.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b2)
		allBirds.append(b2)

	elif main.level == 6:
		var b1 = bird.instantiate()
		b1.position = Vector2(521, 160)
		b1.flip(1)
		b1.move = true
		b1.speed = 2.5
		var spr = b1.get_node_or_null("Sprite2D")
		if spr:
			spr.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b1)
		allBirds.append(b1)
		var b2 = bird.instantiate()
		b2.position = Vector2(521, 280)
		b2.move = true
		b2.speed = 2.5
		b2.flip(-1)
		var spr2 = b2.get_node_or_null("Sprite2D")
		if spr2:
			spr2.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b2)
		allBirds.append(b2)

	elif main.level == 7:
		var b1 = bird.instantiate()
		b1.position = Vector2(650, 160)
		add_child(b1)
		allBirds.append(b1)
		var b2 = bird.instantiate()
		b2.position = Vector2(521, 280)
		b2.move = true
		b2.flip(-1)
		var spr2 = b2.get_node_or_null("Sprite2D")
		if spr2:
			spr2.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b2)
		allBirds.append(b2)

	elif main.level == 8:
		var b1 = bird.instantiate()
		b1.position = Vector2(650, 160)
		add_child(b1)
		allBirds.append(b1)
		var b2 = bird.instantiate()
		b2.position = Vector2(521, 280)
		b2.move = true
		b2.speed = 4.5
		b2.flip(-1)
		var spr2 = b2.get_node_or_null("Sprite2D")
		if spr2:
			spr2.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b2)
		allBirds.append(b2)

	elif main.level == 9:
		var box_level_9 = box.instantiate()
		box_level_9.position = Vector2(876, 190)
		box_level_9.name = "box"
		add_child(box_level_9)
		allBoxes.append(box_level_9)
		box_level_9.bullet_hit.connect(_on_box_bullet_hit)

		var b1 = bird.instantiate()
		b1.position = Vector2(521, 160)
		add_child(b1)
		allBirds.append(b1)

		var b2 = bird.instantiate()
		b2.position = Vector2(876, 280)
		add_child(b2)
		allBirds.append(b2)

	is_spawning = false

func _on_box_bullet_hit():
	shootMove = false
	bulletReverse = true
	var box_node = get_node_or_null("box")
	if box_node:
		box_node.position.y += 80

func _on_bulletfinder_body_entered(body: Node2D) -> void:
	if body.name == 'bullets':

		# if bullet is returning from box hit — just stop, no lose
		if bulletReverse:
			bulletReverse = false
			bullet.position = bullet_start_pos
			shooter.position = shooter_start_pos
			shoot_button.disabled = false
			shoot_button.visible = true
			return  # ← exit early, don't process win/lose

		if main.score == 1 and main.level == 1:
			shootMove = false
			main.level += 1
			check_level_and_birds()
			$win.play()

		elif main.score == 2 and main.level == 2:
			shootMove = false
			main.level += 1
			check_level_and_birds()
			$win.play()

		elif main.score == 4 and main.level == 3:
			shootMove = false
			main.level += 1
			check_level_and_birds()
			$win.play()

		elif main.score == 6 and main.level == 4:
			shootMove = false
			main.level += 1
			check_level_and_birds()
			$win.play()

		elif main.score == 8 and main.level == 5:
			shootMove = false
			main.level += 1
			check_level_and_birds()
			$win.play()

		elif main.score == 10 and main.level == 6:
			shootMove = false
			main.level += 1
			check_level_and_birds()
			$win.play()

		elif main.score == 12 and main.level == 7:
			shootMove = false
			main.level += 1
			check_level_and_birds()
			$win.play()

		elif main.score == 14 and main.level == 8:
			shootMove = false
			main.level += 1
			check_level_and_birds()
			$win.play()

		elif main.score == 16 and main.level == 9:
			shootMove = false
			$win.play()
			get_tree().set_meta("total_shots", main.total_shots)
			get_tree().set_meta("score", main.score)
			get_tree().change_scene_to_file("res://scene/main-seen/end_scene.tscn")

		else:
			$"lose-sound".play()
			await $"lose-sound".finished
			shootMove = false
			bullet.position = bullet_start_pos
			check_level_and_birds()

		shoot_button.disabled = false
		shoot_button.visible = true
		shooter.position = shooter_start_pos
		bullet.position = bullet_start_pos

func _on_pillerdetect_body_entered(_body: Node2D) -> void:
	if _body.has_method("flip"):
		_body.flip(1)

func _on_pillerdetect_2_body_entered(body: Node2D) -> void:
	if body.has_method("flip"):
		body.flip(-1)

func shoot():
	if not shootMove:
		shootMove = true
		$launch.play()

func _on_shoot_button_pressed() -> void:
	main.total_shots += 1
	shoot()
	shoot_button.visible = false

func _on_birdfinder_body_entered(body: Node2D) -> void:
	if body.name == "box":
		return

	var index := allBirds.find(body)
	if index != -1:
		allBirds.remove_at(index)

	if allBirds.size() == 0:
		if main.level == 1:
			main.score += 1
		elif main.level == 2:
			main.score += 1
		elif main.level == 3:
			main.score += 2
		elif main.level == 4:
			main.score += 2
		elif main.level == 5:
			main.score += 2
		elif main.level == 6:
			main.score += 2
		elif main.level == 7:
			main.score += 2
		elif main.level == 8:
			main.score += 2
		elif main.level == 9:
			main.score += 2
