extends Node

var dynamite_is_lit: bool = false
var banana_bomb_is_lit: bool = false
var is_interacting: bool = false
var inventory_object_name: String = ""
@onready var inventory: Sprite2D = $"../MainScene/UICanvasLayer/Inventory"
const INTERACTABLE_OBJECT_BASE = preload("uid://br0v7j8lymtfe")

var generatable_objects = {
	"banana bomb": preload("uid://cb501hcor5vdh"),
	"key": preload("uid://bgneuxavmmchk"),
	"read": preload("uid://cqk18u4xwd4i5"),
	"glasses": preload("uid://b788y1phxckl6"),
	"b_letter": preload("uid://cyegbm0v3al05"),
	"bread": preload("uid://dljufqjyf2h07")}

func reset_globals():
	$"../MainScene".get_tree().reload_current_scene()
	dynamite_is_lit = false
	banana_bomb_is_lit = false
	is_interacting = false
	inventory_object_name = ""
	await get_tree().process_frame
	inventory = get_tree().get_first_node_in_group("Inventory")

func empty_inventory():
	if inventory == null:
		print("null")
		inventory = $"../MainScene/UICanvasLayer/Inventory"
	inventory_object_name = ""
	inventory.get_child(0).queue_free()

func create_inventory_object(obj_name):
	if inventory == null:
		print("null")
		inventory = $"../MainScene/UICanvasLayer/Inventory"
	inventory_object_name = obj_name
	inventory.add_child(generatable_objects[obj_name].instantiate())
