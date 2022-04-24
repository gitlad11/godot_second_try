extends Area2D

var cute_down = false
var cutting = false
var endurance = 6

func _on_ore(area):
	print(area.get_name())
	if(area.get_name() == "player" and endurance > 0):
		if(endurance == 1):
			pass
		elif(!cutting):
			cutting = true
			get_node("damage").play("default")
			yield(get_tree().create_timer(0.6),"timeout")
			get_node("damage").stop()
			cutting = false
		endurance = endurance - 1
