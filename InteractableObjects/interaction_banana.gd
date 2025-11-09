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
		"left door":
			GlobalStates.empty_inventory()
			$"../../InteractableLeftDoor/Sprite".play("eat_banana_interaction")
			interactable.no_longer_interactable()
		"dynamite":
			GlobalStates.empty_inventory()
			GlobalStates.create_inventory_object("banana bomb")
			get_parent().queue_free()
		"knive":
			$"../../CreditsCanvasLayer/CheckList/ChackemarkBanana".show()
			GlobalStates.empty_inventory()
			GlobalStates.create_inventory_object("key")
			$"../../InteractableBananaSlices".position = $"../../PlayerCharacter".position
			get_parent().queue_free()
		
	GlobalStates.is_interacting = false
