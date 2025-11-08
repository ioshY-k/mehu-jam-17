extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("knive is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			interactable.pick_up(interactable.obj_name)
		"banana":
			GlobalStates.empty_inventory()
			GlobalStates.create_inventory_object("key")
			get_parent().queue_free()
			
		
	GlobalStates.is_interacting = false
