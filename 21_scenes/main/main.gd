extends Node3D

@onready var stone_buddy = $Entities/Characters/StoneBuddy
@onready var inventory_interface = $UI/InventoryInterface
@onready var build_mode_interface = $UI/BuildModeInterface

func _ready():
	Signals.toggle_inventory.connect(func(external_inventory_owner):on_toggle_inventory_interface(external_inventory_owner))
	Signals.toggle_build_mode.connect(on_toggle_build_mode)
	Signals.drop_slot_data.connect(on_drop_slot_data)
	inventory_interface.set_player_inventory_data(stone_buddy.inventory_data)


func on_toggle_inventory_interface(external_inventory_owner = null):
	if not (GameManager.is_normal_mode() or GameManager.is_inventory_mode()):
		return
		
	GameManager.toggle_inventory_mode()
	inventory_interface.visible = not inventory_interface.visible
	
	var is_external_inventory_open = inventory_interface.is_external_inventory_open()
	
	if external_inventory_owner or is_external_inventory_open:
		if is_external_inventory_open == false:
			inventory_interface.visible = true
			inventory_interface.set_external_inventory(external_inventory_owner)
		else:
			inventory_interface.visible = false
			inventory_interface.clear_external_inventory()


func on_toggle_build_mode():
	if not (GameManager.is_normal_mode() or GameManager.is_build_mode()):
		return
		
	GameManager.toggle_build_mode()
	build_mode_interface.visible = not build_mode_interface.visible


func on_drop_slot_data(slot_data: SlotData):
	if slot_data.item_data.placeable_scene != null:
		var scene = slot_data.item_data.placeable_scene.instantiate()
		add_child(scene)
		scene.global_position = stone_buddy.global_position
		Signals.toggle_inventory.emit(null)
