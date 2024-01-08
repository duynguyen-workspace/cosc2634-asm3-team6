extends TextureButton

@onready var level_label = $LevelLabel

var _level_number: String = "22"

func _ready():
	level_label.text = _level_number
	
func set_level_number(level_number: String) -> void:
	_level_number = level_number
	
func _on_pressed():
	GameManager.load_level_scene(_level_number)


