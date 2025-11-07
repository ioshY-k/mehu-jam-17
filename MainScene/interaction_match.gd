extends Sprite2D

func execute_interaction():
	print("match is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			get_parent().pick_up(get_parent().obj_name)
		"dynamite":
			print("light dynamite")
		
	GlobalStates.is_interacting = false
