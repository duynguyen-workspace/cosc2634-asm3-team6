extends CharacterBody2D

var _speed: float = 800.0

@export var path_points: NodePath

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var civ_spawn_timer = $CivSpawnTimer
@onready var civ_holder = $CivHolder

@onready var nav_agent = $NavAgent

enum FACING_X { LEFT = -1, RIGHT = 1 }


var can_spawn: bool = true
var _waypoints: Array = []
var _current_wp: int = 0
var civ_scene = load("res://chicken/chicken_civ.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass

func _on_civ_spawn_timer_timeout():
	spawn_civilian()
	
func spawn_civilian() -> void:
	print("Instantiating civ")
	
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

func create_wp() -> void:
	for c in get_node(path_points).get_children():
		_waypoints.append(c.global_position)
	
	
func update_navigation() -> void:
	await get_tree().physics_frame
	var npp = nav_agent.get_next_path_position()
	var ini_v = (npp - global_position).normalized() * _speed
	nav_agent.set_velocity(ini_v)
	
	
func navigate_wp() -> void:
	if _current_wp >= len(_waypoints):
		_current_wp = 0
		
	nav_agent.target_position = _waypoints[_current_wp]
	_current_wp += 1

func process_moving() -> void:
	if nav_agent.is_navigation_finished() == true:
		navigate_wp()
	
func update_movement() -> void:
	process_moving()

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()