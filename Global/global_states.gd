extends Node

var dynamite_is_lit: bool = false
var is_interacting: bool = false
var inventory_object_name: String = ""
@onready var inventory: Sprite2D = $"../MainScene/UICanvasLayer/Inventory"

var generatable_objects = {
	"burning_dynamite": "packed_scenes"}

func reset_globals():
	dynamite_is_lit = false
	is_interacting = false
	inventory_object_name = ""
	await get_tree().process_frame
	inventory = $"../MainScene/UICanvasLayer/Inventory"

func empty_inventory():
	inventory_object_name = ""
	inventory.get_child(0).queue_free()

func create_inventory_object(obj_name):
	inventory_object_name = obj_name
	inventory.add_child(generatable_objects[obj_name].instantiate())
