extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

enum PLAYER_STATE { IDLE, RUN, JUMP, FALL, HURT }


var _state: PLAYER_STATE = PLAYER_STATE.IDLE

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		#input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	
	if Input.is_action_pressed("Left"):
		animated_sprite_2d.flip_h = true
	else: if Input.is_action_pressed("Right"): 
		animated_sprite_2d.flip_h = false
		
	velocity = direction * 250 
	dash(direction)
	
	move_and_slide()
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
			
			
func dash(direction) -> void:
	if Input.is_action_pressed("Dash"):
		velocity = direction * 400
