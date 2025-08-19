extends Node3D

@export var marker: MeshInstance3D
@export var grid_map: GridMap


func _ready() -> void:
	marker.visible = false


func _process(_delta):
	marker.visible = false
	
	if not GameManager.is_build_mode():
		return
	
	var camera = get_viewport().get_camera_3d()
	if not camera:
		return
		
	var mouse_pos = get_viewport().get_mouse_position()

	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * 100.0

	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)
	query.collide_with_areas = false
	query.collide_with_bodies = true

	var result = space_state.intersect_ray(query)

	if not result:
		return

	var collider = result.collider
	if not collider.is_in_group("placeable_for_objects"):
		return

	var hit_pos_world = result.position + Vector3(0.0, 0.1, 0.0)
	var hit_cell = grid_map.local_to_map(grid_map.to_local(hit_pos_world))
	
	var char_pos = GameManager.game_data.player.get_position()
	var char_cell = grid_map.local_to_map(grid_map.to_local(char_pos))
	
	var distance_cells = (hit_cell - char_cell).abs()
	if distance_cells.x <= 9 and distance_cells.y <= 0 and distance_cells.z <= 9:
		#print("placeable for objects:", collider.name, ", hit_cell:", hit_cell, ", char_cell:", char_cell)
		
		marker.visible = true
		marker.position = grid_map.map_to_local(hit_cell)
