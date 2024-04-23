extends Node3D

@export var outlineMesh: MeshInstance3D
@export var mouseCollision: CollisionObject3D
@export var bodyCollision: Area3D
@export var slot_data: SlotData

var isMouseEntered: bool = false
var other_body: Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	bodyCollision.body_entered.connect(on_body_entered)
	bodyCollision.body_exited.connect(on_body_exited)
	
	mouseCollision.input_event.connect(on_area_3d_mouse_collision_input_event)
	mouseCollision.mouse_entered.connect(on_area_3d_mouse_entered)
	mouseCollision.mouse_exited.connect(on_area_3d_mouse_exited)


func on_body_entered(_other_body: Node3D):
	other_body = _other_body
	
	
func on_body_exited(_other_body: Node3D):
	other_body = null


func on_area_3d_mouse_entered():
	if other_body:
		isMouseEntered = true
		outlineMesh.visible = true


func on_area_3d_mouse_exited():
	isMouseEntered = false
	outlineMesh.visible = false
	
	
func on_area_3d_mouse_collision_input_event(camera, event, position, normal, shape_idx):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and isMouseEntered:
		slot_data.quantity = 1
		if other_body.inventory_data.pick_up_slot_data(slot_data):
			owner.queue_free()

