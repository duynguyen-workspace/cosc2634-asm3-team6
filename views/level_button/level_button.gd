extends TextureButton

@onready var level_label = $LevelLabel

var _level_number: String = "22"

# Called when the node enters the scene tree for the first time.
func _ready():
	level_label.text = _level_number
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func set_level_number(level_number: String) -> void:
	_level_number = level_number
	


func _on_pressed():
	GameManager.load_level_scene(_level_number)
