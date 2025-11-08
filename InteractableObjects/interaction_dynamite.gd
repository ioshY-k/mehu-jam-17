extends Sprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("dynamite is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			interactable.pick_up(interactable.obj_name)
		"match":
			print("light dynamite")
			GlobalStates.inventory_object_name = ""
		
	GlobalStates.is_interacting = false
