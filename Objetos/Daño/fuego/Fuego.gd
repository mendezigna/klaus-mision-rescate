extends "res://Objetos/Daño/Daño.gd"

export var velocidadAnimacion = 1.0

func _ready():
	$Sprite.set_speed_scale(velocidadAnimacion)
	
	
