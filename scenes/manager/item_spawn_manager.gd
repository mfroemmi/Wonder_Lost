extends Node3D

@export var item_scene: PackedScene
@export var spawn_radius: int = 10
@export var max_items: int = 5

var entities_layer = Node3D.new()
var currentPosition = Vector3.ZERO

func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	currentPosition = global_transform.origin
	
	add_child(entities_layer)


func _process(delta):
	pass


func on_timer_timeout():
	var entities_size = entities_layer.get_children().size()
	if (entities_size < max_items):
		var random_direction =  Vector3.FORWARD.rotated(Vector3.UP, randf_range(0, TAU))
		var spawn_factor = randf_range(0.1, 1.0)
		var spawn_position = currentPosition + (random_direction * (spawn_radius * spawn_factor))

		var item = item_scene.instantiate() as Node3D

		entities_layer.add_child(item)
		item.global_position = spawn_position
