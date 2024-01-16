extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var dash_cooldown = $DashCooldown
@onready var dash_time = $DashTime

var canDash = false
var dash = true

enum PLAYER_STATE { IDLE, RUN, HURT }

var _state: PLAYER_STATE = PLAYER_STATE.IDLE

@onready var trash_pos = $TrashPos
@onready var trash_detector = $TrashDetector
var heldTrash = null
const PICKUP_DISTANCE = 50

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

	# Check for trash objects in the collaping area
	for body in bodies:
		if body.is_in_group("trash"):
			# Check if the trash is within the pickup distance
			var distance_to_trash = position.distance_to(body.position)
			if distance_to_trash < PICKUP_DISTANCE:
				# Pick up the trash
				pickup_trash(body)
				return  # Only pick up one trash object at a time

func pickup_trash(trash):
	# Pick up the trash object
	heldTrash = trash
	trash.queue_free()  # Remove the trash from the scene
	# Additional logic (e.g., update inventory) can be added here
	update_trash_state()
	
func drop_object():
	# Place the object at the player's position
	heldTrash.position = position
	add_child(heldTrash) 
	heldTrash = null

func update_trash_state():
	if heldTrash == null:
		return
