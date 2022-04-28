extends Area2D

export (int) var endurance = 6
export (int) var woods = 1

var cutting = false
var cut_down = false

func _on_cut_three(area):
	var index = 2
	if(area.get_name() == get_name()):
		endurance = endurance - 1

			
func _process(delta):
	if(endurance == 0 and cut_down == false):
		cut_down = true
		get_node("Sprite2").visible = true
		get_node("KinematicBody2D").queue_free()
		var wood = get_node("wood")
		wood.visible = true
		wood.monitoring = true
		get_node("Sprite").queue_free()
		get_node("damage").queue_free()


func _on_axe(area):

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


