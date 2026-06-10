extends Node2D

var total_shots = 0
var level:int = 1
var score:int = 0
var game_ended = false

# const END_SCENE = preload("res://scene/main-seen/end_scene.tscn")
# var end 

# var screen_size
# var base_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# screen_size = get_viewport().get_visible_rect().size
	# # Instantiate and add to scene tree
	# end = END_SCENE.instantiate()
	# add_child(end)
	
	# var label = end.get_node("ScoreLabel")
	# var label3 = end.get_node("RestartLabel")
	# var center = Vector2(screen_size.x / 2, screen_size.y / 2)
	# label.position = Vector2(center.x - label.size.x / 2, center.y - label.size.y / 2)
	# label3.position = Vector2(center.x - label3.size.x / 2, label.position.y + label.size.y - 30)
	# end.visible = false
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(_event):
	pass
	# if score == 14:
	# 	if event is InputEventScreenTouch and event.pressed:
	# 		get_tree().change_scene_to_file("res://scene/main.tscn")
