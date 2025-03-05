extends Node2D





func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("coletei moeda")
		get_parent().atualizar_pontos(1)
		queue_free()
		pass
	pass # Replace with function body.
