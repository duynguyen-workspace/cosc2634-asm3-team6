extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var dash_cooldown = $DashCooldown
@onready var dash_time = $DashTime

var canDash = false
var dash = true

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
