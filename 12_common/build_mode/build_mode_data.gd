extends Resource

class_name BuildModeData

signal build_mode_interact(build_mode_data: BuildModeData, index: int, button: int)

@export var slot_datas: Array[ObjectSlotData]


func on_slot_clicked(index: int, button: int):
	build_mode_interact.emit(self, index, button)
