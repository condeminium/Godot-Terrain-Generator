@tool
extends Node2D

@export var generateTerrain : bool
@export var clearTerrain : bool
@export var mapWidth : int
@export var mapHeight : int
@export var waterThreshold : float
@export var water2Threshold : float
@export var grassThreshold : float
@export var grass2Threshold : float
@export var dirtThreshold : float
@export var rockThreshold : float
@export var snowThreshold : float
@export var terrainSeed : int
@onready var ground = $Ground

func _process(delta: float) -> void:
	if generateTerrain:
		generateTerrain = false
		GenerateTerrain()
	if clearTerrain:
		clearTerrain = false
		ground.clear()
	pass
	
func GenerateTerrain():
	
	print("Generating Terrain....")
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_CELLULAR
	var rng = RandomNumberGenerator.new()
	
	if terrainSeed == 0:
		noise.seed = rng.randi()
	else:
		noise.seed = terrainSeed
	
	for x in range(mapWidth):
		for y in range(mapHeight):
			if noise.get_noise_2d(x,y) > waterThreshold:
				ground.set_cell(Vector2i(x,y), 0, Vector2i(2,1),0)
			elif noise.get_noise_2d(x,y) > water2Threshold:
				ground.set_cell(Vector2i(x,y), 0, Vector2i(1,1),0)
			elif noise.get_noise_2d(x,y) > grassThreshold:
				ground.set_cell(Vector2i(x,y), 0, Vector2i(0,0),0)
			elif noise.get_noise_2d(x,y) > grass2Threshold:
				ground.set_cell(Vector2i(x,y), 0, Vector2i(1,0),0)
			elif noise.get_noise_2d(x,y) > dirtThreshold:
				ground.set_cell(Vector2i(x,y), 0, Vector2i(2,0),0)
			elif noise.get_noise_2d(x,y) > rockThreshold:
				ground.set_cell(Vector2i(x,y), 0, Vector2i(3,0),0)
			elif noise.get_noise_2d(x,y) > snowThreshold:
				ground.set_cell(Vector2i(x,y), 0, Vector2i(0,1),0)
			else:
				ground.set_cell(Vector2i(x,y), 0, Vector2i(3,3),0)
