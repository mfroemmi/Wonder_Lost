extends Area3D

class_name CharacterCollisionComponent

signal character_collision(is_character_entered: bool)

var is_character_entered: bool = false
var character: Character = null


func _ready() -> void:
	area_entered.connect(on_area_entered)
	area_exited.connect(on_area_exited)
	

func on_area_entered(other_area: Area3D):
	if other_area.get_parent() is Character:
		print("character entered")
		is_character_entered = true
		character_collision.emit(true)
		character = other_area.get_parent()


func on_area_exited(other_area: Area3D):
	if other_area.get_parent() is Character:
		print("character exited")
		is_character_entered = false
		character_collision.emit(false)
		character = null
