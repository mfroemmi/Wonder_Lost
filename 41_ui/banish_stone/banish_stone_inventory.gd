extends PanelContainer
class_name BanishStoneInventory

@export var not_activated_container: VBoxContainer
@export var activated_container: PanelContainer
@export var button: Button

@onready var inventory = $MarginContainer/VBoxContainer/PanelContainer/NotActivatedContainer/Inventory
	
var external_inventory_owner: BanishStone

	
func _ready():
	button.pressed.connect(self._button_pressed)


func get_inventory() -> PanelContainer:
	return inventory


func set_inventory_owner(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	inventory.set_inventory_data(external_inventory_owner.inventory_data)
	
	not_activated_container.visible = not external_inventory_owner.isActivated
	activated_container.visible = external_inventory_owner.isActivated


func clear_inventory_owner(_external_inventory_owner):
	external_inventory_owner = null
	inventory.clear_inventory_data(_external_inventory_owner.inventory_data)


func _button_pressed():
	var gem: bool
	var vase: bool

	for child in inventory.item_grid.get_children():
		if child.item_name == "Gem" and child.item_quantity == 1:
			gem = true
		if child.item_name == "Vase" and child.item_quantity == 2:
			vase = true
	
	if gem and vase:
		not_activated_container.visible = false
		activated_container.visible = true
		external_inventory_owner.activateBanishStone()
