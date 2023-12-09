
extends Node2D

@onready var spawnPoints = [
	$"Node2D/Spawn 1",
	$"Node2D/Spawn 2",
	$"Node2D/Spawn 3",
	$"Node2D/Spawn 4",
	$"Node2D/Spawn 5",
	$"Node2D/Spawn 6",
	$"Node2D/Spawn 7",
	$"Node2D/Spawn 8"
]
var availableSpawnPoints = []
@onready var spawnTrashTimer = $Node2D/SpawnTrashTimer

func _ready():
	availableSpawnPoints = spawnPoints

func _on_spawn_trash_timer_timeout():
	if availableSpawnPoints.size() > 0:
		spawnTrash()


func spawnTrash():
	var trashScene = preload("res://models/objects/trash/trash.tscn")  # Load your trash scene
	print(availableSpawnPoints)
	if availableSpawnPoints.size() > 0:
		var randomSpawnPointIndex = randi() % availableSpawnPoints.size()
		var randomSpawnPoint = availableSpawnPoints[randomSpawnPointIndex]
		
		var trashAlreadyExists = randomSpawnPoint.get_child_count() > 0  # Check if there's already trash
		
		while trashAlreadyExists:
			availableSpawnPoints.remove(randomSpawnPoint)  # Remove this spawn point from available points
			if availableSpawnPoints.size() == 0:
				print("No available spawn points. Waiting for space.")
				return  # No available spawn points left, exit the function
			
			randomSpawnPointIndex = randi() % availableSpawnPoints.size()
			randomSpawnPoint = availableSpawnPoints[randomSpawnPointIndex]
			trashAlreadyExists = randomSpawnPoint.get_child_count() > 0

		var trashInstance = trashScene.instantiate()  
	
		if randomSpawnPoint is Node2D:
			randomSpawnPoint.add_child(trashInstance)
			trashInstance.position = Vector2.ZERO
			availableSpawnPoints.erase(randomSpawnPoint)
			
		else:
			print("Spawn point is not a Node2D, cannot spawn trash.")
	else:
		print("No available spawn points. Waiting for space.")
