extends Control

@onready var score_label = $MC/HB/VB/ScoreLabel
@onready var timer_label = $MC/HB/VB/TimerLabel
@onready var color_rect = $ColorRect
@onready var mc_game_over = $ColorRect/MC_EndGameMenu/NinePatchRect/MC_GameOver
@onready var mc_level_completed = $ColorRect/MC_EndGameMenu/NinePatchRect/MC_LevelCompleted
@onready var try_again_button = $ColorRect/MC_EndGameMenu/VB_Buttons/HB_Buttons/TryAgainButton
@onready var level_selection_button = $ColorRect/MC_EndGameMenu/VB_Buttons/HB_Buttons/LevelSelectionButton
@onready var main_button = $ColorRect/MC_EndGameMenu/VB_Buttons/HB_Buttons/MainButton
@onready var health_bar = $MC/HB/HealthBar



# Called when the node enters the scene tree for the first time.
func _ready():
	SignalController.on_level_complete.connect(on_level_complete)
	SignalController.on_game_over.connect(on_game_over)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if Input.is_action_just_pressed("game_over") == true:
	#	on_game_over()
	if Input.is_action_just_pressed("level_completed") == true:
		on_level_complete()
		
		

func show_hud() -> void:
	get_tree().paused = true
	color_rect.visible = true


func on_level_complete() -> void:
	show_hud()
	mc_level_completed.visible = true
	get_tree().paused = false
	

func on_game_over() -> void:
	show_hud()
	mc_game_over.visible = true
	get_tree().paused = false


func _on_try_again_button_pressed():
	GameManager.load_level_scene()


func _on_level_selection_button_pressed():
	pass # Replace with function body.


func _on_main_button_pressed():
	GameManager.load_main_scene()
