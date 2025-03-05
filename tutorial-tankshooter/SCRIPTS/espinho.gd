extends PathFollow2D

@export var dir = 1
@export var velocidade = 300

var movimento = true

func _ready() -> void:
	pass 



func _process(delta: float) -> void:
	var mov = dir * velocidade
	if movimento:
		progress += mov * delta
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		print("colisao")
		movimento = false
		$AnimationPlayer.play("interacao")
		await get_tree().create_timer(1).timeout
		dir = dir * -1
		movimento = true
		
	pass # Replace with function body.
