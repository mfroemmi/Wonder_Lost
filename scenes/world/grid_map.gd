@tool
extends GridMap

@export var item_scene: PackedScene
var tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	generate_tiles()

func generate_tiles():
	var cells = get_used_cells()
	
	if (cells.size() != tiles.size()):
		reset()
		
		for cell in cells:
			var coordinates_cell = Vector3(cell.x, cell.y, cell.z)
			var coordinates_local = map_to_local(coordinates_cell)
			var tile = Tile.new(coordinates_cell, coordinates_local, item_scene)
			
			add_child(tile.item)
			tile.item.global_position = to_global(tile.coordinates_local) - Vector3(0, 1, -1)
			
			# Check for neighbors (excluding top and bottom)
			var neighbors = {
				"left": Vector3i(cell.x - 1, cell.y, cell.z),
				"right": Vector3i(cell.x + 1, cell.y, cell.z),
				"front": Vector3i(cell.x, cell.y, cell.z + 1),
				"back": Vector3i(cell.x, cell.y, cell.z - 1),
				"left_front": Vector3i(cell.x - 1, cell.y, cell.z + 1),
				"left_back": Vector3i(cell.x - 1, cell.y, cell.z - 1),
				"right_front": Vector3i(cell.x + 1, cell.y, cell.z + 1),
				"right_back": Vector3i(cell.x + 1, cell.y, cell.z - 1)
			}
			
			var neighbor_info = 0
			var direction_values = {
				"left": 1,
				"right": 2,
				"front": 4,
				"back": 8,
				"left_front": 16,
				"left_back": 32,
				"right_front": 64,
				"right_back": 128
			}
			
			for direction in neighbors.keys():
				if cells.has(neighbors[direction]):
					neighbor_info |= direction_values[direction]
					print("Cell at ", cell, " has a neighbor on the ", direction, " side.")
			
			print(neighbor_info)
			
			tiles.append(tile)
		
		print(tiles.size())

func reset():
	tiles.clear()
	for i in range(0, get_child_count()):
		get_child(i).queue_free()
		
