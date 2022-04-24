extends AnimatedSprite

export(int) var activity_time = 10;
var animated = false

func animate():
	if(!animated):
		animated = true
		yield(get_tree().create_timer(1),"timeout")
		stop()
		visible = false
		yield(get_tree().create_timer(activity_time),"timeout")
		visible = true
		animated = false
		play("default") 
	
func _process(delta):
	animate()
