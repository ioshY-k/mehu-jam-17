extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("pond is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			$"../NeedBait".play()
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
		"key":
			GlobalStates.empty_inventory()
			play("key_interaction")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
			$"../../PlayerCharacter".play("fishing")
			await $"../../PlayerCharacter".animation_finished
			$"../../Fishing1".show()
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
			$"../CaughtSomething".play()
		"glasses":
			GlobalStates.empty_inventory()
			play("glasses_interaction")
			GlobalStates.create_inventory_object("read")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkRead".show()
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
			$"../../PlayerCharacter".play("fishing")
			await $"../../PlayerCharacter".animation_finished
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
			$"../CaughtSomething".play()
		"read":
			GlobalStates.empty_inventory()
			play("read_interaction")
			GlobalStates.create_inventory_object("glasses")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
			$"../../PlayerCharacter".play("fishing")
			await $"../../PlayerCharacter".animation_finished
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
			$"../CaughtSomething".play()
		"b_letter":
			GlobalStates.empty_inventory()
			play("b_interaction")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
			$"../../PlayerCharacter".play("fishing")
			await $"../../PlayerCharacter".animation_finished
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
			$"../CaughtSomething".play()
			$"../../Fishing2".show()
		"banana":
			GlobalStates.empty_inventory()
			play("banana_interaction")
			$"../../CreditsCanvasLayer/CheckList/ChackemarkFish".show()
			$"../../PlayerCharacter".play("fishing")
			$"../../UICanvasLayer/TalkingGorilla".play("talk")
			$"../CaughtSomething".play()
			$"../../Fishing3".show()
		_:
			$"../../Default".play()
	GlobalStates.is_interacting = false
