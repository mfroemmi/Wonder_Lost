extends Node3D

@onready var character = $Entities/Characters/StoneBuddy
@onready var inventory_interface = $UI/InventoryInterface
@onready var build_mode_interface = $UI/BuildModeInterface
@onready var object_placement_manager = $Manager/ObjectPlacementManager

func _ready():
	Signals.toggle_inventory.connect(func(external_inventory_owner):on_toggle_inventory_interface(external_inventory_owner))
	Signals.toggle_build_mode.connect(on_toggle_build_mode)
	Signals.toggle_object_placement_mode.connect(on_toggle_object_placement_mode)
	
	Signals.drop_slot_data.connect(on_drop_slot_data)
	Signals.place_object_slot_data.connect(on_place_object_slot_data)
	Signals.object_is_placed.connect(on_object_is_placed)
	
	inventory_interface.set_player_inventory_data(character.inventory_data)


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
	
	if GameManager.is_build_mode():
		build_mode_interface.set_build_mode_data(character)


func on_toggle_object_placement_mode(object_slot_data: ObjectSlotData):
	if not (GameManager.is_build_mode() or GameManager.is_object_placement_mode()):
		return
	
	build_mode_interface.visible = false
	GameManager.toggle_object_placement_mode()
	
	if object_slot_data:
		object_placement_manager.set_object_data(object_slot_data)
	else:
		object_placement_manager.clear_object_data()


func on_drop_slot_data(slot_data: SlotData):
	if slot_data.item_data.placeable_scene != null:
		var scene = slot_data.item_data.placeable_scene.instantiate()
		add_child(scene)
		scene.global_position = character.global_position
		Signals.toggle_inventory.emit(null)


func on_place_object_slot_data(object_slot_data: ObjectSlotData):
	Signals.toggle_object_placement_mode.emit(object_slot_data)


func on_object_is_placed(object_data: ObjectData):
	for item_stack in object_data.required_items:
		character.inventory_data.purge_items(item_stack.item, item_stack.amount)
