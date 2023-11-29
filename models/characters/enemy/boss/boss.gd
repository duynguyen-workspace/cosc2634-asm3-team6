extends CharacterBody2D

enum ENEMY_STATE {PATROLLING, CHASING, SEARCHING}

const FOV = {
	ENEMY_STATE.PATROLLING: 60.0,
	ENEMY_STATE.CHASING: 120.0,
	ENEMY_STATE.SEARCHING: 100.0
}

@export var patrol_points: NodePath
@onready var nav_agent = $NavAgent
@onready var sprite_2d = $AnimatedSprite2D
@onready var player_detect = $PlayerDetect
@onready var ray_cast_2d = $PlayerDetect/RayCast2D
@onready var sound = $Sound
@onready var animation_player = $AnimationPlayer

var bullet_scene: PackedScene = preload("res://models/objects/bullet/bullet.tscn")

var _speed: float = 100.0

var _waypoints: Array = []
var _current_wp: int = 0
var _state: ENEMY_STATE = ENEMY_STATE.PATROLLING
var _player_ref: Player

func _ready():
	create_wp()
	_player_ref = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	raycast_to_player()
	update_movement()
	update_navigation()
	update_state()
	debug_label()
	
func debug_label() -> void:
	var s = "FOV:%.0f , State: %s\n" % [get_fov_angle(), ENEMY_STATE.keys()[_state] ]
	s += "player_in_fov:%s\n" % player_in_fov()
	s += "player_detected:%s\n" % player_detected()
	s += "can_see_player:%s\n" % can_see_player()
	SignalManager.on_debug.emit(s)

func get_fov_angle() -> float:
	var direction = global_position.direction_to(_player_ref.global_position)
	var dot_product = direction.dot(velocity.normalized())
	if dot_product >= -1.0 and dot_product <= 1.0:
		return rad_to_deg(acos(dot_product))
	else:
		return 0.0
	
func raycast_to_player() -> void:
	player_detect.look_at(_player_ref.global_position)
	
func player_detected() -> bool:
	var c = ray_cast_2d.get_collider()
	if c != null:
		return c.is_in_group("player")
	
	return false
	
func player_in_fov() -> bool:
	return get_fov_angle() < FOV[_state]

func can_see_player() -> bool:
	return player_in_fov() and player_detected()

func set_nav_to_player() -> void:
	nav_agent.target_position = _player_ref.global_position
	
func create_wp() -> void:
	for c in get_node(patrol_points).get_children():
		_waypoints.append(c.global_position)
		
func navigate_wp() -> void:
	if _current_wp >= len(_waypoints):
		_current_wp = 0
		
	nav_agent.target_position = _waypoints[_current_wp]
	_current_wp += 1

func update_navigation() -> void:
	var npp = nav_agent.get_next_path_position()
	var ini_v = (npp - global_position).normalized() * _speed
	# sprite_2d.look_at(npp)
	if sprite_2d.global_position.x < _player_ref.global_position.x:
		sprite_2d.set_flip_h(true)
	else:
		sprite_2d.set_flip_h(false)
	
	nav_agent.set_velocity(ini_v)
	
func process_patrolling() -> void:
	if nav_agent.is_navigation_finished() == true:
		navigate_wp()
	
func process_searching() -> void:
	if nav_agent.is_navigation_finished() == true:
		set_state(ENEMY_STATE.PATROLLING)

func process_chasing() -> void:
	set_nav_to_player()
	
func update_movement() -> void:
	match _state:
		ENEMY_STATE.PATROLLING:
			process_patrolling()
		ENEMY_STATE.SEARCHING:
			process_searching()
		ENEMY_STATE.CHASING:
			process_chasing()
			
func set_state(new_state: ENEMY_STATE) -> void:
	if new_state == _state:
		return
	
	_state = new_state
	
	match _state:
		ENEMY_STATE.PATROLLING:
			animation_player.play("RESET")
			navigate_wp()
		ENEMY_STATE.SEARCHING:
			set_nav_to_player()
		ENEMY_STATE.CHASING:
			SoundManager.play_gasp(sound)
			animation_player.play("chase")

func update_state() -> void:
	var new_state = _state
	var can_see = can_see_player()
	
	if can_see == true:
		new_state = ENEMY_STATE.CHASING
	elif new_state == ENEMY_STATE.CHASING and can_see == false:
		new_state = ENEMY_STATE.SEARCHING
	
	set_state(new_state)
		

func shoot() -> void:
	if _state != ENEMY_STATE.CHASING:
		return
		
	var target = _player_ref.global_position
	var bullet = bullet_scene.instantiate()
	bullet.init(target, global_position)
	get_tree().root.add_child(bullet)
	SoundManager.play_laser(sound)

func _on_nav_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func _on_shoot_timer_timeout():
	shoot()
