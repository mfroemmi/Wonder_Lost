extends Node3D

@onready var meshInstance3D: MeshInstance3D = $Grass_000/MeshInstance3D
@onready var grass: MeshInstance3D = $Grass_000
@onready var timer: Timer = $Timer

@export var mouse_collision: MouseCollisionComponent
@export var character_collision: CharacterCollisionComponent
@export var slot_data: SlotData


func _ready():
	mouse_collision.mouse_collision.connect(on_mouse_collision)
	mouse_collision.mouse_input.connect(on_mouse_input)
	character_collision.character_collision.connect(on_character_collision)
	timer.timeout.connect(on_timer_timeout)


func on_mouse_collision(is_mouse_entered: bool):
	if character_collision.is_character_entered:
		meshInstance3D.visible = is_mouse_entered
	

func on_character_collision(is_character_entered: bool):
	if not is_character_entered:
		meshInstance3D.visible = false

	
func on_mouse_input(event):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and character_collision.is_character_entered and mouse_collision.is_mouse_entered and grass.visible:
		slot_data.quantity = 1
		character_collision.character.inventory_data.pick_up_slot_data(slot_data)
		grass.visible = false
		timer.start()


func on_timer_timeout():
	grass.visible = true
