extends Node3D

@onready var meshInstance3D: MeshInstance3D = $Grass_000/MeshInstance3D
@onready var grass: MeshInstance3D = $Grass_000
@onready var timer: Timer = $Timer

var isBodyEntered: bool = false
var isMouseEntered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionArea3D.body_entered.connect(on_body_entered)
	$CollisionArea3D.body_exited.connect(on_body_exited)
	
	timer.timeout.connect(on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_mouse_collision_mouse_entered():
	if isBodyEntered:
		isMouseEntered = true
		meshInstance3D.visible = true


func _on_area_3d_mouse_collision_mouse_exited():
	isMouseEntered = false
	meshInstance3D.visible = false
	
	
func _on_area_3d_mouse_collision_input_event(camera, event, position, normal, shape_idx):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and isMouseEntered:
		grass.visible = false
		timer.start()


func on_body_entered(other_body: Node3D):
	isBodyEntered = true
	
	
func on_body_exited(other_body: Node3D):
	isBodyEntered = false

func on_timer_timeout():
	grass.visible = true
