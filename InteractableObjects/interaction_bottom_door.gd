extends AnimatedSprite2D

var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("bottom door is interacted with")
	interactable.switch_room(Consts.DIRECTIONS.DOWN)
				
		
	GlobalStates.is_interacting = false
