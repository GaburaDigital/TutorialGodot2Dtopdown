extends Node2D

const BALA = preload("res://CENAS/bala.tscn")

func criar_bala(vel):
	var b = BALA.instantiate()
	get_tree().root.add_child(b)
	b.global_position = $CANHAO/Marker2D.global_position
	b.rotation = $CANHAO.rotation
	b.velocidade = vel
	pass


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	$CANHAO.look_at(get_global_mouse_position())
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		criar_bala(400)
		pass

	pass
