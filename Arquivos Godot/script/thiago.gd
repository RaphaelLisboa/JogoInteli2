extends KinematicBody2D

var speed = Vector2.ZERO
var jump = 0
var normal = Vector2(0, -1)
#var count = 0
var direcao_player = 1

func move():
	if Input.is_action_pressed("ui_right"):
		speed.x = 400
		direcao_player = 1
		print(direcao_player)
		get_node("Sprite").set_flip_h(false)
		if is_on_floor():
			get_node("Sprite/AnimationPlayer").play("correr")
		else:
			get_node("Sprite/AnimationPlayer").play("RESET")
	elif Input.is_action_pressed("ui_left"):
		speed.x = -400
		direcao_player = 0
		print(direcao_player)
		get_node("Sprite").set_flip_h(true)
		if is_on_floor():
			get_node("Sprite/AnimationPlayer").play("correr")
		else:
			get_node("Sprite/AnimationPlayer").play("RESET")
	elif Input.is_action_pressed("ui_cima"):
		direcao_player = 2
		print(direcao_player)
	elif Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_cima"):
		direcao_player = 3
		print(direcao_player)
	elif Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_cima"):
		direcao_player = 4
		print(direcao_player)
	else:
		speed.x = 0
		get_node("Sprite/AnimationPlayer").play("RESET")
		
func jump():
	if Input.is_action_just_pressed("ui_up"):
#		count += 1
		speed.y = -400
		
func shoot():
	var chama_a_bala = preload("res://scenes/Bullet.tscn")
	var bala = chama_a_bala.instance()
	bala.pega_direcao(direcao_player)
	bala.position.y = self.position.y
	
	if direcao_player == 1:
		bala.position.x = self.position.x + 110
	elif direcao_player == 0:
		bala.position.x = self.position.x - 110
	else:
		bala.position.x = self.position.x
		bala.position.y = self.position.y - 100
	get_parent().add_child(bala)

func _physics_process(delta):
	
	speed.y += 20
	
	move()
	
	if Input.is_action_just_pressed("ui_shoot"):
		self.shoot()
	
	jump ()
	
	move_and_slide(speed, normal)
	
	if is_on_floor():
#		count = 0
		speed.y = 0
