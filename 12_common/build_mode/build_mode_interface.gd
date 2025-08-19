extends Control

@export var general_build_mode_data: BuildModeData

@onready var build_mode: BuildMode = $BuildMode


func set_build_mode_data():
	build_mode.set_inventory(general_build_mode_data)
	general_build_mode_data.build_mode_interact.connect(on_build_mode_interact)
	

func clear_build_mode_data():
	general_build_mode_data.build_mode_interact.disconnect(on_build_mode_interact)


func on_build_mode_interact(build_mode_data: BuildModeData, index: int, button: int):
	print(build_mode_data.slot_datas[index].object_data.name)
