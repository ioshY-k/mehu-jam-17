extends Sprite2D

var open = true
var interactable: InteractableBase
@onready var credit_animation: AnimationPlayer = $"../../CreditsCanvasLayer/CreditAnimation"
@onready var retry_button: Button = $"../../CreditsCanvasLayer/RetryButton"

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("right door is interacted with")
	if open:
		interactable.switch_room(GlobalStates.DIRECTIONS.RIGHT)
		credit_animation.play("CreditRoll")
		await credit_animation.animation_finished
		retry_button.show()
		
	GlobalStates.is_interacting = false
