extends ProgressBar


signal died


@export var level_low: int = 30
@export var level_medium: int = 65
@export var start_health: int = 100


const COLOR_DANGER: Color = Color("#cc0000")
const COLOR_MIDDLE: Color = Color("#ff9900")
const COLOR_GOOD: Color = Color("#33cc33")

var bar = StyleBoxFlat.new()
var health = StyleBoxFlat.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	max_value = start_health
	value = start_health
	add_theme_stylebox_override("fill", health)
	health.border_width_top = 2
	health.border_width_bottom = 2
	health.border_width_left = 2
	health.border_width_right = 2
	health.corner_radius_top_left = 4
	health.corner_radius_top_right = 4
	health.corner_radius_bottom_left = 4
	health.corner_radius_bottom_right = 4
	health.border_color = Color("cccccc00")
	add_theme_stylebox_override("background", bar)
	bar.border_width_top = 1
	bar.border_width_bottom = 1
	bar.border_width_left = 1
	bar.border_width_right = 1
	bar.corner_radius_top_left = 4
	bar.corner_radius_top_right = 4
	bar.corner_radius_bottom_left = 4
	bar.corner_radius_bottom_right = 4
	bar.border_color = Color("ffffffbf")
	set_color()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("hit") == true:
		take_damage(10)
	if Input.is_action_just_pressed("refill") == true:
		incr_value(5)
	
	
func set_color() -> void:
	if value <= level_low:
		health.bg_color = COLOR_DANGER
	elif value < level_medium:
		health.bg_color = COLOR_MIDDLE
	else:
		health.bg_color = COLOR_GOOD
		
		
func incr_value(v: int) -> void:
	value += v
	if value <= 0:
		died.emit()
	set_color()
	
	
func take_damage(v: int) -> void:
	incr_value(-v)


func _on_died():
	SignalController.on_game_over.emit()
