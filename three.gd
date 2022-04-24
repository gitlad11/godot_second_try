extends Area2D

export (int) var endurance = 4
export (int) var woods = 1

func _on_cut_three(area):
	print(get_name())
	print(area.get_name())
	if(area.get_name() == get_name()):
		endurance = endurance - 1
		
func _process(delta):
	if(endurance == 0):
		get_node("Sprite").visible = false
		get_node("Sprite2").visible = true
		get_node("KinematicBody2D").visible = false
