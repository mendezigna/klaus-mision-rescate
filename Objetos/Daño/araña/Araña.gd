extends "res://Objetos/Daño/Daño.gd"

var vel = 1
export var gravedadY = -1.1
export var gravedadX = 0

func _process(delta):
		position.y -= gravedadY * vel * delta
		position.x -= gravedadX * vel * delta
		vel = min(vel+3,80)

func _on_body_entered(body):
	if(not body.is_in_group("player")):
		gravedadY = gravedadY * -1
		gravedadX = gravedadX * -1
#		$Sprite.flip_h = not $Sprite.flip_h
	else:
		gravedadY = 0
		gravedadX = 0
		
