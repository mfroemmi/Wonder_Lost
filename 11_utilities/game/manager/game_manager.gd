extends Node

enum GameMode {
	NORMAL,
	INVENTORY,
	BUILD
}

var allowed_transitions = {
	GameMode.NORMAL: [GameMode.BUILD, GameMode.INVENTORY],
	GameMode.BUILD: [GameMode.NORMAL],
	GameMode.INVENTORY: [GameMode.NORMAL]
}

var current_mode: GameMode = GameMode.NORMAL
var game_data: GameData


func _ready() -> void:
	# Init GameData
	game_data = GameData.new()
	game_data.init_player()


func _unhandled_input(_event):
	if Input.is_action_just_pressed("inventory"):
		Signals.toggle_inventory.emit(null)
		
	if Input.is_action_just_pressed("toggle_build_mode"):
		Signals.toggle_build_mode.emit()


# GameMode
func toggle_build_mode():
	if is_build_mode():
		set_mode(GameMode.NORMAL)
	else:
		set_mode(GameMode.BUILD)


func toggle_inventory_mode():
	if is_inventory_mode():
		set_mode(GameMode.NORMAL)
	else:
		set_mode(GameMode.INVENTORY)
	
	
func set_mode(target_mode: GameMode):
	if target_mode in allowed_transitions[current_mode]:
		current_mode = target_mode
		print("current mode:", current_mode)
	else:
		print("Transition not allowed:", current_mode, "->", target_mode)


func is_build_mode() -> bool:
	return current_mode == GameMode.BUILD


func is_inventory_mode() -> bool:
	return current_mode == GameMode.INVENTORY


func is_normal_mode() -> bool:
	return current_mode == GameMode.NORMAL
	
