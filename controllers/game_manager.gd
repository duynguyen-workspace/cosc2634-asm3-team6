extends Node

const TOTAL_LEVELS: int = 3


var main_scene: PackedScene = preload("res://views/main/main.tscn")
var selection_scene: PackedScene = preload("res://views/level_selection_menu/level_selection_menu.tscn")
# var level_scene: PackedScene = load("res://models/level_base/levels/level_%.tscn"% level_number)


var _level_selected: String
var _current_level: int = 0
var _level_scenes = {}
var level_number: int



# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)

func load_selection_scene() -> void:
	get_tree().change_scene_to_packed(selection_scene)


func on_level_selected(ln: int):
	level_number = ln
	# load_level_scene()

# func load_level_scene() -> void:
	# get_tree().change_scene_to_packed(level_scene)
	
