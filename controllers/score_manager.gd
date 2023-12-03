extends Node2D

var score: float = 0

@onready var score_label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	score_label.text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_correct_trash_collected() -> void:
	score += 1
	score_label.text = str(score)

func win_check() -> void:
	if trash_collected >= trash_goal:
		SignalController.on_level_complete.emit(true)

func lose_check() -> void:
	SignalController.on_game_over.emit(true)

