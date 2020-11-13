extends "res://Objetos/Daño/Daño.gd"

var Ataque = preload("res://enemy/ataqueBoss.tscn")
var rng = RandomNumberGenerator.new()
var personajePosition 
onready var sprite = $AnimatedSprite
var playerVivo = true
var atacando = false

func _physics_process(delta):
	if playerVivo and !atacando:
		position.x += 0.5
	position.y = personajePosition.y

func personajePosition(position):
	personajePosition = position
	
func playerMurio():
	playerVivo = false
	sprite.play("attack no fire")
	sprite.offset.x = 10
	sprite.offset.y = -25

func _on_Cooldown_timeout():
	if playerVivo:
		sprite.play("attack")
		sprite.offset.x = 20
		sprite.offset.y = -10
		atacando = true

func crearFuego():
	var new_fuego = Ataque.instance()
	rng.randomize()
	new_fuego.start(position.x + 30, rng.randf_range(position.y - 30, position.y + 40))
	get_parent().add_child(new_fuego)

func _on_AnimatedSprite_animation_finished():
	if (sprite.animation == "attack"):
		atacando = false
		crearFuego()
		sprite.play("idle")
		sprite.offset.x = 0
		sprite.offset.y = 0
	if (sprite.animation == "attack no fire"):
		sprite.play("idle")
		sprite.offset.x = 0
		sprite.offset.y = 0
