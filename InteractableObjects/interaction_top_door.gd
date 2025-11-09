extends AnimatedSprite2D

var open = false
var interactable: InteractableBase

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("top door is interacted with")
	if open:
		interactable.switch_room(Consts.DIRECTIONS.UP)
	else:
		match GlobalStates.inventory_object_name:
			"key":
				open = true
				play("key_interaction")
			_:
				$"../DoorAndKey".play()
				$"../../UICanvasLayer/TalkingGorilla".play("talk")
		
	GlobalStates.is_interacting = false
