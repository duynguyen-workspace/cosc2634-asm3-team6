extends Area2D

const SPEED: float = 250.0

var boom_scene = preload("res://models/objects/boom/boom.tscn")

var _travel_direction: Vector2 = Vector2.ZERO
var _target_position: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	look_at(_target_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += SPEED * delta * _travel_direction
	
func init(target: Vector2, start_pos: Vector2) -> void:
	_travel_direction = start_pos.direction_to(target)
	_target_position = target
	global_position = start_pos
	

func create_explosion():
	var explosion = boom_scene.instantiate()
	explosion.global_position = global_position
	get_tree().root.add_child(explosion)
	queue_free()

func _on_body_entered(body):
	create_explosion()

func _on_life_timer_timeout():
	create_explosion()
