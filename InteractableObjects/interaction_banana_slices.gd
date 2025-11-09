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
			$"../../CreditsCanvasLayer/CheckList/ChackemarkBread".show()
			$"../../BananaBread".position = $"../../PlayerCharacter".position
			get_parent().queue_free()
	
	GlobalStates.is_interacting = false
