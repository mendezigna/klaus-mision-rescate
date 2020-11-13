extends "res://Objetos/Daño/Daño.gd"

func start(positionx, positiony):
	global_position = Vector2(positionx, positiony)

func _physics_process(delta):
	position.x += 1

func _on_Area2D_hit():
	get_parent()._on_game_over()
	
func _on_Area2D_hitClone(clone):
	get_parent()._on_delete_clone(clone)
