extends Area2D

var health = 8
var ticking = false

var health1 = load("res://tiles/assets/bars/health.png")
var health2 = load("res://tiles/assets/bars/health (1).png")
var health3 = load("res://tiles/assets/bars/health (2).png")
var health4 = load("res://tiles/assets/bars/health (3).png")
var health5 = load("res://tiles/assets/bars/health (4).png")
var health6 = load("res://tiles/assets/bars/health (5).png")
var health7 = load("res://tiles/assets/bars/health (6).png")
var health8 = load("res://tiles/assets/bars/health (7).png")
var health9 = load("res://tiles/assets/bars/health (8).png")


func burn_out():
	if(!ticking and health >= -1):
		ticking = true
		yield(get_tree().create_timer(90),"timeout")
		health = health - 1
		ticking = false
		
func _process(delta):
	burn_out()
	var bar
	match(health):
		8:
			bar = health1
		7:
			bar = health2
		6:
			bar = health3	
		5:
			bar = health4
		4:
			bar = health5
		3:
			bar = health6	
		2:
			bar = health7
		1:
			bar = health8
		0:
			bar = health9
		-1:
			queue_free()
			
	get_node("health").set_texture(bar)	
