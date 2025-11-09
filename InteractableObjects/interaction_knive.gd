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
			$"../../CreditsCanvasLayer/CheckList/ChackemarkBanana".show()
			GlobalStates.empty_inventory()
			GlobalStates.create_inventory_object("key")
			$"../KeyInBanana".play()
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
			$"../../InteractableBananaSlices".position = $"../../PlayerCharacter".position
			await $"../KeyInBanana".finished
			get_parent().queue_free()
			
		_:
			$"../../Default".play()
		
	GlobalStates.is_interacting = false
