extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("pond is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			print("no bait dialog")
		"key":
			GlobalStates.empty_inventory()
			play("key_interaction")
		"glasses":
			GlobalStates.empty_inventory()
			play("glasses_interaction")
			GlobalStates.create_inventory_object("read")
		"read":
			GlobalStates.empty_inventory()
			play("read_interaction")
			GlobalStates.create_inventory_object("glasses")
		"b":
			GlobalStates.empty_inventory()
			play("b_interaction")
		
	GlobalStates.is_interacting = false
