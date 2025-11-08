extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("banana is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			interactable.pick_up(interactable.obj_name)
		"match":
			GlobalStates.empty_inventory()
			play("match_interaction")
			interactable.no_longer_interactable()
		
	GlobalStates.is_interacting = false
