class_name InteractableBase extends Node2D

var hovered: bool = false
@export var is_pickup: bool
@export var obj_name: String

var walk_position: Node2D
var player: Player
var inventory
var image: AnimatedSprite2D
var camera: Camera2D

func _ready():
	image = $Sprite
	inventory = get_tree().get_first_node_in_group("Inventory")
	player = get_tree().get_first_node_in_group("Player")
	camera = get_tree().get_first_node_in_group("Camera")
	walk_position = find_child("WalkPosition")

func _process(_delta: float) -> void:
	if hovered and Input.is_action_just_pressed("Interact") and not GlobalStates.is_interacting:
		GlobalStates.is_interacting = true
		player_walks_towards_obj_pos()

func wobble_effect():
	image.scale = Vector2.ZERO
	var tween = create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	if obj_name == "b":
		tween.tween_property(image, "scale", Vector2(0.5,0.5), 0.3)
	else:
		tween.tween_property(image, "scale", Vector2(1,1), 0.3)

func player_walks_towards_obj_pos():
	SignalBus.player_walk_towards.emit(walk_position.global_position)
	player.tooltip.hide()
	await SignalBus.player_arrived
	image.execute_interaction()

func _on_area_2d_mouse_entered() -> void:
	hovered = true
	player.tooltip.show()
	player.tooltip.global_position = global_position
	var g = global_position
	var gg = player.tooltip.global_position
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
	queue_free()

func no_longer_interactable():
	$Area2D.queue_free()

func switch_room(direction: int):
	var tween = create_tween()
	match direction:
		Consts.DIRECTIONS.UP:
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(player,"position:y", player.position.y-450, Consts.player_walk_speed)
			tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
			tween.tween_property(camera, "position:y", camera.position.y-1080, 1)
		Consts.DIRECTIONS.RIGHT:
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(player,"position:x", player.position.x+900, Consts.player_walk_speed)
			tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
			tween.tween_property(camera, "position:x", camera.position.x+1920, 1)
		Consts.DIRECTIONS.DOWN:
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(player,"position:y", player.position.y+900, Consts.player_walk_speed)
			tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
			tween.tween_property(camera, "position:y", camera.position.y+1080, 1)
		Consts.DIRECTIONS.LEFT:
			tween.set_trans(Tween.TRANS_LINEAR)
			tween.tween_property(player,"position:x", player.position.x-900, Consts.player_walk_speed)
			tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
			tween.tween_property(camera, "position:x", camera.position.x-1920, 1)
