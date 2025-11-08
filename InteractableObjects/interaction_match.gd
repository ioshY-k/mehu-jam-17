extends AnimatedSprite2D

var interactable: InteractableBase
@onready var deatheffect: AnimatedSprite2D = $Deatheffect
@onready var animation_player: AnimationPlayer = $Deatheffect/AnimationPlayer


func _ready() -> void:
	interactable = get_parent()

func execute_interaction():
	print("match is interacted with")
	match GlobalStates.inventory_object_name:
		"":
			interactable.pick_up(interactable.obj_name)
		"dynamite":
			print("light dynamite")
			hide()
			GlobalStates.dynamite_is_lit = true
			
			GlobalStates.inventory.get_child(0).play("match_interaction")
			deatheffect.play("deathtimer")
			animation_player.play("deathtimer")
			
			GlobalStates.is_interacting = false

			await animation_player.animation_finished
			if GlobalStates.dynamite_is_lit:
				GlobalStates.reset_globals()
		
		"banana":
			GlobalStates.empty_inventory()
			play("banana_interaction")
			interactable.no_longer_interactable()
		"banana bomb":
			print("light banana bomb")
			hide()
			GlobalStates.banana_bomb_is_lit = true
			
			GlobalStates.inventory.get_child(0).play("match_interaction")
			deatheffect.play("deathtimer")
			animation_player.play("deathtimer")
			
			GlobalStates.is_interacting = false

			await animation_player.animation_finished
			if GlobalStates.banana_bomb_is_lit:
				GlobalStates.reset_globals()
			
		
	GlobalStates.is_interacting = false
