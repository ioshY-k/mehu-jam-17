extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("banana slices is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			play("default_interaction")
		"bread":
			$"../../BananaBread".position = $"../../PlayerCharacter".position
	
	GlobalStates.is_interacting = false
