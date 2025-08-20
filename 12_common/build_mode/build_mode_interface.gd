extends Control

@export var general_build_mode_data: BuildModeData

@onready var build_mode: BuildMode = $BuildMode


func set_build_mode_data(character: Character):
	set_placeable_property_for_object_data(character)
	build_mode.set_inventory(general_build_mode_data)
	if not general_build_mode_data.build_mode_interact.is_connected(on_build_mode_interact):
		general_build_mode_data.build_mode_interact.connect(on_build_mode_interact)


func on_build_mode_interact(build_mode_data: BuildModeData, index: int, button: int):
	print(build_mode_data.slot_datas[index].object_data.name)
	Signals.place_object_slot_data.emit(build_mode_data.slot_datas[index])


func set_placeable_property_for_object_data(character: Character):
	var inventory = character.inventory_data
	
	for slot_data in general_build_mode_data.slot_datas:
		var object_data = slot_data.object_data
		var can_place = true

		for req in object_data.required_items:
			var amount_in_inventory = inventory.get_item_count(req.item)
			if amount_in_inventory < req.amount:
				can_place = false
				break

		object_data.placeable = can_place
