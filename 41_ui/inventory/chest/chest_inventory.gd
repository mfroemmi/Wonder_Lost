extends PanelContainer
class_name ChestInventory

@onready var inventory = $Inventory

var external_inventory_owner: Chest

func get_inventory() -> PanelContainer:
	return inventory
	
	
func set_inventory_owner(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	inventory.set_inventory_data(external_inventory_owner.inventory_data)


func clear_inventory_owner(_external_inventory_owner):
	external_inventory_owner = null
	inventory.clear_inventory_data(_external_inventory_owner.inventory_data)
