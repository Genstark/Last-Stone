extends CharacterBody2D

@export var birdnumber = "this is working now its your turn"
@export var move = false
@export var speed = 4
var direction := 1

func flip(dir: int):
	direction = dir
	$Sprite2D.flip_h = direction < 0

func _physics_process(_delta: float) -> void:
	if move:
		position.x += speed * direction


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "bullets":
		$AudioStreamPlayer2D.play()
		await $AudioStreamPlayer2D.finished
		# visible = false
		queue_free()
