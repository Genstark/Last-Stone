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
	$"base-scene/wire-2".visible = false
	$"base-scene/wire-3".visible = false

func _clear_button_style(btn: Button) -> void:
	btn.focus_mode = Control.FOCUS_NONE
	btn.mouse_filter = Control.MOUSE_FILTER_PASS
	btn.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
	btn.add_theme_stylebox_override("focus", StyleBoxEmpty.new())

func _process(_delta: float) -> void:
	if bullet and not shootMove and not bulletReverse:
		bullet.position.x = shooter.position.x
	
	if bulletReverse:
		var x_close: bool = abs(bullet.position.x - shooter.position.x) <= 50.0
		var y_close: bool = bullet.position.y >= shooter.position.y - 40.0
		if x_close and y_close:
			_reset_bullet()
	
	if main.level == 20 and allBirds.size() == 3:
		var b1 = get_node_or_null("bird-3-center-middle")
		var b2 = get_node_or_null("bird-6-center-bottom")
		if b1 and not b1.move:
			_start_bird(b1, 5, 1)
		if b2 and not b2.move:
			_start_bird(b2, 5, -1)

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
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-top-center")
	
	elif main.level == 2:
		_spawn_bird(Vector2(521, 138), true, 2, 1, "bird-top-moving")
	
	elif main.level == 3:
		$"base-scene/wire-2".visible = true
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-top-center")
		_spawn_bird(Vector2(521, 258), false, 0, 0, "bird-bottom-center")
	
	elif main.level == 4:
		_spawn_bird(Vector2(521, 138), true, 2, 1, "bird-top-center-moving")
		_spawn_bird(Vector2(521, 258), false, 0, 0, "bird-bottom-center")

	elif main.level == 5:
		_spawn_bird(Vector2(521, 138), true, 2, 1, "bird-top-center-moving")
		_spawn_bird(Vector2(521, 258), true, 2, -1, "bird-bottom-center-moving")
	
	elif main.level == 6:
		_spawn_bird(Vector2(521, 138), true, 2.5, 1, "bird-top-center-moving")
		_spawn_bird(Vector2(521, 258), true, 2.5, -1, "bird-bottom-center-moving")
	
	elif main.level == 7:
		_spawn_bird(Vector2(650, 138), false, 0, 0, "bird-top-center")
		_spawn_bird(Vector2(521, 258), true, 2, -1, "bird-bottom-center-moving")
	
	elif main.level == 8:
		_spawn_bird(Vector2(650, 138), false, 0, 0, "bird-top-center")
		_spawn_bird(Vector2(521, 258), true, 4.5, -1, "bird-bottom-center-moving")
	
	elif main.level == 9:
		_spawn_box(Vector2(876, 168), "top-box-1")
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-top-center")
		_spawn_bird(Vector2(876, 258), false, 0, 0, "bird-bottom-center-moving")
	
	elif main.level == 10:
		_spawn_box(Vector2(225, 168), "top-box-1")
		_spawn_bird(Vector2(250, 258), false, 0, 0, "bird-1-left-middle")
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-2-center-top")
	
	elif main.level == 11:
		_spawn_box(Vector2(225, 168), "top-box-1")
		_spawn_box(Vector2(876, 168), "top-box-2")
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-1-center-top")
		_spawn_bird(Vector2(250, 258), false, 0, 0, "bird-2-left-middle")
		_spawn_bird(Vector2(876, 258), false, 0, 0, "bird-3-right-middle")
	
	elif main.level == 12:
		_spawn_box(Vector2(225, 168), "top-box-1")
		_spawn_box(Vector2(876, 168), "top-box-2")
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-1-center-top")
		_spawn_bird(Vector2(250, 258), false, 0, 0, "bird-2-left-middle")
		_spawn_bird(Vector2(521, 258), false, 0, 0, "bird-3-left-middle")
		_spawn_bird(Vector2(876, 258), false, 0, 0, "bird-4-right-middle")
	
	elif main.level == 13:
		$"base-scene/wire-3".visible = true
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-1-top-center")
		_spawn_box(Vector2(250, 290), "middle-box-1")
		_spawn_bird(Vector2(521, 258), false, 0, 0, "bird-2-middle-center")
		_spawn_box(Vector2(876, 290), "middle-box-1")
		_spawn_bird(Vector2(250, 378), false, 0, 0, "bird-3-bottom-left")
		_spawn_bird(Vector2(521, 378), false, 0, 0, "bird-4-bottom-center")
		_spawn_bird(Vector2(876, 378), false, 0, 0, "bird-3-bottom-left")
	
	elif main.level == 14:
		_spawn_bird(Vector2(521, 138), true, 5, 1, "bird-top-center-moving")
		_spawn_box(Vector2(250, 290), "middle-box-1")
		_spawn_bird(Vector2(521, 258), false, 0, 0, "bird-middle-center")
		_spawn_box(Vector2(876, 290), "middle-box-2")
		_spawn_bird(Vector2(250, 378), false, 0, 0, "bird-bottom-left")
		_spawn_bird(Vector2(521, 378), false, 0, 0, "bird-bottom-center")
		_spawn_bird(Vector2(876, 378), false, 0, 0, "bird-bottom-right")
	
	elif main.level == 15:
		_spawn_bird(Vector2(521, 138), true, 5, 1, "bird-top-center-moving")
		_spawn_box(Vector2(250, 290), "middle-box-1")
		_spawn_bird(Vector2(521, 258), false, 0, 0, "bird-middle-center")
		_spawn_box(Vector2(876, 290), "middle-box-2")
		_spawn_bird(Vector2(521, 378), true, 5, -1, "bird-bottom-center-moving")

	elif main.level == 16:
		_spawn_bird(Vector2(480, 138), false, 0, 0, "bird-top-left")
		_spawn_box(Vector2(876, 168), "top-box-1")
		_spawn_bird(Vector2(521, 258), true, 6, -1, "bird-middle-center-moving")
		_spawn_bird(Vector2(521, 378), true, 5, 1, "bird-bottom-center-moving")
	
	elif main.level == 17:
		_spawn_bird(Vector2(480, 138), true, 6, 1, "bird-top-left-moving")
		_spawn_box(Vector2(521, 290), "middle-box-1")
		_spawn_bird(Vector2(876, 258), false, 0, 0, "bird-middle-right")
		_spawn_bird(Vector2(521, 378), true, 5, -1, "bird-bottom-center-moving")
	
	elif main.level == 18:
		_spawn_bird(Vector2(480, 138), true, 6, 1, "bird-1-right-middle")
		_spawn_box(Vector2(876, 290), "top-box-1")
		_spawn_bird(Vector2(250, 258), false, 0, 0, "bird-2-left-top")
		_spawn_bird(Vector2(521, 378), true, 5, -1, "bird-3-center-top")
	
	elif main.level == 19:
		_spawn_box(Vector2(258, 168), "top-box-1")
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-1-center-top")
		_spawn_box(Vector2(876, 168), "top-box-2")
		_spawn_bird(Vector2(250, 258), false, 0, 0, "bird-2-left-middle")
		_spawn_bird(Vector2(521, 258), false, 0, 0, "bird-3-center-middle")
		_spawn_bird(Vector2(876, 258), false, 0, 0, "bird-4-right-middle")
		_spawn_bird(Vector2(250, 378), false, 0, 0, "bird-5-left-bottom")
		_spawn_bird(Vector2(521, 378), false, 0, 0, "bird-6-center-bottom")
		_spawn_bird(Vector2(876, 378), false, 0, 0, "bird-7-right-bottom")
	
	elif main.level == 20:
		_spawn_box(Vector2(258, 168), "top-box-1")
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-1-center-top")
		_spawn_box(Vector2(876, 168), "top-box-2")
		_spawn_bird(Vector2(250, 258), false, 0, 0, "bird-2-left-middle")
		_spawn_bird(Vector2(521, 258), false, 0, 0, "bird-3-center-middle")
		_spawn_bird(Vector2(876, 258), false, 0, 0, "bird-4-right-middle")
		_spawn_bird(Vector2(250, 378), false, 0, 0, "bird-5-left-bottom")
		_spawn_bird(Vector2(521, 378), false, 0, 0, "bird-6-center-bottom")
		_spawn_bird(Vector2(876, 378), false, 0, 0, "bird-7-right-bottom")
	
	elif main.level == 21:
		$"base-scene/wire-2".visible = true
		$"base-scene/wire-3".visible = false
		
		_spawn_bird(Vector2(521, 138), false, 0, 0, "bird-top-center")
	is_spawning = false


# ─── Spawning helpers ────────────────────────────────────────────────────────

func _spawn_bird(pos: Vector2, moving: bool = false, speed: float = 1.0, direction: int = 1, bird_name: String = "") -> void:
	var birds = bird.instantiate()
	birds.position = pos
	birds.name = bird_name
	if moving:
		birds.move = true
		birds.speed = speed
		birds.flip(direction)
		var spr = birds.get_node_or_null("Sprite2D")
		if spr:
			spr.texture = load("res://resources/gfx/black-bird-right.png")
	add_child(birds)
	allBirds.append(birds)

func _spawn_box(pos: Vector2, box_name: String = "") -> void:
	var b = box.instantiate()
	b.position = pos
	b.name = box_name
	add_child(b)
	allBoxes.append(b)
	b.bullet_hit.connect(_on_box_bullet_hit)

func _start_bird(bird_node: Node2D, speed: float, direction: int) -> void:
	bird_node.move = true
	bird_node.speed = speed
	bird_node.flip(direction)

	var sprite = bird_node.get_node_or_null("Sprite2D")
	if sprite:
		sprite.texture = load("res://resources/gfx/black-bird-right.png")
		sprite.flip_h = direction < 0

# ─── Collision handlers ───────────────────────────────────────────────────────

func _on_box_bullet_hit() -> void:
	shootMove = false
	bulletReverse = true

# ─── Bullet Finder ───────────────────────────────────────────────────────
func _on_bulletfinder_body_entered(body: Node2D) -> void:
	if body.name != "bullets":
		return
	
	if bulletReverse:
		_reset_bullet()
		return
	
	if allBirds.size() == 0 and main.level < main.max_levels:
		shootMove = false
		$win.play()
		main.level += 1
		call_deferred("check_level_and_birds")
	
	elif allBirds.size() == 0 and main.level == main.max_levels:
		shootMove = false
		$win.play()
		call_deferred("_go_to_end_scene")
		return
	
	else:
		$"lose-sound".play()
		await $"lose-sound".finished
		shootMove = false
		call_deferred("check_level_and_birds")
	
	shooter.position = Vector2(591, 614)
	_reset_bullet()

func _on_bulletfinderdown_body_entered(_body: Node2D) -> void:
	$"lose-sound".play()
	await $"lose-sound".finished
	shootMove = false
	call_deferred("check_level_and_birds")
	shooter.position = Vector2(590, 614)
	_reset_bullet()

# ─────────────────────────────────────────────────────────────────────────

func _find_hit_audio(node: Node) -> AudioStreamPlayer2D:
	if node is AudioStreamPlayer2D:
		return node
	var audio = node.get_node_or_null("AudioStreamPlayer2D")
	if audio:
		return audio
	if node.get_parent():
		return _find_hit_audio(node.get_parent())
	return null

func _on_birdfinder_body_entered(body: Node2D) -> void:
	if body.name == "shooter":
		_reset_bullet()
		return
	
	if body.has_meta("bird_hit"):
		return
	body.set_meta("bird_hit", true)

	var index := allBirds.find(body)
	if index != -1:
		var hit_audio = _find_hit_audio(body)
		if hit_audio:
			hit_audio.play()
			await hit_audio.finished
		allBirds.remove_at(index)
		body.queue_free()
	
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
