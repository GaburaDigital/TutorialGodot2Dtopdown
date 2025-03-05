extends Node2D

var velocidade = 600


func _ready() -> void:
	print("criou bala")
	pass 

func _process(delta: float) -> void:
	position += transform.x * velocidade * delta 
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("bala saiu")
	queue_free()
	pass # Replace with function body.
