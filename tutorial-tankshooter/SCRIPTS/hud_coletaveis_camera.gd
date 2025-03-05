extends Node2D


var pontos = 0

func atualizar_pontos(valor):
	pontos += valor
	$HUD/LabelPONTOS.text = str(pontos)
	pass
