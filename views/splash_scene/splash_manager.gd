extends Control

@export var _move_to: PackedScene

var _splash_scenes: Array[SplashScene] = []

@onready var splash_container: CenterContainer = $SplashContainer

func _ready() -> void:
	assert(_move_to)
	
	for splash_scene in splash_container.get_children():
		splash_scene.hide()
		_splash_scenes.push_back(splash_scene)
		
	start_splash_scene()
	

func start_splash_scene() -> void:
	if _splash_scenes.size() == 0:
		get_tree().change_scene_to_packed(_move_to)
	else:
		var splash_scene: SplashScene = _splash_scenes.pop_front()
		splash_scene.start()
		splash_scene.connect("finished", start_splash_scene)

