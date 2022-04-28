extends Area2D

signal on_leaf


func _on_leaf(area):
	if(area.get_name() == "player"):
		get_node("leaf").play("gone")
		yield(get_tree().create_timer(0.5),"timeout")
		get_parent().queue_free()
		queue_free()
		
		
		
