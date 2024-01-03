extends Node3D

@onready var stone_buddy = $EntitiesLayer/StoneBuddy
@onready var inventory_interface = $UI/InventoryInterface

func _ready():
	stone_buddy.toggle_inventory.connect(on_toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(stone_buddy.inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(on_toggle_inventory_interface)


func on_toggle_inventory_interface(external_inventory_owner = null):
	inventory_interface.visible = not inventory_interface.visible
	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()
