extends Area2D



func on_taken(body):
	if(body.get_name() == "player"):
		get_node("AnimatedSprite").play("gone")
		yield(get_tree().create_timer(0.6),"timeout")
		queue_free()
