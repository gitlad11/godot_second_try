extends Area2D


func on_ore(area):
	if(area.get_name() == "player"):
		get_node("AnimatedSprite").play("gone")
		yield(get_tree().create_timer(0.5),"timeout")
		get_parent().queue_free()
		queue_free()
