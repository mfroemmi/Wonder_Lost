extends PanelContainer

signal slot_clicked(index: int, button: int)

var item_name: String
var item_quantity: int

@onready var texture_rect = $MarginContainer/TextureRect
@onready var quantity_label = $MarginContainer2/QuantityLabel
@onready var placeable_label = $MarginContainer3/PlaceableLabel

func set_slot_data(slot_data: SlotData):
	var item_data = slot_data.item_data
	item_name = item_data.name
	item_quantity = slot_data.quantity
	texture_rect.texture = item_data.texture
	tooltip_text = "%s\n%s" % [item_data.name, item_data.description]
	
	if slot_data.quantity > 1:
		quantity_label.text = "x%s" % slot_data.quantity
		quantity_label.show()
	else:
		quantity_label.hide()
		
	if slot_data.item_data.placeable:
		placeable_label.show()
	else:
		placeable_label.hide()

func _on_gui_input(event):
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT \
			or event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
