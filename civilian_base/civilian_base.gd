extends CharacterBody2D

class_name CivBase

@onready var path_points = get_node("/root/TestMap/MovePaths/Path1")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var civ_spawn_timer = $CivSpawnTimer
@onready var civ_holder = $CivHolder
@onready var nav_agent = $NavAgent



enum FACING_X { LEFT = -1, RIGHT = 1 }

var _speed: float = 0.0
var can_spawn: bool = true
var _waypoints: Array = []
var _current_wp: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	create_wp()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_wp() -> void:
	for c in path_points.get_children():
		_waypoints.append(c.global_position)

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

func _physics_process(delta):
	await get_tree().process_frame
	
	update_navigation()
	move_and_slide()

func _on_civ_spawn_timer_timeout():
	spawn_civilian()

func navigate_wp() -> void:
	nav_agent.target_position = _waypoints[1]

func update_navigation() -> void:
	navigate_wp()
	var npp = nav_agent.target_position
	var direction = (npp - global_position).normalized()
	var ini_v = direction * _speed
	nav_agent.set_velocity(ini_v)
	
		

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	

func _on_move_area_area_exited(area):
	queue_free()
