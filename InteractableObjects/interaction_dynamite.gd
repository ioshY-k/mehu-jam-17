extends AnimatedSprite2D

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
			GlobalStates.empty_inventory()
			play("match_interaction")
			await animation_finished
			$"../../InteractableTopDoor/Sprite".play("explode_open")
			$"../../InteractableTopDoor/Sprite".open = true
			print($"../../InteractableTopDoor/Sprite".open)
			get_parent().queue_free()

			
		
	GlobalStates.is_interacting = false
