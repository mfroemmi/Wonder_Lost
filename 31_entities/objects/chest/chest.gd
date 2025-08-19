extends Node3D
class_name Chest

@export var inventory_data: InventoryData
@export var character_collision_component: CharacterCollisionComponent

var isChestOpened: bool = false

func _ready():
	pass


func close_chest():
	if isChestOpened:
		isChestOpened = false


func _on_static_body_3d_input_event(_camera: Node, _event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if (_event.is_pressed() and _event.button_index == MOUSE_BUTTON_LEFT) and character_collision_component.is_character_entered:
		if not isChestOpened:
			isChestOpened = true
			
			Signals.toggle_inventory.emit(self)
