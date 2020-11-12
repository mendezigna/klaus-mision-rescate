extends "res://Objetos/Daño/Daño.gd"

var Ataque = preload("res://enemy/ataqueBoss.tscn")
var rng = RandomNumberGenerator.new()
var personajePosition 
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	position.x += 0.5
	position.y = personajePosition.y

func personajePosition(position):
	personajePosition = position

func _on_Cooldown_timeout():
	
	sprite.play("attack")
	sprite.offset.x = 20
	sprite.offset.y = -10

func crearFuego():
	var new_fuego = Ataque.instance()
	rng.randomize()
	new_fuego.start(position.x + 30, rng.randf_range(position.y - 30, position.y + 40))
	get_parent().add_child(new_fuego)

func _on_AnimatedSprite_animation_finished():
	if (sprite.animation == "attack"):
		crearFuego()
		sprite.play("idle")
		sprite.offset.x = 0
		sprite.offset.y = 0
