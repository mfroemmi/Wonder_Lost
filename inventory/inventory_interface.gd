extends Control

signal drop_slot_data(slot_data: SlotData)

var grabbed_slot_data: SlotData
var external_inventory_owner

@onready var player_inventory = $PlayerInventory
@onready var grabbed_slot = $GrabbedSlot
@onready var external_inventory = $ExternalInventory
@onready var banish_stone_panel = $BanishStonePanel

func _physics_process(_delta):
	if grabbed_slot.visible:
		grabbed_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
		

# Player-Inventory
func set_player_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory.set_inventory_data(inventory_data)
	

# External-Inventory (Chest, Banish)
func set_external_inventory(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	var inventory_type = external_inventory_owner.inventory_type
	
	inventory_data.inventory_interact.connect(on_inventory_interact)
	
	if inventory_type == INVENTORY_TYPE.CHEST:
		external_inventory.set_inventory_data(inventory_data)
		external_inventory.show()
	if inventory_type == INVENTORY_TYPE.BANISH:
		banish_stone_panel.set_inventory_data(external_inventory_owner)
		banish_stone_panel.show()
	
	
func clear_external_inventory():
	if external_inventory_owner:
		var inventory_data = external_inventory_owner.inventory_data
		var inventory_type = external_inventory_owner.inventory_type
		
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		
		if inventory_type == INVENTORY_TYPE.CHEST:
			external_inventory.clear_inventory_data(inventory_data)
			external_inventory.hide()
			external_inventory_owner = null
		if inventory_type == INVENTORY_TYPE.BANISH:
			banish_stone_panel.clear_inventory_data(inventory_data)
			banish_stone_panel.hide()
			external_inventory_owner = null
			
	
func is_external_inventory_open() -> bool:
	if external_inventory_owner:
		return true
	else:
		return false

# Interact
func on_inventory_interact(inventory_data: InventoryData, index: int, button: int):
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			pass
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)
			
	update_grabbed_slot()
	
	
func update_grabbed_slot():
	if grabbed_slot_data:
		grabbed_slot.show()
		grabbed_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_slot.hide()


func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed() and grabbed_slot_data:
		if grabbed_slot_data.item_data.placeable:
			match event.button_index:
				MOUSE_BUTTON_LEFT:
					drop_slot_data.emit(grabbed_slot_data)
					grabbed_slot_data = null
			
			update_grabbed_slot()
