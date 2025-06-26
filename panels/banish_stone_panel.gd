extends PanelContainer

const Slot = preload("res://inventory/slot.tscn")
var external_inventory_owner

@export var item_grid: GridContainer
@export var not_activated_container: VBoxContainer
@export var activated_container: PanelContainer
@export var button: Button
	
	
func _ready():
	button.pressed.connect(self._button_pressed)

func set_inventory_data(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	external_inventory_owner.inventory_data.inventory_updated.connect(populate_item_grid)
	populate_item_grid(external_inventory_owner.inventory_data)
	
	if external_inventory_owner.isActivated:
		not_activated_container.visible = false
		activated_container.visible = true
	else:
		not_activated_container.visible = true
		activated_container.visible = false
	
	
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
	var gem: bool
	var vase: bool

	for child in item_grid.get_children():
		if child.item_name == "Gem" and child.item_quantity == 1:
			gem = true
		if child.item_name == "Vase" and child.item_quantity == 2:
			vase = true
	
	if gem and vase:
		not_activated_container.visible = false
		activated_container.visible = true
		external_inventory_owner.activateBanishStone()
