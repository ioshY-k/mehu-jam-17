extends AnimatedSprite2D

var open = true
var interactable: InteractableBase
@onready var credit_animation: AnimationPlayer = $"../../CreditsCanvasLayer/CreditAnimation"
@onready var retry_button: Button = $"../../CreditsCanvasLayer/RetryButton"
@onready var credit_music: AudioStreamPlayer = $"../../CreditsCanvasLayer/CreditMusic"
@onready var bg_music: AudioStreamPlayer = $"../../BGMusic"

func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("right door is interacted with")
	if open:
		interactable.switch_room(Consts.DIRECTIONS.RIGHT)
		credit_animation.play("CreditRoll")
		bg_music.stop()
		credit_music.play()
		await credit_animation.animation_finished
		retry_button.show()
		
	GlobalStates.is_interacting = false
