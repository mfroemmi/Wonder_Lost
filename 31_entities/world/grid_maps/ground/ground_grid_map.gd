@tool
extends GridMap

@export var item_scene: PackedScene
var parentNode: Node
var tiles = []
var old_tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	generate_tiles()

func generate_tiles():
	var cells = get_used_cells()
	old_tiles = tiles
	
	if (cells.size() != tiles.size()):
		reset()
		
		for cell in cells:
			var coordinates_cell = Vector3(cell.x, cell.y, cell.z)
			var coordinates_local = map_to_local(coordinates_cell)
			
			var tile = Tile.new(coordinates_cell, coordinates_local, item_scene)

			var neighbors = {
				"top": Vector3i(cell.x, cell.y + 1, cell.z),
				"bottom": Vector3i(cell.x, cell.y - 1, cell.z),
				"left": Vector3i(cell.x - 1, cell.y, cell.z),
				"right": Vector3i(cell.x + 1, cell.y, cell.z),
				"front": Vector3i(cell.x, cell.y, cell.z + 1),
				"back": Vector3i(cell.x, cell.y, cell.z - 1),
				"left_front": Vector3i(cell.x - 1, cell.y, cell.z + 1),
				"left_back": Vector3i(cell.x - 1, cell.y, cell.z - 1),
				"right_front": Vector3i(cell.x + 1, cell.y, cell.z + 1),
				"right_back": Vector3i(cell.x + 1, cell.y, cell.z - 1)
			}
			
			for direction in neighbors.keys():
				if cells.has(neighbors[direction]):
					tile.neighbors.append(direction)
			
			#print(tile.neighbors)
			tiles.append(tile)
			
			var item = tile.get_item()
			add_child(item)
			item.global_position = to_global(tile.coordinates_local) - Vector3(0, 1, -1)

func reset():
	tiles.clear()
	
	for i in range(0, get_child_count()):
		get_child(i).queue_free()
	
func match_tiles(cell: Vector3) -> bool:
	var found = false
	var found_tile = null
	var coordinates_cell = cell
	
	for tile in old_tiles:
		#print("tile ", tile.coordinates_cell, " coordinates_cell ", coordinates_cell)
		if tile.coordinates_cell == coordinates_cell:
			found_tile = tile
			found = true
			break
	
	if found != null:
		tiles.append(found_tile)
		print("Tile with coordinates ", coordinates_cell, " already exists in tiles.")
	else:
		print("Tile with coordinates ", coordinates_cell, " not found in tiles.")
	
	return found
