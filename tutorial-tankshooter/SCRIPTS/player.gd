extends CharacterBody2D

@export var velocidade = 300.0

func _physics_process(delta: float) -> void:
	
	var mov_dir = Vector2()
	if Input.is_action_pressed("ui_left"):
		mov_dir.x -= 1
	elif Input.is_action_pressed("ui_right"):
		mov_dir.x += 1
	elif Input.is_action_pressed("ui_up"):
		mov_dir.y -= 1
	elif Input.is_action_pressed("ui_down"):
		mov_dir.y += 1
	
	velocity = mov_dir * velocidade
	
	move_and_collide(velocity * delta)
	
	pass
