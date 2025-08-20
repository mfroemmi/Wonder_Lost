extends Node3D

@export var marker: MeshInstance3D
@export var marker_collision_shape: CollisionShape3D
@export var grid_map: GridMap
@export var objects_container: Node3D

var object_data: ObjectData = null
var object_scene: Node = null
var can_place: bool = false


func _ready() -> void:
	marker.visible = false


func _process(_delta):
	marker.visible = false
	
	if not GameManager.is_object_placement_mode() or not object_scene:
		return
	
	var hit_info = get_ray_hit()
	if not hit_info:
		return
	
	var hit_pos_world: Vector3 = hit_info.position + Vector3(0.0, 0.1, 0.0)
	if not is_within_reach(hit_pos_world):
		return
	
	var hit_cell = grid_map.local_to_map(grid_map.to_local(hit_pos_world))
	update_marker_position(hit_cell)
		
	if object_scene:
		object_scene.global_position = grid_map.map_to_local(hit_cell) - Vector3(0.0, 0.5, 0.0)


func _input(event):
	if not object_scene:
		return
	
	if event is InputEventMouseButton and (event.button_index == MOUSE_BUTTON_LEFT) and event.is_pressed() and object_scene and can_place:
		var final_object = object_data.scene.instantiate()
		objects_container.add_child(final_object)
		final_object.global_position = object_scene.global_position
		final_object.rotation = object_scene.rotation
		Signals.toggle_object_placement_mode.emit(null)

	elif event is InputEventMouseButton and event.is_pressed():
		var rotation_step = deg_to_rad(45)
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			object_scene.rotate_y(-rotation_step)
			marker.rotate_y(-rotation_step)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			object_scene.rotate_y(rotation_step)
			marker.rotate_y(rotation_step)


func get_ray_hit() -> Dictionary:
	var camera = get_viewport().get_camera_3d()
	if not camera:
		return {}
		
	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 100.0

	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = false
	query.collide_with_bodies = true

	var collider_node = object_scene.get_node_or_null("StaticBody3D")
	if collider_node:
		query.exclude = [collider_node]

	var result = space_state.intersect_ray(query)

	if not result:
		return {}

	var collider = result.collider
	if not collider.is_in_group("placeable_for_objects"):
		return {}
		
	return result


func is_within_reach(hit_pos_world: Vector3) -> bool:
	var char_pos = GameManager.game_data.player.get_position()
	var char_cell = grid_map.local_to_map(grid_map.to_local(char_pos))
	var hit_cell = grid_map.local_to_map(grid_map.to_local(hit_pos_world))

	var distance_cells = (hit_cell - char_cell).abs()
	return distance_cells.x <= 9 and distance_cells.y <= 0 and distance_cells.z <= 9


func update_marker_position(hit_cell: Vector3) -> void:
	marker.visible = true
	marker.position = grid_map.map_to_local(hit_cell)
	check_marker_staticbody_collision()


func set_object_data(object_slot_data: ObjectSlotData):
	object_data = object_slot_data.object_data
	object_scene = object_data.scene.instantiate()
	add_child(object_scene)


func clear_object_data():
	marker.rotation = Vector3(0.0, 0.0, 0.0)
	object_data = null
	if object_scene and object_scene.is_inside_tree():
		object_scene.queue_free()
	object_scene = null


func check_marker_staticbody_collision() -> void:
	var space_state = get_world_3d().direct_space_state
	var params = PhysicsShapeQueryParameters3D.new()
	params.shape = marker_collision_shape.shape
	params.transform = marker.global_transform
	params.exclude = [marker]
	params.collide_with_bodies = true
	params.collide_with_areas = false

	var collisions = space_state.intersect_shape(params, 32)
	if collisions.size() > 0:
		can_place = false
	else:
		can_place = true
