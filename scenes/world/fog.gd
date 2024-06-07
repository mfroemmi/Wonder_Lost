extends Node3D

@export var areas: Node3D
var area_statuses: Array = []

func _ready():
	if (areas == null):
		return
		
	area_statuses.resize(areas.get_child_count())
	for i in len(areas.get_children()):
		var area = areas.get_child(i)
		_connect_area_signals(area, i)

# Helper function to connect signals
func _connect_area_signals(area: Area3D, id: int):
	area.body_entered.connect(Callable(self, "_on_body_entered").bind(id))
	area.body_exited.connect(Callable(self, "_on_body_exited").bind(id))

func _process(_delta):
	if (areas == null):
		return
	
	var currentCount = get_entered_count()
	if (currentCount >= areas.get_child_count() * 0.9):
		queue_free()

func _on_body_entered(_other_body: Node3D, id: int):
	area_statuses[id] = true
	
func _on_body_exited(_other_body: Node3D, id: int):
	pass

func get_entered_count() -> int:
	var count = 0
	for status in area_statuses:
		if status:
			count += 1
	return count
