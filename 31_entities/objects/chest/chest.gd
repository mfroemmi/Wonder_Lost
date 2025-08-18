extends Node3D
class_name Chest

@export var inventory_data: InventoryData

var isBodyEntered: bool = false
var isChestOpened: bool = false

func _ready():
	$Area3D.body_entered.connect(on_body_entered)
	$Area3D.body_exited.connect(on_body_exited)
	

func on_body_entered(_other_body: Node3D):
	print("on_body_entered")
	isBodyEntered = true
	
	
func on_body_exited(_other_body: Node3D):
	print("on_body_exited")
	isBodyEntered = false


func close_chest():
	if isChestOpened:
		isChestOpened = false


func _on_static_body_3d_input_event(_camera: Node, _event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if (_event.is_pressed() and _event.button_index == MOUSE_BUTTON_LEFT) and isBodyEntered:
		if not isChestOpened:
			isChestOpened = true
			
			Signals.toggle_inventory.emit(self)
