extends Node3D

@export var outlineMesh: MeshInstance3D
@export var mouse_collision: MouseCollisionComponent
@export var character_collision: CharacterCollisionComponent
@export var slot_data: SlotData


func _ready():
	mouse_collision.mouse_collision.connect(on_mouse_collision)
	mouse_collision.mouse_input.connect(on_mouse_input)
	character_collision.character_collision.connect(on_character_collision)


func on_mouse_collision(is_mouse_entered: bool):
	if character_collision.is_character_entered:
		outlineMesh.visible = is_mouse_entered


func on_character_collision(is_character_entered: bool):
	if not is_character_entered:
		outlineMesh.visible = false

	
func on_mouse_input(event):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and character_collision.is_character_entered and mouse_collision.is_mouse_entered:
		slot_data.quantity = 1
		if character_collision.character.inventory_data.pick_up_slot_data(slot_data):
			owner.queue_free()
