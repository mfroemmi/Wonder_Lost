extends Node

# Inventory
@warning_ignore("unused_signal")
signal toggle_inventory(external_inventory_owner)
@warning_ignore("unused_signal")
signal drop_slot_data(slot_data: SlotData)

# Build-Mode and Object-Placement
@warning_ignore("unused_signal")
signal toggle_build_mode()
@warning_ignore("unused_signal")
signal place_object_slot_data(object_slot_data: ObjectSlotData)
@warning_ignore("unused_signal")
signal toggle_object_placement_mode(object_slot_data: ObjectSlotData)
@warning_ignore("unused_signal")
signal object_is_placed(object_data: ObjectData)
