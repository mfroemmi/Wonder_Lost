extends Node3D

@onready var stone_buddy = $EntitiesLayer/StoneBuddy
@onready var inventory_interface = $UI/InventoryInterface

func _ready():
	stone_buddy.toggle_inventory.connect(on_toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(stone_buddy.inventory_data)


func on_toggle_inventory_interface():
	inventory_interface.visible = not inventory_interface.visible
