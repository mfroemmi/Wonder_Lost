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
	if (!neighbors.has("left")):
		print("set left")
	if (!neighbors.has("right")):
		print("set right")
	if (!neighbors.has("front")):
		var children = _item.get_children()
		for child in children:
			if child.name == "Front":
				child.visible = true
		print("set front")
	if (!neighbors.has("back")):
		print("set back")
		
	return _item
	
