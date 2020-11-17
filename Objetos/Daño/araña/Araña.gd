extends "res://Objetos/Daño/Daño.gd"

var vel = 1
export var gravedadY = -1.1

func _process(delta):
		position.y -= gravedadY * vel * delta
		vel = min(vel+3,80)

func _on_body_entered2(body):
	if(not body.is_in_group("player")):
		gravedadY = gravedadY * -1
		$Spider.flip_v = not $Spider.flip_v
	else:
		gravedadY = 0
		
