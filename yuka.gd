extends Area2D

var endurance = 5
var cutting = false
var cut_down = false

func _process(delta):
	if(endurance == 0 and cut_down == false):
		print(endurance)
		cut_down = true
		var leaf = get_node("leaf")
		get_node("Sprite").queue_free()
		get_node("damage").queue_free()
		leaf.visible = true
		leaf.monitoring = true

func _on_yuka(area):
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
