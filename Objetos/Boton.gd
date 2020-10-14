extends Area2D

signal apretado
signal suelto

var colision = 0
var puede_apretar = false
onready var sprite = $AnimatedSprite

# warning-ignore:unused_argument
func _physics_process(delta):
	if puede_apretar:
		if sprite.animation != "Apretado":
			sprite.play("Apretado")
		emit_signal("apretado")
	else:
		if sprite.animation != "Suelto":
			sprite.play("Suelto")
		emit_signal("suelto")


func _ready():
	pass

# warning-ignore:unused_argument
func _on_Boton_body_entered(body):
	colision += 1
	if colision == 1:
		puede_apretar = true

# warning-ignore:unused_argument
func _on_Boton_body_exited(body):
	colision -= 1
	if colision == 0:
		puede_apretar = false 

	
