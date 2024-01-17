extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var dash_cooldown = $DashCooldown
@onready var dash_time = $DashTime

var canDash = false
var dash = true

enum PLAYER_STATE { IDLE, UP, DOWN, RIGHT, LEFT, HURT }

var _state: PLAYER_STATE = PLAYER_STATE.IDLE

@onready var label = $Label
@onready var trash_pos = $TrashPos
@onready var trash_node = $TrashPos/TrashNode
@onready var trash_detector = $TrashDetector

var canPick = false
var canSort = false
var heldTrash = null
var lastTrashObject = null
var lastTrashbinObject = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	# Update trash position
	update_trash_state()

func _process(delta):
		#input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * 200 
	
	# Called dash function
	if Input.is_action_just_pressed("Dash") and dash:
		canDash = true
		dash_time.start()

	if canDash:
		startDash(direction)
	
	# Pickup, drop and sort functions
	if Input.is_action_just_pressed("pickup") and canPick:
		pickup_trash(lastTrashObject)
		
	if Input.is_action_just_pressed("drop"):
		drop_trash()
		
	if Input.is_action_just_pressed("sort") and canSort:
		sort_trash(lastTrashbinObject, lastTrashObject)
	
	move_and_slide()
	
	# Check user state
	calculate_states()

func calculate_states() -> void:
	if velocity.x < 0:
		set_state(PLAYER_STATE.LEFT)
	elif velocity.x > 0:
		set_state(PLAYER_STATE.RIGHT)
	elif velocity.y > 0:
		set_state(PLAYER_STATE.DOWN)
	elif velocity.y < 0:
		set_state(PLAYER_STATE.UP)
	else:
		set_state(PLAYER_STATE.IDLE)

func set_state(new_state: PLAYER_STATE) -> void:
	
	if new_state == _state:
		return			
	_state = new_state
	
	match _state:
		PLAYER_STATE.IDLE:
			animated_sprite_2d.play("idle")
		PLAYER_STATE.UP:
			animated_sprite_2d.play("up")
		PLAYER_STATE.DOWN:
			animated_sprite_2d.play("down")
		PLAYER_STATE.RIGHT:
			animated_sprite_2d.play("right")
		PLAYER_STATE.LEFT:
			animated_sprite_2d.play("left")
			
			
func startDash(direction):
	velocity = direction * 600
	dash = false

func _on_dash_cooldown_timeout():
	dash = true

func _on_dash_time_timeout():
	canDash = false
	dash_cooldown.start()

func _on_trash_detector_body_entered(body):
	if body.is_in_group("trash") && heldTrash == null:
		print("true")
		
		# Display the pickup label
		label.visible = true
		
		# Allow trash object to be picked
		canPick = true
		
		# Get the current trash object
		lastTrashObject = body
		
		label.text = "PRESS J TO PICK"
	
	if body.is_in_group("bins"):
		print("Collide trashbins")
		
		# Display the pickup label
		label.visible = true
		
		# Allow trash object to be sorted
		if heldTrash != null && canPick == false:
			canSort = true
		
		# Get the current trash object
		lastTrashbinObject = body
		
		label.text = "PRESS I TO SORT"
		
func sort_trash(trashbin, trash):
	var isSorted = false
	var trash_checked_list = null
	
	if trashbin.trash_id == 0:
		trash_checked_list = TrashManager.GENERAL_LIST
	elif trashbin.trash_id == 1:
		trash_checked_list = TrashManager.RECYCLING_LIST
	elif trashbin.trash_id == 2:
		trash_checked_list = TrashManager.FOOD_LIST
	
	if trash_checked_list == null:
		print("Cannot assigned trash list to check")
		return
	
	# Check the trash object type
	for trash_item in TrashManager.TRASH_LIST:
		if heldTrash == trash_item:
			isSorted = true
	
	if isSorted:
		print("Sort successL: Plus 1 point")
	else:
		print("Sort failed: Minus 1 point")
	#
	trash_node.remove_child(trash)
	heldTrash = null
	
	# Additional logic (e.g., update inventory) can be added here

func pickup_trash(trash):
	# Pick up the trash object
	heldTrash = trash
	canPick = false
	
	# heldTrash.position = trash_pos.position
	
	# Additional logic (e.g., update inventory) can be added here
	
func drop_trash():
	if heldTrash == null:
		return
	
	# Place the object at the player's position
	heldTrash.position = position
	
	add_child(heldTrash) 
	heldTrash = null

func update_trash_state():
	if heldTrash == null:
		return
	
	if canSort:
		label.text = "PRESS I TO SORT"
	else:
		label.text = "PRESS U TO DROP"
		
	heldTrash.position = trash_pos.position

func _on_trash_detector_body_exited(body):
	if heldTrash == null:
		label.visible = false
		canPick = false
		lastTrashObject = null
	
	if body.is_in_group("bins"):
		lastTrashbinObject = null
