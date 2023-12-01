extends CharacterBody2D

class_name CivBase

@onready var animated_sprite_2d = get_node("/root/civilian_base/AnimatedSprite2D")
@onready var civ_spawn_timer = get_node("/root/civilian_base/CivSpawnTimer")
@onready var civ_holder = get_node("/root/civilian_base/CivHolder")



enum FACING_X { LEFT = -1, RIGHT = 1 }


var can_spawn: bool = true
var _waypoints: Array = []
var _current_wp: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
	



func spawn_civilian() -> void:
	print("Instantiating civ")
	
	var civ_scene = load("res://chicken/chicken_civ.tscn")
	if civ_scene != null:
		var civ = civ_scene.instantiate()
		if civ != null:
			print("Adding child nodes")
			civ_holder.add_child(civ)
		else:
			print("Failed to instantiate civ node.")
	else:
		print("Failed to load chicken_scene.")
	print("Civilian Scene:", civ_scene)

	

func _on_civ_spawn_timer_timeout():
	pass

