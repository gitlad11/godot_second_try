extends KinematicBody2D

var flying = false
var in_range = false
export (int) var speed = 340
var direction = "left"

var velocity = Vector2()

func on_flying(direct):
	direction = direct
	flying = true
	
func movement():
	velocity = Vector2()
	if(direction == "left"):
		velocity.x -= speed
		get_node("Sprite").set_flip_h( true )
	elif(direction == "up"):
		velocity.y -= speed
	elif(direction == "down"):
		velocity.y += speed
	else:
		velocity.x += speed	
		get_node("Sprite").set_flip_h( false )

func on_arrow_stop():
	queue_free()
	
func _physics_process(delta):
	if(flying):
		movement()
		velocity = move_and_slide(velocity)	
