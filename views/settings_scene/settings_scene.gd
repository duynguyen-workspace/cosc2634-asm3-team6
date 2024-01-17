extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("testing") == true:
		GameManager.load_level_scene("1")




func _on_main_button_pressed():
	GameManager.load_main_scene()


func _on_instructions_button_pressed():
	GameManager.load_instructions_scene()


func _on_credits_button_pressed():
	GameManager.load_credits_scene()
