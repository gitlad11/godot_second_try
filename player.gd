extends KinematicBody2D

export (int) var speed = 160

var velocity = Vector2()
var running = false
var double_hit = false
var hiting = false
var direction = "left"
export (float) var attack_speed = 0.6
export (String) var current_weapon = "sword"

export (int) var wood = 0
export (int) var stone = 0
export (int) var leaves = 0
export (int) var rope = 0

var hunger = 100
var health = 4
var get_hunger = false

var outlined = 0

var hunger1 =  preload("res://tiles/assets/bars/hunger (1).png")
var hunger2 = preload("res://tiles/assets/bars/hunger (5).png")
var hunger3 = preload("res://tiles/assets/bars/hunger (4).png")
var hunger4 = preload("res://tiles/assets/bars/hunger (3).png")
var hunger5 = preload("res://tiles/assets/bars/hunger (2).png")

var health1 =  preload("res://tiles/assets/bars/health (2).png")
var health2 = preload("res://tiles/assets/bars/health (1).png")
var health3 = preload("res://tiles/assets/bars/health (4).png")
var health4 = preload("res://tiles/assets/bars/health (3).png")


var axe = preload("res://tiles/assets/axe.png")
var showel = preload("res://tiles/assets/showel.png")
var sword = preload("res://tiles/assets/sword.png")
var pickaxe = preload("res://tiles/assets/chopper.png")

var current_items = [
	{"name" : "axe", "link" : 'res://tiles/assets/axe.png'},
	{"name" : "bow", "link" : 'res://tiles/assets/bow.png'},
	{"name" : "pickaxe", "link" : 'res://tiles/assets/sword.png'},
]

var hot_items = [
	{"name" : "sword", "link" : 'res://tiles/assets/sword.png'},
	{"name" : "bow", "link" : 'res://tiles/assets/bow.png'},
	{"name" : "axe", "link" : 'res://tiles/assets/axe.png'},
	{"name" : "pickaxe", "link" : 'res://tiles/assets/chopper.png'},
]

var inventory = [
	{"name" : "cherry", "link" : "res://tiles/assets/Food_0.png", "damage" : '', "food" : '10', "count" : 3}
]

var about = [
	{"name" : 'Sword',"label" : 'Sword', "damage" : "10", "food" : '', "level" : '1'},
	{ "name" : 'Bow', "label" : "Bow" , "damage" : "8", "food" : '', "level" : '1'},
	{ "name" : 'Axe', "label" : "Axe", "level" : '1' , "food" : '', "damage" : ''},
	{ "name" : 'Pickaxe', "label" : "Pickaxe", "level" : '1', "food" : '', "damage" : ''},
	{"name" : "cherry", "label" : "a little breakfast, can be used in cooking and alchemy", "food" : "10", "damage" : ''},
	{"name" : "bread", "label" : "meal that eveyone knows, can be used as bite for animals", "food" : "10", "damage" : ''},
	{"name" : "hay", "label" : "usual plant on the fields, can be used in cooking and alchemy", "food" : "0", "damage" : ''},
	{"name" : "raw pork", "label" : "meat, not so healthy if it's raw, can be used in cooking and as bite for animals", "food" : "20", "damage" : ''},
	{"name" : "raw chicken", "label" : "meat, not so healthy if it's raw, can be used in cooking and as bite for animals", "food" : "20", "damage" : ''},
	{"name" : "blueberries", "label" : "a little breakfast, can be used in cooking and alchemy", "food" : "10", "damage" : ''},
	{"name" : "orange", "label" : "orange, round and tasty, can be used in cooking", "food" : '10', "damage" : ''},
	{"name" : "wood", "label" : "very important resource, can be used in building", "food" : '', "damage" : ''},
	{"name" : "stone", "label" : "important thing to make tools, can be used in building", "food" : '', "damage" : ''},
	{"name" : "leaf", "label" : "ropes, ropes, ropes, can be used in building", "food" : '', "damage" : ''},
	
]



func _ready():
	var index = 0
	for value in hot_items:
		index = index + 1
		var item = load(value['link'])
		get_node("Camera2D/Control/inventar/TextureRect/hot" + str(index)).set_normal_texture(item)
		
	
func on_inventar():
	var inventar = get_node("Camera2D/Control/inventar")
	var index = 0
	for value in inventory:
		index = index + 1
		var item = load(value['link'])
		get_node("Camera2D/Control/inventar/TextureRect/item" + str(index)).set_normal_texture(item)
		if(value['count'] > 1):
			get_node("Camera2D/Control/inventar/TextureRect/item" +str(index) + "/count").text = str(value['count'])
		
	if(inventar.visible):
		inventar.visible = false
	else:
		inventar.visible = true	
			
func hungry():
	if(hunger >= 0 && !get_hunger):
		get_hunger = true
		yield(get_tree().create_timer(3),"timeout")
		hunger = hunger - 1
		yield(get_tree().create_timer(1),"timeout")
		if(hunger < 10):
			health = health - 1
		get_hunger = false	

func _process(delta):
	hungry()
	if(hunger > 80):
		get_node("Camera2D/Control/hunger").texture = hunger1
	elif(hunger < 80 && hunger > 50):
		get_node("Camera2D/Control/hunger").texture = hunger2
	elif(hunger < 60 && hunger > 30):
		get_node("Camera2D/Control/hunger").texture = hunger3
	elif(hunger < 30 && hunger > 0):
		get_node("Camera2D/Control/hunger").texture = hunger4
	elif(hunger == 0):
		get_node("Camera2D/Control/hunger").texture = hunger5	
	
	if(health == 4):
		get_node("Camera2D/Control/health").texture = health1
	elif(health == 3):
		get_node("Camera2D/Control/health").texture = health2
	elif(health == 2):
		get_node("Camera2D/Control/health").texture = health3
	elif(health == 1):
		get_node("Camera2D/Control/health").texture = health4				

func attack():
	if(!hiting):
		hiting = true
		if(double_hit):
			get_node("AnimationPlayer").play("attack")
			double_hit = false
		else:
			get_node("AnimationPlayer").play("attack_2")
			double_hit = true
		speed = speed / 2	
		yield(get_tree().create_timer(attack_speed),"timeout")
		get_node("AnimationPlayer").play("idle")
		hiting = false	
		speed = 160

func cut():
	if(!hiting):
		hiting = true 
		
		get_node("AnimationPlayer").play("hit_2")
		speed = speed / 2
		yield(get_tree().create_timer(attack_speed / 2),"timeout")
		get_node("axe").set_monitorable(true)
		get_node("axe").position.y = 0
		yield(get_tree().create_timer(attack_speed / 2),"timeout")
		speed = 160
		get_node("axe").set_monitorable(false)
		get_node("axe").position.y = 150
		get_node("AnimationPlayer").play("idle")
		hiting = false
	
func shoot():
	if(!hiting):
		hiting = true
		get_node("AnimationPlayer").play("bow")
		speed = speed / 2	
		yield(get_tree().create_timer(attack_speed),"timeout")
		get_node("AnimationPlayer").play("idle")
		
		var arrow = preload("res://arrow.tscn").instance()
	
		arrow.on_flying(direction)	
		if(direction == "left"):
			arrow.position.x = position.x - 140
			arrow.position.y = position.y + 120
		elif(direction == "right"):
			arrow.position.x = position.x - 50
			arrow.position.y = position.y + 120		
		elif(direction == "down"):
			arrow.position.x = position.x - 80
			arrow.position.y = position.y + 180	
			arrow.rotation_degrees = -90
		else:
			arrow.position.x = position.x - 80
			arrow.position.y = position.y + 70	
			arrow.rotation_degrees = 90		
		get_tree().get_root().add_child(arrow)	
		speed = 160	
		hiting = false
		
func change_weapon(weapon):
	current_weapon = weapon

func get_input():
	velocity = Vector2()
	
	if Input.is_action_just_pressed("b"):
		on_inventar()
	if Input.is_action_just_pressed("axe"):
		change_weapon("axe")
	if Input.is_action_just_pressed("bow"):
		change_weapon("bow")
	if Input.is_action_just_pressed("sword"):
		change_weapon("sword")		
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		if(!hiting):
			get_node("AnimationPlayer").play("run2")
		get_node("AnimationPlayer").set_flip_h( true )
		get_node("axe").position.x = 50
		get_node("sword").position.x = 50
		direction = "right"

		running = true
		
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		if(!hiting):
			get_node("AnimationPlayer").play("run2")
		get_node("AnimationPlayer").set_flip_h( false )
		get_node("axe").position.x = 0
		get_node("sword").position.x = 0
		direction = "left"

		running = true
		
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		if(!hiting):
			get_node("AnimationPlayer").play("run2")
		direction = "down"	
			
		running = true
		
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		if(!hiting):
			get_node("AnimationPlayer").play("run2")
		
		direction = "up"	
		running = true
	
	if Input.is_action_just_pressed("ui_accept"):
		if current_weapon == "axe":
			cut()
		elif current_weapon == "sword":
			attack()
		elif current_weapon == "bow":
			shoot()		
	
	elif !Input.is_action_pressed("ui_left") and !Input.is_action_pressed("ui_up") and !Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_down"):
		if !hiting:
			get_node("AnimationPlayer").play("idle")
		running = false
			
	velocity = velocity.normalized() * speed
	
func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)	
	
				
func _on_position_above(area):
	if(area.get_name() == get_name()):
		get_node("AnimationPlayer").z_index = 100
		

func _on_position_area_exited(area):
	if(area.get_name() == get_name()):
		get_node("AnimationPlayer").z_index = 10

func on_item_look(index):
	var item = {"name" : '', "label" : '', "damage" : '', "food" : ''}
	var ind = 0
	
	if(index < 10):
		item = about[index]
		get_node("Camera2D/Control/inventar/titles/about").text = item["label"]
	else:
		if(len(inventory) > index - 10):
			var i = inventory[index - 10]
			for value in about:
				if(i['name'] == value['name']):
					item = value
					print(item)
				
	get_node("Camera2D/Control/inventar/titles/about").text = item["label"]				
	if(len(item['damage']) > 0):
		var icon = load("res://tiles/assets/sword.png")
		get_node("Camera2D/Control/inventar/titles/icon").set_texture(icon)
		get_node("Camera2D/Control/inventar/titles/parameter").text = "Damage : " + item['damage']
	elif(len(item['food']) > 0):
		var icon = load("res://tiles/assets/Food_0.png")
		get_node("Camera2D/Control/inventar/titles/icon").set_texture(icon)
		get_node("Camera2D/Control/inventar/titles/parameter").text = "Food : " + item['food']
	else:
		get_node("Camera2D/Control/inventar/titles/icon").set_texture(null)
		get_node("Camera2D/Control/inventar/titles/parameter").text = ""
	if(index < 10):
		get_node("Camera2D/Control/inventar/TextureRect/hot" + str(index + 1) + "/outlined").set_visible(true)
	else:
		get_node("Camera2D/Control/inventar/TextureRect/item" + str(index - 9) + "/outlined").set_visible(true)	
	
	if(outlined < 10):
		if(outlined != index):
			get_node("Camera2D/Control/inventar/TextureRect/hot" + str(outlined + 1) + "/outlined").set_visible(false)
	else:
		if(outlined != index - 9):
			get_node("Camera2D/Control/inventar/TextureRect/item" + str(outlined - 9) + "/outlined").set_visible(false)	
	outlined = index
		
func on_item(body, item):
	var index = 0
	var found = false
	for i in inventory:
		if item == i['name'] and i['count'] < 39:
			var new_item = inventory[index]
			new_item['count'] = new_item['count'] + 1
			inventory.remove(index)
			inventory.insert(index, new_item)
			found = true
		else:
			index = index + 1	
			
	if !found && len(inventory) < 29:
		var new_item;
		if(item == "leaf"):
			new_item = {
				"name" : "leaf", 
				"link" : 'res://tiles/assets/leaf.png', 
				"count" : 1,
				"food" : '', 
				"damage" : ''
				}
		elif(item == 'ore'):
			new_item = {
				"name" : "ore", 
				"link" : 'res://tiles/assets/stone.png', 
				"count" : 1,
				"food" : '', 
				"damage" : ''
				}
		elif(item == "wood"):
			new_item = 	{
				"name" : "wood", 
				"link" : 'res://tiles/assets/wood.png', 
				"count" : 1,
				"food" : '', 
				"damage" : ''
				}
		elif(item == "hay"):
			new_item = 	{
				"name" : "hay", 
				"link" : 'res://tiles/assets/hay.png', 
				"count" : 1,
				"food" : '', 
				"damage" : ''
				}
		elif(item == "orange"):
			new_item = {
				"name" : "orange", 
				"link" : 'res://tiles/assets/Food_30.png', 
				"count" : 1,
				"food" : '10', 
				"damage" : ''
			}						
		inventory.append(new_item)
