extends RigidBody2D

@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var index = TrashManager.choose_random_texture()
	sprite_2d.texture = TrashManager.TRASH_LIST[index]

