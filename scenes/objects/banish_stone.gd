extends Node3D

signal toggle_inventory(external_inventory_owner)

@export var banishFog: FogVolume
@export var banishArea: CharacterBody3D
@export var mouseCollision: CollisionObject3D

@export var inventory_data: InventoryData

@export var duration: float = 30.0
var elapsed_time: float = 0.0
var isMouseEntered: bool = false

func _ready():
	if banishArea == null || banishFog == null:
		return
		
	mouseCollision.input_event.connect(on_mouse_input_input_event)
	mouseCollision.mouse_entered.connect(on_mouse_input_mouse_entered)
	mouseCollision.mouse_exited.connect(on_mouse_input_mouse_exited)

func _process(delta):
	if banishArea == null || banishFog == null:
		return

	elapsed_time += delta
	var scale_factor = lerp(1.0, 15.0, elapsed_time / duration)
	
	banishFog.scale = Vector3(scale_factor / 2, scale_factor / 2, scale_factor / 2)
	banishArea.scale = Vector3(scale_factor, 1.0, scale_factor)

	if elapsed_time >= duration:
		# Stop the process by removing this function from the _process loop.
		set_process(false)
	

func player_interact():
	toggle_inventory.emit(self)


func on_mouse_input_input_event(camera, event, position, normal, shape_idx):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and isMouseEntered:
		player_interact()


func on_mouse_input_mouse_entered():
	print("on_mouse_entered")
	isMouseEntered = true


func on_mouse_input_mouse_exited():
	print("on_mouse_exited")
	isMouseEntered = false
