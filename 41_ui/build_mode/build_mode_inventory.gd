extends PanelContainer

const Slot = preload("res://41_ui/build_mode/build_mode_slot.tscn")

@onready var item_grid: GridContainer = $MarginContainer/ItemGrid
	
func set_inventory_data(inventory_data: BuildModeData):
	populate_item_grid(inventory_data)
	

func populate_item_grid(build_mode_data: BuildModeData):
	for child in item_grid.get_children():
		child.queue_free()
		
	for slot_data in build_mode_data.slot_datas:
		var slot = Slot.instantiate() as BuildModeSlot
		item_grid.add_child(slot)
		
		slot.slot_clicked.connect(build_mode_data.on_slot_clicked)
		
		if slot_data:
			slot.set_slot_data(slot_data)
