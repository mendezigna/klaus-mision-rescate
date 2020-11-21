extends Area2D

export var texto = ""
export var offsetx = 0
export var fliph = false
var termino = false

func setTexto(nuevoTexto):
	texto = nuevoTexto

func _ready():
	$AnimatedSprite.hide()
	$Dialogo.hide()
	$Label.hide()
	$AnimatedSprite.offset.x = offsetx
	#$Dialogo.offset.x = offsetx
	$Dialogo.flip_h = !fliph
	$AnimatedSprite.flip_h=fliph
	#$Label.rect_position.x += offsetx

func _on_Guia_body_entered(body):
	if body.is_in_group("player"):
		print("HOLA")
		$AnimatedSprite.show()
		$AnimatedSprite.play("aparicion")
		termino = false


func desaparecer():
	$AnimatedSprite.play("desaparicion")
	termino = true
	

func _on_AnimatedSprite_animation_finished():
	if termino:
		$AnimatedSprite.hide()
		$Dialogo.hide()
		$Label.hide()
	else: 
		$AnimatedSprite.play("quieto")
		$Dialogo.show()
		$Label.show()
		$Label.text = texto 


func _on_Guia_body_exited(body):
	if body.is_in_group("player"):
		desaparecer()
