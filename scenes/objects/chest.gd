extends StaticBody3D

signal toggle_inventory(external_inventory_owner)

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

@export var inventory_data: InventoryData

var isBodyEntered: bool = false
var isMouseEntered: bool = false
var isChestOpened: bool = false

func _ready():
	$CollisionArea3D.body_entered.connect(on_body_entered)
	$CollisionArea3D.body_exited.connect(on_body_exited)


func on_body_entered(other_body: Node3D):
	print("on_body_entered")
	isBodyEntered = true
	
	
func on_body_exited(other_body: Node3D):
	print("on_body_exited")
	isBodyEntered = false
	if isChestOpened:
		isChestOpened = false
		animationPlayer.play("close")
		player_interact()
		

func _on_input_event(camera, event, position, normal, shape_idx):
	if (event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT) and isMouseEntered and isBodyEntered:
		if isChestOpened:
			isChestOpened = false
			animationPlayer.play("close")
		else:
			isChestOpened = true
			animationPlayer.play("open")
		
		player_interact()
		

func _on_mouse_entered():
	print("on_mouse_entered")
	isMouseEntered = true
		

func _on_mouse_exited():
	print("on_mouse_exited")
	isMouseEntered = false
	
	
func player_interact():
	toggle_inventory.emit(self)
