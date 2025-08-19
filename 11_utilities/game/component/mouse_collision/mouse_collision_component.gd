extends Area3D

class_name MouseCollisionComponent

signal mouse_collision(is_mouse_entered: bool)
signal mouse_input(event)

var is_mouse_entered: bool = false


func _ready() -> void:
	mouse_entered.connect(on_mouse_entered)
	mouse_exited.connect(on_mouse_exited)
	input_event.connect(on_input_event)
	

func on_mouse_entered():
	print("mouse entered")
	is_mouse_entered = true
	mouse_collision.emit(true)


func on_mouse_exited():
	print("mouse exited")
	is_mouse_entered = false
	mouse_collision.emit(false)


func on_input_event(_camera, event, _position, _normal, _shape_idx):
	mouse_input.emit(event)
