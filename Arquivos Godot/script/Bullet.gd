extends KinematicBody2D

var speed = 900
var direcao_bala = 0

var sentido_x = -1
var sentido_y = 0

func pega_direcao(dir):
	self.direcao_bala = dir

func _physics_process(delta):
	if(direcao_bala == 0):
		sentido_x = -1
		sentido_y = -1
		$Sprite.flip_h = true
	elif(direcao_bala == 1):
		sentido_x = 1
		sentido_y = 0
		$Sprite.flip_h = false
	elif(direcao_bala == 2):
		sentido_x = 0
		sentido_y = -1
	elif(direcao_bala == 3):
		sentido_x = 1
		sentido_y = -1
	else:
		sentido_x = -1
		sentido_y = -1

	var info = move_and_collide(Vector2(sentido_x, sentido_y)*speed*delta)
	
	if info and info.collider.is_in_group("minion"):
		info.collider.queue_free()
		self.queue_free()
	elif info && !info.collider.is_in_group("minion"):
		self.queue_free()


func _on_Notifier_screen_exited():
	self.queue_free()
