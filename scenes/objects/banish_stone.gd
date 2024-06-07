extends Node3D

@export var banishFog: FogVolume
@export var banishArea: CharacterBody3D

@export var duration: float = 30.0
var elapsed_time: float = 0.0

func _ready():
	if banishArea == null || banishFog == null:
		return

func _process(delta):
	if banishArea == null || banishFog == null:
		return

	elapsed_time += delta
	var scale_factor = lerp(1.0, 15.0, elapsed_time / duration)
	
	banishFog.scale = Vector3(scale_factor / 2, scale_factor / 2, scale_factor / 2)
	banishArea.scale = Vector3(scale_factor, 1.0, scale_factor)

	if elapsed_time >= duration:
		# Stop the process by removing this function from the _process loop.
		set_process(false)
