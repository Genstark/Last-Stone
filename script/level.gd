extends Node2D

var shootMove: bool = false
var bulletReverse: bool = false
var is_spawning: bool = false

@onready var bird = preload("res://scene/main-seen/bird.tscn")
@onready var box = preload("res://scene/main-seen/box.tscn")

var allBirds: Array = []
var allBoxes: Array = []

var main = null
var bullet_start_pos: Vector2
var shooter_start_pos: Vector2

@onready var bullet = $bullets
@onready var shooter = $shooter
@onready var shoot_button = $"shoot-Button"
@onready var left_button = $"left-Button"
@onready var right_button = $"right-Button"

const BULLET_SPEED: float = 400.0
const SHOOTER_MOVE_SPEED: float = 200.0

func _ready() -> void:
	main = get_parent()
	bullet_start_pos = bullet.position
	shooter_start_pos = shooter.position
	_clear_button_style(shoot_button)
	_clear_button_style(left_button)
	_clear_button_style(right_button)
	check_level_and_birds()

func _clear_button_style(btn: Button) -> void:
	btn.focus_mode = Control.FOCUS_NONE
	btn.mouse_filter = Control.MOUSE_FILTER_PASS
	btn.add_theme_stylebox_override("normal",  StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("hover",   StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("focus",   StyleBoxEmpty.new())

func _process(_delta: float) -> void:
	if bullet and not shootMove and not bulletReverse:
		bullet.position.x = shooter.position.x
	
	if bulletReverse:
		var x_close: bool = abs(bullet.position.x - shooter.position.x) <= 50.0
		var y_close: bool = bullet.position.y >= shooter.position.y - 40.0
		if x_close and y_close:
			_reset_bullet()

func _physics_process(delta: float) -> void:
	if shootMove:
		bullet.position.y -= BULLET_SPEED * delta
	elif bulletReverse:
		bullet.position.y += BULLET_SPEED * delta
	var sw = get_viewport().get_visible_rect().size.x
	shooter.position.x = clamp(shooter.position.x, 50, sw - 50)

func _reset_bullet() -> void:
	bulletReverse = false
	shootMove = false
	bullet.position = Vector2(shooter.position.x, shooter.position.y - 28)
	shoot_button.disabled = false
	shoot_button.visible = true

func shoot() -> void:
	if not shootMove and not bulletReverse:
		shootMove = true
		$launch.play()

func _on_shoot_button_pressed() -> void:
	main.total_shots += 1
	shoot()
	shoot_button.visible = false

# ─── Spawning ────────────────────────────────────────────────────────────────

func removeAllBirds() -> void:
	for b in allBirds:
		if is_instance_valid(b):
			b.queue_free()
	allBirds.clear()

func removeAllBoxes() -> void:
	for b in allBoxes:
		if is_instance_valid(b):
			b.queue_free()
	allBoxes.clear()

func check_level_and_birds() -> void:
	if is_spawning:
		return
	is_spawning = true
	call_deferred("_deferred_reload_level")

func _deferred_reload_level() -> void:
	removeAllBirds()
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
		b.speed = 2.0
		
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
		b1.speed = 2.0
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
		b1.speed = 2.0
		var spr = b1.get_node_or_null("Sprite2D")
		if spr:
			spr.texture = load("res://resources/gfx/black-bird-right.png")
		add_child(b1)
		allBirds.append(b1)
		
		var b2 = bird.instantiate()
		b2.position = Vector2(521, 280)
		b2.move = true
		b2.speed = 2.0
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
		b2.speed = 2.0
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
	
	elif main.level == 10:
		var box_level_10_1 = box.instantiate()
		box_level_10_1.position = Vector2(225, 190)
		box_level_10_1.name = "box-1"
		add_child(box_level_10_1)
		allBoxes.append(box_level_10_1)
		box_level_10_1.bullet_hit.connect(_on_box_bullet_hit)
		
		var box_level_10_2 = box.instantiate()
		box_level_10_2.position = Vector2(876, 190)
		box_level_10_2.name = "box-2"
		add_child(box_level_10_2)
		allBoxes.append(box_level_10_2)
		box_level_10_2.bullet_hit.connect(_on_box_bullet_hit)
	
	is_spawning = false

func _spawn_bird(pos: Vector2, moving: bool = false, spd: float = 1.0, direction: int = 1) -> void:
	var b = bird.instantiate()
	b.position = pos
	if moving:
		b.move = true
		b.speed = spd
		b.flip(direction)
		var spr = b.get_node_or_null("Sprite2D")
		if spr:
			spr.texture = load("res://resources/gfx/black-bird-right.png")
	add_child(b)
	allBirds.append(b)

func _spawn_box(pos: Vector2) -> void:
	var b = box.instantiate()
	b.position = pos
	b.name = "box"
	add_child(b)
	allBoxes.append(b)
	b.bullet_hit.connect(_on_box_bullet_hit)

# ─── Collision handlers ───────────────────────────────────────────────────────

func _on_box_bullet_hit() -> void:
	shootMove = false
	bulletReverse = true

func _on_bulletfinder_body_entered(body: Node2D) -> void:
	if body.name != "bullets":
		return
	
	if bulletReverse:
		_reset_bullet()
		return
	
	if allBirds.size() == 0 and main.level < 10:
		shootMove = false
		$win.play()
		main.level += 1
		call_deferred("check_level_and_birds")
	
	elif allBirds.size() == 0 and main.level == 10:
		shootMove = false
		$win.play()
		call_deferred("_go_to_end_scene")
		return
	
	else:
		$"lose-sound".play()
		await $"lose-sound".finished
		shootMove = false
		call_deferred("check_level_and_birds")
	_reset_bullet()

func _on_bulletfinderdown_body_entered(_body: Node2D) -> void:
	$"lose-sound".play()
	await $"lose-sound".finished
	shootMove = false
	call_deferred("check_level_and_birds")
	_reset_bullet()

func _on_birdfinder_body_entered(body: Node2D) -> void:
	if body.name == "shooter":
		_reset_bullet()
		return
	
	if body.name == "box":
		return
	var index := allBirds.find(body)
	if index != -1:
		allBirds.remove_at(index)
		body.call_deferred("queue_free")
	
	if allBirds.size() == 0:
		var points: int = 1 if main.level <= 2 else 2
		main.score += points


func _on_pillerdetect_body_entered(_body: Node2D) -> void:
	if _body.has_method("flip"):
		_body.flip(1)

func _on_pillerdetect_2_body_entered(body: Node2D) -> void:
	if body.has_method("flip"):
		body.flip(-1)

func _go_to_end_scene() -> void:
	main.go_to_end_scene()
