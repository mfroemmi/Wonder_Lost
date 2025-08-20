extends PanelContainer

class_name BuildModeSlot

signal slot_clicked(index: int, button: int)

@onready var object_texture = $HBoxContainer/MarginContainer/TextureRect
@onready var object_name = $HBoxContainer/MarginContainer2/VBoxContainer/Name
@onready var object_item1_texture = $HBoxContainer/MarginContainer2/VBoxContainer/VBoxContainer/HBoxContainer/Item1TextureRect
@onready var object_item2_texture = $HBoxContainer/MarginContainer2/VBoxContainer/VBoxContainer/HBoxContainer2/Item2TextureRect
@onready var object_item1_amount = $HBoxContainer/MarginContainer2/VBoxContainer/VBoxContainer/HBoxContainer/Item1Label
@onready var object_item2_amount = $HBoxContainer/MarginContainer2/VBoxContainer/VBoxContainer/HBoxContainer2/Item2Label

var placeable: bool = false


func set_slot_data(slot_data: ObjectSlotData):
	var data = slot_data.object_data
	placeable = data.placeable
	
	object_name.text = data.name
	object_texture.texture = data.texture
	
	hide_ui()
	
	for i in len(data.required_items):
		var item_stack = data.required_items[i] as ObjectItemStack
		if i == 0:
			object_item1_texture.visible = true
			object_item1_amount.visible = true
			object_item1_texture.texture = item_stack.item.texture
			object_item1_amount.text = str(item_stack.amount) + "x"
		if i == 1:
			object_item2_texture.visible = true
			object_item2_amount.visible = true
			object_item2_texture.texture = item_stack.item.texture
			object_item2_amount.text = str(item_stack.amount) + "x"
	

func hide_ui():
	object_item1_texture.visible = false
	object_item1_amount.visible = false
	object_item2_texture.visible = false
	object_item2_amount.visible = false


func _on_gui_input(event):
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed() and placeable:
		slot_clicked.emit(get_index(), event.button_index)
