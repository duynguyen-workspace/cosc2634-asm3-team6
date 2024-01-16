extends RigidBody2D

@export var trash_id = 0

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.frame = trash_id


func _on_detector_body_entered(body):
	if body.is_in_group("trash"):
		print("Player entered")
