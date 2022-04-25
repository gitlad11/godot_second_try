extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _on_vision(body):
	if(body.get_name() == "player"):
		if(body.position.x > position.x):
			get_node("KinematicBody2D").on_flying("left")
		else:
			get_node("KinematicBody2D").on_flying("right")	
		get_node("KinematicBody2D/AnimatedSprite").play("fly")
		get_node("KinematicBody2D/AnimatedSprite").set_speed_scale(1.2)
		
