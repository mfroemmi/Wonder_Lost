extends Node3D

@export var item_scene: PackedScene
@export var spawn_radius: int = 10
@export var max_items: int = 5

var entities_layer = Node3D.new()
var currentPosition = Vector3.ZERO

func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	currentPosition = $RayCast3D.global_transform.origin
	
	add_child(entities_layer)


func on_timer_timeout():
	var entities_size = entities_layer.get_children().size()
	if (entities_size < max_items):
		# Set the position for the ray cast object
		var random_direction =  Vector3.FORWARD.rotated(Vector3.UP, randf_range(0, TAU))
		var spawn_factor = randf_range(0.1, 1.0)
		$RayCast3D.global_transform.origin = currentPosition + (random_direction * (spawn_radius * spawn_factor))
		
		# Find spawn point with ray-casting intersection
		if $RayCast3D.is_colliding():
			if $RayCast3D.get_collider().is_in_group("spawn_collider"):
				
				# Spawn object on collider position
				var spawn_position = $RayCast3D.get_collision_point()
				var item = item_scene.instantiate() as Node3D
				entities_layer.add_child(item)
				
				item.global_position = spawn_position
				item.rotate(Vector3.UP, randf_range(0, 360))
		
