extends CharacterBody2D

class_name CivBase

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var civ_spawn_timer = $CivSpawnTimer
@onready var civ_holder = $CivHolder
@onready var test_start = %TestStart
@onready var civ_spawn_location = $CivSpawnLocation


enum FACING_X { LEFT = -1, RIGHT = 1 }

var _speed: float = 100.0
var theme: Theme = load("res://new_theme.tres")
var custom_velocity: Vector2 = Vector2.ZERO
var can_spawn: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_civilian() -> void:
	if can_spawn == true:
		can_spawn = false
	var startpoint = test_start.global_position
	print("Instantiating civ")
	
	var civ_scene = load("res://chicken/chicken_civ.tscn")
	
	if civ_scene != null:
		var civ = civ_scene.instantiate()
		
		if civ != null:
			print("Adding child nodes")
			civ_holder.add_child(civ)
		
			var progress_bar = ProgressBar.new()
			progress_bar.theme = theme  # Copy the theme from an existing ProgressBar
			civ.add_child(progress_bar)
			progress_bar.visible = false

			progress_bar.position = Vector2(0, 0)
			progress_bar.value = randf()

			var direction = PI/2
			direction += randf_range(-PI/4, PI/4)

			civ.rotation = direction

			custom_velocity = Vector2(randf_range(150.0, 250.0), 0.0)
			civ.position += custom_velocity.rotated(direction)
			
		else:
			print("Failed to instantiate civ node.")
	else:
		print("Failed to load chicken_scene.")
	print("Civilian Scene:", civ_scene)
	print("Civ Spawn Location:", civ_spawn_location)

func _physics_process(_delta: float) -> void:
	# Called each physics frame
	# Update linear velocity here
	move_and_slide()

func _on_end_reached(area):
	queue_free()

func _on_civ_spawn_timer_timeout():
	if civ_holder.get_child_count() >= 10:
		return
	else:
		spawn_civilian()

func _on_civ_despawn_timer_timeout():
	can_spawn = true  # Allow spawning again
	if civ_holder.get_child_count() > 0:
		var civ = civ_holder.get_child(0)
		civ.queue_free()  # Remove the civilian from the scene
