extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("pond is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			print("no bait dialog")
		"key":
			GlobalStates.empty_inventory()
			play("key_interaction")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
		"glasses":
			GlobalStates.empty_inventory()
			play("glasses_interaction")
			GlobalStates.create_inventory_object("read")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkRead".show()
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
		"read":
			GlobalStates.empty_inventory()
			play("read_interaction")
			GlobalStates.create_inventory_object("glasses")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
		"b_letter":
			GlobalStates.empty_inventory()
			play("b_interaction")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
		"banana":
			GlobalStates.empty_inventory()
			play("banana_interaction")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
		
		_:
			$"../../Default".play()
	GlobalStates.is_interacting = false
