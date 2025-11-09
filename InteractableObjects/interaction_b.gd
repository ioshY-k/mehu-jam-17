extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("banana is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			play("remove_the_b")
			GlobalStates.create_inventory_object("b_letter")
		"glasses":
			$"../../UICanvasLayer/Sunglasses".show()
			GlobalStates.empty_inventory()
		"banana":
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
			$"../b_anana".play()
		"read":
			GlobalStates.empty_inventory()
			$"../b_read".play()
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
			GlobalStates.create_inventory_object("bread")
		
		_:
			$"../../Default".play()
	GlobalStates.is_interacting = false
