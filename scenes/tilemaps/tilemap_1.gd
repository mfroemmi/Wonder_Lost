@tool
extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Test")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position += Vector3(0, 0, 0.002)
	rotate(Vector3(0, 1, 0), delta)
