extends CanvasLayer


func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()
	GlobalStates.reset_globals()
