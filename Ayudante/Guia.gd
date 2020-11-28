extends Area2D

export var texto = ""
export var offsetx = 0
export var fliph = false
onready var sprite = $AnimatedSprite
onready var dialogo = $Dialogo
onready var label = $Label
var termino = false

func setTexto(nuevoTexto):
	texto = nuevoTexto

func _ready():
	sprite.hide()
	dialogo.hide()
	label.hide()
	sprite.offset.x = offsetx
	#$Dialogo.offset.x = offsetx
	dialogo.flip_h = !fliph
	sprite.flip_h=fliph
	#$Label.rect_position.x += offsetx

func _on_Guia_body_entered(body):
	if body.is_in_group("player"):
		sprite.show()
		sprite.play("aparicion")
		termino = false


func desaparecer():
	sprite.play("desaparicion")
	termino = true
	

func _on_AnimatedSprite_animation_finished():
	if termino:
		sprite.hide()
		dialogo.hide()
		label.hide()
	else: 
		sprite.play("quieto")
		dialogo.show()
		label.show()
		label.text = texto 


func _on_Guia_body_exited(body):
	if body.is_in_group("player"):
		desaparecer()
