extends Node

@onready var grid_container = $TextureRect/MC/TextureRect/MC/VB/MC2/VB/GridContainer

const button_scene: PackedScene = preload("res://views/level_button/level_button.tscn")
const LEVEL_COLS: int = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	setup_grid()
	

func setup_grid() -> void:
	for level in range(LEVEL_COLS):
		var lbs = button_scene.instantiate()
		lbs.set_level_number(str(level + 1))
		grid_container.add_child(lbs)


func _on_main_button_pressed():
	GameManager.load_main_scene()
