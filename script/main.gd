extends Node2D

var total_shots:int = 0
var level:int = 21
var score:int = 0
var max_levels:int = 21
var game_ended:bool = false

# const END_SCENE = preload("res://scene/main-seen/end_scene.tscn")
# var end 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var background_music: AudioStreamPlayer2D = $"levels/backgroung-music"
	background_music.finished.connect(background_music.play)
	background_music.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func go_to_end_scene():
	get_tree().set_meta("total_shots", total_shots)
	get_tree().change_scene_to_file("res://scene/main-seen/end_scene.tscn")

func _input(_event):
	pass
