extends Area2D

var cut_down = false
var cutting = false
var endurance = 10

func _process(delta):
	if(endurance == 0 and cut_down == false):
		cut_down = true
		get_node("KinematicBody2D").queue_free()
		get_node("damage").queue_free()
		get_node("ore").visible = true
		get_node("ore").monitoring = true

func _on_ore(area):
	if(area.get_name() == "axe" and endurance > 0):
		if(endurance == 1):
			pass
		elif(!cutting):
			cutting = true
			get_node("damage").play("default")
			yield(get_tree().create_timer(0.6),"timeout")
			get_node("damage").stop()
			cutting = false
		endurance = endurance - 1
