extends "res://Objetos/Daño/Daño.gd"

var vel = 1
export var gravedadX = -1.1

func _process(delta):
		position.x += gravedadX * vel * delta
		vel = min(vel+3,80)

func _on_body_entered2(body):
	if(body.is_in_group("paredes")):
		gravedadX = gravedadX * -1
		$Bat.flip_h = not $Bat.flip_h
