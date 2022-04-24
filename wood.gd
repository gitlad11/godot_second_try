extends Area2D



func _on_wood(area):
	if(area.get_name() == "player"):
		get_node("woods/AnimatedSprite").play("gone")
		yield(get_tree().create_timer(0.5),"timeout")
		queue_free()
		
