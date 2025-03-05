extends Polygon2D

var pode_atacar = true


func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	if pode_atacar:
		if Input.is_action_just_pressed("ui_accept"):
			pode_atacar = false
			$AnimationPlayer.play("ATAQUE")
			await $AnimationPlayer.animation_finished
			pode_atacar = true
	pass
