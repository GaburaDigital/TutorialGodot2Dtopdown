extends Node2D

var bot_tocado = false
var bot_estado = false
var mover_porta = true

func _ready() -> void:
	pass 



func _process(_delta: float) -> void:
	if mover_porta and bot_tocado and Input.is_action_just_pressed("ui_accept"):
		mover_porta = false
		bot_estado = not bot_estado
		if bot_estado:
			$AnimationPlayer.play("ABRIRporta")
		else:
			$AnimationPlayer.play("fecharPORTA")
		await $AnimationPlayer.animation_finished
		mover_porta = true
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		bot_tocado = true
		pass
	pass 


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		bot_tocado = false
		pass
	pass # Replace with function body.
