extends Area2D

var dead = false
	

func _on_vision(body):
	if(body.get_name() == "player" && dead == false):
		if(body.position.x > position.x):
			get_node("KinematicBody2D").on_flying("left")
		else:
			get_node("KinematicBody2D").on_flying("right")	
		get_node("KinematicBody2D/AnimatedSprite").play("fly")
		get_node("KinematicBody2D/AnimatedSprite").set_speed_scale(1.2)
		yield(get_tree().create_timer(9),"timeout")
		queue_free()

func death(area):
	if(dead == false):
		if(area.get_name() == "range" || area.get_name() == "sword"):
			dead = true
			get_node("KinematicBody2D/AnimatedSprite").play("death")
			get_node("KinematicBody2D/AnimatedSprite").set_speed_scale(1.4)
			var meat = get_parent().get_node("raw_chicken").duplicate()
			meat.position.x = get_node("KinematicBody2D").position.x
			meat.position.y = get_node("KinematicBody2D").position.y
			meat.visible = true
			meat.monitoring = true
			add_child(meat)
			yield(get_tree().create_timer(0.6),"timeout")
			get_node("KinematicBody2D/AnimatedSprite").queue_free()
