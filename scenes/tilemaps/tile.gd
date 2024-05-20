extends Node3D
class_name Tile

var coordinates_cell: Vector3
var coordinates_local: Vector3
var item: Node3D

func _init(
	coord_cell: Vector3,
	coord_local: Vector3,
	item_scene: PackedScene
	):
	coordinates_cell = coord_cell
	coordinates_local = coord_local
	item = item_scene.instantiate() as Node3D
	
	
