extends "res://Objetos/Daño/Daño.gd"

var vel = 1
var gravedad = -1.1

func _process(delta):
		position.y -= gravedad * vel * delta
		vel = min(vel+3,80)

func _on_body_entered2(body):
	if(not body.is_in_group("player")):
		gravedad = gravedad * -1 
		rotation_degrees += 180
	else:
		gravedad = 0
