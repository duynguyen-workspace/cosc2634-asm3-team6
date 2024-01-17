extends Node

const TRASH_LIST = [
	preload("res://assets/trash_assets/alcohol.png"),
	preload("res://assets/trash_assets/box tile 16x16 2.png"),
	preload("res://assets/trash_assets/box.png"), 
	preload("res://assets/trash_assets/container-2.png"), 
	preload("res://assets/trash_assets/cup.png"), 
	preload("res://assets/trash_assets/drink.png"), 
	preload("res://assets/trash_assets/food-can.png"), 
	preload("res://assets/trash_assets/garbage bag 2.png"), 
	preload("res://assets/trash_assets/glass.png"), 
	preload("res://assets/trash_assets/newspaper.png"), 
	preload("res://assets/trash_assets/spraying-tool.png"),
	preload("res://assets/trash_assets/coca-bottle.png"),
	preload("res://assets/trash_assets/pepsi-bottle.png"), 
	preload("res://assets/trash_assets/pizza-box.png"), 
	preload("res://assets/trash_assets/rusty sheet metal tile blue 16x16 2.png"), 
	preload("res://assets/trash_assets/satellite dish.png"), 
	preload("res://assets/trash_assets/screen 1.png"), 
	preload("res://assets/trash_assets/takeaway-box.png"), 
	preload("res://assets/trash_assets/washing-container.png"), 
	preload("res://assets/trash_assets/water bottle clean.png"), 
	preload("res://assets/trash_assets/water bottle dirty.png"), 
	preload("res://assets/trash_assets/water-bottle.png")
]

const GENERAL_LIST = [
	preload("res://assets/trash_assets/cup.png"), 
	preload("res://assets/trash_assets/glass.png"), 
	preload("res://assets/trash_assets/newspaper.png"), 
	preload("res://assets/trash_assets/spraying-tool.png"),
	preload("res://assets/trash_assets/rusty sheet metal tile blue 16x16 2.png"), 
	preload("res://assets/trash_assets/satellite dish.png"), 
	preload("res://assets/trash_assets/screen 1.png"), 
]

const RECYCLING_LIST = [
	preload("res://assets/trash_assets/alcohol.png"),
	preload("res://assets/trash_assets/coca-bottle.png"),
	preload("res://assets/trash_assets/pepsi-bottle.png"),
	preload("res://assets/trash_assets/washing-container.png"),
	preload("res://assets/trash_assets/water bottle clean.png"), 
	preload("res://assets/trash_assets/water bottle dirty.png"), 
	preload("res://assets/trash_assets/water-bottle.png"),
	preload("res://assets/trash_assets/box tile 16x16 2.png"),
	preload("res://assets/trash_assets/box.png"), 
	preload("res://assets/trash_assets/container-2.png"), 
	preload("res://assets/trash_assets/garbage bag 2.png")
]

const FOOD_LIST = [
	preload("res://assets/trash_assets/drink.png"), 
	preload("res://assets/trash_assets/food-can.png")
]

func choose_random_texture() -> int:
	if TRASH_LIST.size() <= 0:
		return -1
		
	# Randomly choose a texture from the array
	var randomIndex = randi() % TRASH_LIST.size()
	return randomIndex
