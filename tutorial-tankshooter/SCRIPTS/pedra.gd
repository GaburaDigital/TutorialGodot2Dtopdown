extends StaticBody2D

@export var resistencia = 5

func _ready() -> void:
	pass 


func _process(_delta: float) -> void:
	pass



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("ataque"):
		print("atingiu pedra")
		resistencia -= 1
		if resistencia >= 1:
			$AnimationPlayer.play("pancada")
		else:
			$AnimationPlayer.play("destruir")
			await $AnimationPlayer.animation_finished
			print("quebrou pedra")
			queue_free()
	pass # Replace with function body.
