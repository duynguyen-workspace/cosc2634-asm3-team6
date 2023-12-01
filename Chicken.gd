extends PathFollow2D

var _speed: float = 100.0

@export var path_points: NodePath

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D


@onready var nav_agent = $NavAgent

enum FACING_X { LEFT = -1, RIGHT = 1 }


var can_spawn: bool = true
var _waypoints: Array = []
var _current_wp: int = 0
var starting: bool = true
var velocity: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	create_wp()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if starting == false:
		update_movement()
		update_navigation()
	
	
func create_wp() -> void:
	for c in get_node(path_points).get_children():
		_waypoints.append(c.global_position)
	starting = false

func update_navigation() -> void:
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
