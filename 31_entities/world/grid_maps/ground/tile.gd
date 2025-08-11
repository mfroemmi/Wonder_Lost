extends Node3D
class_name Tile

var coordinates_cell: Vector3
var coordinates_local: Vector3
var _item: Node3D
var neighbors: Array = []

func _init(
	coord_cell: Vector3,
	coord_local: Vector3,
	item_scene: PackedScene
	):
	coordinates_cell = coord_cell
	coordinates_local = coord_local
	_item = item_scene.instantiate() as Node3D

func get_item():
	var children = _item.get_children()
	for child in children:
		# Stones
		if get_chance(50):
			if child.name == "Stone_1":
				if get_chance(30):
					child.visible = true
					child.rotate(Vector3.UP, randf_range(0, 360))
		else:
			if child.name == "Stone_2":
				if get_chance(30):
					child.visible = true
					child.rotate(Vector3.UP, randf_range(0, 360))
		# Walls
		if child.name == "Front_Wall" && !neighbors.has("front"):
				child.visible = true
		if child.name == "Left_Wall" && !neighbors.has("left"):
				child.visible = true
		if child.name == "Right_Wall" && !neighbors.has("right"):
				child.visible = true
		if child.name == "Back_Wall" && !neighbors.has("back"):
				child.visible = true
		# Border
		if (!neighbors.has("top")):
			if child.name == "Front" && !neighbors.has("front"):
				child.visible = true
			if child.name == "Left" && !neighbors.has("left"):
				child.visible = true
			if child.name == "Right" && !neighbors.has("right"):
				child.visible = true
			if child.name == "Back" && !neighbors.has("back"):
				child.visible = true
		
	return _item
	
func get_chance(chance: int) -> bool:
	var random_number = randi() % 100
	return random_number < chance
