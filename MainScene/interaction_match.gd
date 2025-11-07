extends Sprite2D

func execute_interaction():
	print("match is interacted with")
	get_parent().pick_up(get_parent().obj_name)
	GlobalStates.is_interacting = false
