extends PanelContainer

class_name BuildModeSlot

signal slot_clicked(index: int, button: int)

@onready var object_texture = $HBoxContainer/MarginContainer/TextureRect
@onready var object_name = $HBoxContainer/MarginContainer2/VBoxContainer/Name


func set_slot_data(slot_data: ObjectSlotData):
	var data = slot_data.object_data
	object_name.text = data.name
	object_texture.texture = data.texture
	

func _on_gui_input(event):
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
