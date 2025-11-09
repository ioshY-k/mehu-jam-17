extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("banana slices is interacted with")
	match GlobalStates.inventory_object_name:
		"bread":
			GlobalStates.empty_inventory()
			$"../../CreditsCanvasLayer/CheckList/ChackemarkBread".show()
			$"../../BananaBread".position = $"../../PlayerCharacter".position
			get_parent().queue_free()
	
		_:
			$"../../Default".play()
	GlobalStates.is_interacting = false
