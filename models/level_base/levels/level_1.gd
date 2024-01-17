
extends Node2D

@onready var spawnPoints = [
	$"SpawnPoints/Spawn 1", 
	$"SpawnPoints/Spawn 2", 
	$"SpawnPoints/Spawn 3", 
	$"SpawnPoints/Spawn 4", 
	$"SpawnPoints/Spawn 5", 
	$"SpawnPoints/Spawn 6"
]
var availableSpawnPoints = []
@onready var spawnTrashTimer = $SpawnPoints/SpawnTimer

func _ready():
	availableSpawnPoints = spawnPoints
	

func _on_spawn_timer_timeout():
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


