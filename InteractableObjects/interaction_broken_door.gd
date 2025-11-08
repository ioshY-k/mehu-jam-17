extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("broken door is interacted with")
	interactable.switch_room(Consts.DIRECTIONS.RIGHT)
				
		
	GlobalStates.is_interacting = false
