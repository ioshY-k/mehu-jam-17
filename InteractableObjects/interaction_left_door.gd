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
					GlobalStates.dynamite_is_lit = false
					play("lit_dynamite_interaction")
					await animation_finished
					play("explode_open")
					open = true
				else:
					print("candle want lit dialogue")
			"match":
				play("match_interaction")
		
	GlobalStates.is_interacting = false
