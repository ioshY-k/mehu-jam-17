class_name Player extends AnimatedSprite2D

@onready var tooltip: Label = $Tooltip

func _ready() -> void:
	SignalBus.player_walk_towards.connect(_on_player_walks_toward)

func _on_player_walks_toward(obj_pos: Vector2):
	var tween = create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", obj_pos, 1)
	await tween.finished
	SignalBus.player_arrived.emit()
