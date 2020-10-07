extends "res://Objetos/Daño/Daño.gd"

var vel = 1
var gravedad = -1.1

func _process(delta):
		position.y -= gravedad * vel * delta
		vel += 3

func _on_body_entered2(body):
	gravedad = 0
