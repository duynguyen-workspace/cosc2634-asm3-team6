extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d = $AnimatedSprite2D2
@onready var dash_cooldown = $DashCooldown
@onready var dash_time = $DashTime

var canDash = false
var dash = true

enum PLAYER_STATE { IDLE, RUN, HURT, UP, DOWN, LEFT, RIGHT }

var _state: PLAYER_STATE = PLAYER_STATE.IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
		#input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	

		
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
	print(velocity.y)
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
			animated_sprite_2d.play("Idle")
		PLAYER_STATE.UP:
			animated_sprite_2d.play("Up")
		PLAYER_STATE.DOWN:
			animated_sprite_2d.play("Down")
		PLAYER_STATE.RIGHT:
			animated_sprite_2d.play("Right")
		PLAYER_STATE.LEFT:
			animated_sprite_2d.play("Left")
			
			
func startDash(direction):
	velocity = direction * 600
	dash = false
	

func _on_dash_cooldown_timeout():
	dash = true

func _on_dash_time_timeout():
	canDash = false
	dash_cooldown.start()
