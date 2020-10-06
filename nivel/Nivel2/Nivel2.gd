extends Node2D

onready var plataforma1 = $plataforma1/Plataforma
onready var plataforma2 = $plataforma2/Plataforma


func _on_Boton_apretado():
	plataforma1.apply_central_impulse(Vector2(0, -3))


func _on_Boton2_apretado():
	plataforma2.apply_central_impulse(Vector2(0, -30))


func _on_game_over():
	$TimerDead.start()
	$Player.murio()
	

func _on_TimerDead_timeout():
	get_tree().reload_current_scene()
