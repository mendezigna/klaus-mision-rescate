extends Area2D

signal apretado

var puede_apretar = false
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	if puede_apretar:
		if sprite.animation != "Apretado":
			sprite.play("Apretado")
		emit_signal("apretado")
	else:
		if sprite.animation != "Suelto":
			sprite.play("Suelto")


func _ready():
	pass

func _on_Boton_body_entered(body):
	puede_apretar = true


func _on_Boton_body_exited(body):
	puede_apretar = false 
	
