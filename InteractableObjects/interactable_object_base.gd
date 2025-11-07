class_name InteractableBase extends Node2D

var hovered: bool = false
@export var is_pickup: bool
@export var obj_name: String

var walk_position: Node2D
var player: Player
var inventory
var image: Sprite2D

func _ready():
	image = $Sprite
	inventory = get_tree().get_first_node_in_group("Inventory")
	player = get_tree().get_first_node_in_group("Player")
	walk_position = find_child("WalkPosition")

func _process(_delta: float) -> void:
	if hovered and Input.is_action_just_pressed("Interact") and not GlobalStates.is_interacting:
		GlobalStates.is_interacting = true
		player_walks_towards_obj_pos()

func wobble_effect():
	image.scale = Vector2.ZERO
	var tween = create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(image, "scale", Vector2(1,1), 0.3)

func player_walks_towards_obj_pos():
	SignalBus.player_walk_towards.emit(walk_position.global_position)
	player.tooltip.hide()
	await SignalBus.player_arrived
	image.execute_interaction()

func _on_area_2d_mouse_entered() -> void:
	hovered = true
	player.tooltip.show()
	if GlobalStates.inventory_object_name == "":
		if is_pickup:
			player.tooltip.text = "Pick up " + obj_name
		else:
			player.tooltip.text = "Interact with " + obj_name
	else:
		if is_pickup:
			player.tooltip.text = "Combine " + GlobalStates.inventory_object_name + " with " + obj_name
		else:
			player.tooltip.text = "Interact with " + obj_name
	wobble_effect()

func _on_area_2d_mouse_exited() -> void:
	hovered = false
	player.tooltip.hide()
	wobble_effect()

func pick_up(obj_name):
	GlobalStates.inventory_object_name = obj_name
	image.get_parent().remove_child(image)
	await get_tree().process_frame
	inventory.add_child(image)
	image.scale = Vector2(8,8)
	queue_free()
