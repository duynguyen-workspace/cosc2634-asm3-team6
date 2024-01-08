extends Node

const TOTAL_LEVELS: int = 3


var main_scene: PackedScene = preload("res://views/main/main.tscn")
var selection_scene: PackedScene = preload("res://views/level_selection_menu/level_selection_menu.tscn")
var settings_scene: PackedScene = preload("res://views/settings_scene/settings_scene.tscn")
var instructions_scene: PackedScene = preload("res://views/instructions_scene/instructions_scene.tscn")
var credits_scene: PackedScene = preload("res://views/credits_scene/credits_scene.tscn")
var level_1_scene: PackedScene = preload("res://models/level_base/levels/level_1.tscn")
var level_2_scene: PackedScene = preload("res://models/level_base/levels/level_2.tscn")



var _level_selected: String


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

func load_settings_scene() -> void:
	get_tree().change_scene_to_packed(settings_scene)

func load_instructions_scene() -> void:
	get_tree().change_scene_to_packed(instructions_scene)

func load_credits_scene() -> void:
	get_tree().change_scene_to_packed(credits_scene)



func load_level_scene(level_number: String) -> void:
	if level_number == "1":
		get_tree().change_scene_to_packed(level_1_scene)
	if level_number == "2":
		get_tree().change_scene_to_packed(level_2_scene)
	else:
		pass
