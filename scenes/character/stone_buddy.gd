extends CharacterBody3D

signal toggle_inventory

@export var inventory_data: InventoryData

@onready var skelett: Node3D = $Skelett
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

const SPEED = 5.0


func _unhandled_input(event):
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		animationPlayer.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		animationPlayer.play("idle")
		
	if velocity.length() > 0.2:
		var lookDir = Vector2(velocity.z, velocity.x)
		skelett.rotation.y = lookDir.angle() - PI/2

	move_and_slide()
