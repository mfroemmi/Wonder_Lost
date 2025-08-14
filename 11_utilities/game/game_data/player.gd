extends Node
class_name Player

var character: CharacterBody3D = null


func get_position() -> Vector3:
	if character:
		return character.global_transform.origin
	return Vector3.ZERO


func init_character(character_body: CharacterBody3D):
	character = character_body
