extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var dash_cooldown = $DashCooldown
@onready var dash_time = $DashTime
@onready var trash_detector = $TrashDetector

var canDash = false
var dash = true

# Pickup property
var heldTrash = null
const INTERACT_DISTANCE = 50


enum PLAYER_STATE { IDLE, RUN, HURT }

var _state: PLAYER_STATE = PLAYER_STATE.IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
		#input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if Input.is_action_pressed("Left"):
		animated_sprite_2d.flip_h = true
	else: if Input.is_action_pressed("Right"): 
		animated_sprite_2d.flip_h = false
		
	velocity = direction * 250 
	# Called dash function

	if Input.is_action_just_pressed("Dash") and dash:
		canDash = true
		dash_time.start()

	if canDash:
		startDash(direction)
		
	if Input.is_action_just_pressed("pickup"):
		if heldTrash == null:
			# If not holding an object, try to pick up nearby trash
			try_pickup_trash()
		else:
			# If holding an object, drop it
			drop_trash()
	
	move_and_slide()
	
	# Check user state
	calculate_states()

func calculate_states() -> void:
	if velocity.x == 0:
		set_state(PLAYER_STATE.IDLE)
	else:
		set_state(PLAYER_STATE.RUN)

func set_state(new_state: PLAYER_STATE) -> void:
	
	if new_state == _state:
		return			
	_state = new_state
	
	match _state:
		PLAYER_STATE.IDLE:
			animated_sprite_2d.play("idle")
		PLAYER_STATE.RUN:
			animated_sprite_2d.play("run")
			
			
func startDash(direction):
	velocity = direction * 600
	dash = false

func _on_dash_cooldown_timeout():
	dash = true

func _on_dash_time_timeout():
	canDash = false
	dash_cooldown.start()

func try_pickup_trash():
	# Get a list of bodies overlapping with the player
	var bodies = trash_detector.get_overlapping_bodies()
	
	# Check for trash objects in the vicinity
	for body in bodies:
		if body.is_in_group("trash"):
			# Check if the trash is within the interaction distance
			var distance_to_trash = position.distance_to(body.position)
			if distance_to_trash < INTERACT_DISTANCE:
				# Pick up the trash
				pickup_trash(body)
				return  # Only pick up one object at a time (modify as needed)

func pickup_trash(trash):
	# Pick up the trash
	heldTrash = trash
	trash.queue_free()  # Remove the trash from the scene
	# Additional logic (e.g., update inventory) can be added here

func drop_trash():
	# Drop the held object
	# Place the object at the player's position or wherever you want
	heldTrash.position = position
	add_child(heldTrash)  # Add the held object as a child of the player
	heldTrash = null
	



