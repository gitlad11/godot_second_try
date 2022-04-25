extends KinematicBody2D

var flying = false
var in_range = false
export (int) var speed = 240
var direction = "right"

var velocity = Vector2()

func on_flying(direct):
	direction == direct
	flying = true
	
func movement():
	velocity = Vector2()
	print(direction)
	if(direction == "left"):
		velocity.x -= speed
		get_node("Sprite").set_flip_h( true )
	else:
		velocity.x += speed	
		get_node("Sprite").set_flip_h( false )
	
func _physics_process(delta):
	if(flying):
		movement()
		velocity = move_and_slide(velocity)	
