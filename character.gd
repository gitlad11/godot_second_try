extends Node2D


func on_vision(body):
	if(body.position.x < position.x):
		get_node("AnimatedSprite").flip_h = true
	else:
		get_node("AnimatedSprite").flip_h = false

func _on_unvision(body):
	get_node("AnimatedSprite").flip_h = false
