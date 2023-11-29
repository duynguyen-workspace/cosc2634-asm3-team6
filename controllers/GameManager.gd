extends Node

var level_scene: PackedScene = preload("res://views/levels/level_base.tscn")
var main_scene: PackedScene = preload("res://views/main/main.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)
	
func load_level_scene() -> void:
	get_tree().change_scene_to_packed(level_scene)

