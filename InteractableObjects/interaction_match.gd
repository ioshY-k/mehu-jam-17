extends Sprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("match is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			interactable.pick_up(interactable.obj_name)
		"dynamite":
			print("light dynamite in hand")
			GlobalStates.inventory_object_name = ""
	
	
		
	GlobalStates.is_interacting = false
