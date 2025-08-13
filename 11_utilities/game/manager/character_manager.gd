extends Node

var character: Node3D = null


func get_character_position() -> Vector3:
	if character:
		return character.global_transform.origin
	return Vector3.ZERO
