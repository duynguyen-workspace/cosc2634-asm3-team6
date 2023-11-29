extends Control

@onready var score_label = $MC/HB/VB/ScoreLabel
@onready var timer_label = $MC/HB/VB/TimerLabel
@onready var color_rect = $ColorRect
@onready var mc_game_over = $ColorRect/MC_EndGameMenu/NinePatchRect/MC_GameOver



# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.on_level_complete.connect(on_level_complete)
	SignalController.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("gameover") == true:
		color_rect.visible == true
	if color_rect.visible == true:
		if Input.is_action_just_pressed("mainscene") == true:
			GameManager.load_main_scene()
	


func on_level_complete() -> void:
	pass
	

func on_game_over() -> void:
	get_tree().paused = true
	color_rect.visible = true
	mc_game_over.visible = true
