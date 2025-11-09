extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("glasses is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			interactable.pick_up(interactable.obj_name)
		"b_letter":
			$"../../UICanvasLayer/Sunglasses".show()
			GlobalStates.empty_inventory()
		
		_:
			$"../../Default".play()
	GlobalStates.is_interacting = false
