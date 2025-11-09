extends AnimatedSprite2D

var open = false
var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("left door is interacted with")
	if open:
		interactable.switch_room(Consts.DIRECTIONS.LEFT)
	else:
		match GlobalStates.inventory_object_name:
			"":
				play("noItem_interaction")
			"dynamite":
				if GlobalStates.dynamite_is_lit:
					GlobalStates.empty_inventory()
					$"../../Deatheffect".queue_free()
					$"../../InteractableMatch/BombInPocket".stop()
					GlobalStates.dynamite_is_lit = false
					$"../EatNoise".play()
					await $"../EatNoise".finished
					play("explode_open")
					open = true
					$"../../CreditsCanvasLayer/CheckList/ChackemarkMonkey".show()
				else:
					$"../LightCandles".play()
					$"../../UICanvasLayer/TalkingGorilla".play("talk")
			"match":
				play("match_interaction")
				interactable.no_longer_interactable()
				GlobalStates.empty_inventory()
				$"../../CreditsCanvasLayer/CheckList/ChackemarkMonkey".show()
			"banana":
				GlobalStates.empty_inventory()
				$"../EatNoise".play()
				interactable.no_longer_interactable()
				$"../../CreditsCanvasLayer/CheckList/ChackemarkMonkey".show()
			"banana bomb":
				if GlobalStates.banana_bomb_is_lit:
					GlobalStates.empty_inventory()
					$"../../Deatheffect".queue_free()
					$"../../InteractableMatch/BombInPocket".stop()
					GlobalStates.banana_bomb_is_lit = false
					$"../EatNoise".play()
					await $"../EatNoise".finished
					play("explode_open")
					open = true
					$"../../CreditsCanvasLayer/CheckList/ChackemarkMonkey".show()
				else:
					$"../LightCandles".play()
					$"../../UICanvasLayer/TalkingGorilla".play("talk")
			_:
				$"../../Default".play()
		
	GlobalStates.is_interacting = false
