extends Node3D

@onready var stone_buddy = $EntitiesLayer/StoneBuddy
@onready var inventory_interface = $UI/InventoryInterface

func _ready():
	stone_buddy.toggle_inventory.connect(on_toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(stone_buddy.inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(on_toggle_inventory_interface)


func on_toggle_inventory_interface(external_inventory_owner = null):
	var is_external_inventory_open = inventory_interface.is_external_inventory_open()
	
	if is_external_inventory_open == false:
		inventory_interface.visible = not inventory_interface.visible

	if external_inventory_owner:
		if is_external_inventory_open == false:
			inventory_interface.visible = true
			inventory_interface.set_external_inventory(external_inventory_owner)
		else:
			inventory_interface.visible = false
			inventory_interface.clear_external_inventory()


func _on_inventory_interface_drop_slot_data(slot_data: SlotData):
	if slot_data.item_data.placeable_scene != null:
		var scene = slot_data.item_data.placeable_scene.instantiate()
		scene.global_position = stone_buddy.get_drop_position()
		add_child(scene)
