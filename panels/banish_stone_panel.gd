extends PanelContainer

const Slot = preload("res://inventory/slot.tscn")
var external_inventory_owner

@onready var item_grid: GridContainer = $MarginContainer/VBoxContainer/MarginContainer/CenterContainer/ItemGrid
@onready var button: Button = $MarginContainer/VBoxContainer/Button
	
	
func _ready():
	button.pressed.connect(self._button_pressed)
	

func set_inventory_data(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	external_inventory_owner.inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(external_inventory_owner.inventory_data)
	
	
func clear_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_updated.disconnect(populate_item_grid)


func populate_item_grid(inventory_data: InventoryData):
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in inventory_data.slot_datas:
		var slot = Slot.instantiate()
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(inventory_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)


func _button_pressed():
	external_inventory_owner.activateBanishStone()
