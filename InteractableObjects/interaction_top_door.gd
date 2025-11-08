extends Sprite2D

var open = true
var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("top door is interacted with")
	if open:
		interactable.switch_room(GlobalStates.DIRECTIONS.UP)
		
	GlobalStates.is_interacting = false
