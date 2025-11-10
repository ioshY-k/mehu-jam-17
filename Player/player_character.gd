class_name Player extends AnimatedSprite2D

@onready var tooltip: Label = $Tooltip

@onready var step_sound_1: AudioStreamPlayer = $StepSound1
@onready var step_sound_2: AudioStreamPlayer = $StepSound2
@onready var step_sound_3: AudioStreamPlayer = $StepSound3
@onready var step_sound_4: AudioStreamPlayer = $StepSound4
@onready var step_sound_5: AudioStreamPlayer = $StepSound5
@onready var step_sound_6: AudioStreamPlayer = $StepSound6

var step_sounds: Array[AudioStreamPlayer]

func _ready() -> void:
	step_sounds = [step_sound_1,step_sound_2,step_sound_3,step_sound_4,step_sound_5,step_sound_6]
	SignalBus.player_walk_towards.connect(_on_player_walks_toward)

func _on_player_walks_toward(obj_pos: Vector2):
	play("walk")
	var tween = create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", obj_pos, Consts.player_walk_speed)
	step_sounds[randi()%5].play()
	await tween.finished
	play("default")
	SignalBus.player_arrived.emit()
