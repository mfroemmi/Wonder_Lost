extends PanelContainer

class_name BuildMode


@onready var inventory = $MarginContainer/VBoxContainer/PanelContainer/BuildModeInventory


func set_inventory(build_mode_data: BuildModeData):
	inventory.set_inventory_data(build_mode_data)
