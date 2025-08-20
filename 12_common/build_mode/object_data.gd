extends Resource
class_name ObjectData

@export var name: String = ""
@export_multiline var description: String = ""
@export var scene: PackedScene = null
@export var texture: Texture
@export var required_items: Array[ObjectItemStack] = []
@export var placeable: bool = true
