extends AnimatedSprite2D

var open = false
var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("top door is interacted with")
	if open:
		interactable.switch_room(Consts.DIRECTIONS.UP)
		
	GlobalStates.is_interacting = false
