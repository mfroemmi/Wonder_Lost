extends Node3D

@export var outlineMesh: MeshInstance3D
@export var mouseCollision: CollisionObject3D
@export var bodyCollision: Area3D

var isBodyEntered: bool = false
var isMouseEntered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	bodyCollision.body_entered.connect(on_body_entered)
	bodyCollision.body_exited.connect(on_body_exited)
	
	mouseCollision.input_event.connect(on_area_3d_mouse_collision_input_event)
	mouseCollision.mouse_entered.connect(on_area_3d_mouse_entered)
	mouseCollision.mouse_exited.connect(on_area_3d_mouse_exited)


func on_body_entered(other_body: Node3D):
	isBodyEntered = true
	
	
func on_body_exited(other_body: Node3D):
	isBodyEntered = false


func on_area_3d_mouse_entered():
	if isBodyEntered:
		isMouseEntered = true
		outlineMesh.visible = true


func on_area_3d_mouse_exited():
	isMouseEntered = false
	outlineMesh.visible = false
	
	
func on_area_3d_mouse_collision_input_event(camera, event, position, normal, shape_idx):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and isMouseEntered:
		owner.queue_free()

