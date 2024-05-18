@tool
extends GridMap

var tiles = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_used_cells_by_id(0)

func get_used_cells_by_id(id: int):
	var cells = get_used_cells()
	for i in cells:
		var cell_item = Vector3(i.x, i.y, i.z)
		
		print(cell_item)
