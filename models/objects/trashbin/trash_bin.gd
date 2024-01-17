extends RigidBody2D

@export var trash_id = 0

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.frame = trash_id
