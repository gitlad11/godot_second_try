extends KinematicBody2D

export (bool) var flying_away = false
export (int) var x_velocity = 1
export (int) var y_velocity = 1
var health = 1
var speed = 170
var velocity = Vector2()
var direction = 'left'


func _ready():
	pass # Replace with function body.

	
func movement():
	velocity = Vector2()
	velocity.y -= y_velocity
	if(direction == "left"):
		velocity.x -= x_velocity
		get_node("AnimatedSprite").set_flip_h( true )
	else:
		velocity.x += x_velocity	
	velocity = velocity.normalized() * speed
	

func on_flying(dir):
	direction = dir
	flying_away = true
	

func _physics_process(delta):
	if(flying_away):
		movement()
		velocity = move_and_slide(velocity)	
		
