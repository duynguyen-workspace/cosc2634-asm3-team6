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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
