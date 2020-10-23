extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var interface = $Perdiste/GameOver
onready var interfaceLabel = $Perdiste/GameOver/GameOver
onready var interfaceTimer = $Perdiste/GameOver/MostrarReloj
onready var playAgain = $Perdiste/GameOver/Button

##Moviemiento
var velocity = Vector2()
export var run_speed = 50
export var jump_speed = -50
export var gravity = 98

##Crear clones
var Clon = preload("res://Player/clon.tscn")
var colors = ["fffffb00", "ffd74b4b", "ff4f7ddf", "ffb76fd8"]
var new_clon
var jumping = false
var clones = []
var cantLimite = 0
var count = 0

##Para cambiar al player de nuevo
var activo = true

##Para saber que esta vivo
var estaVivo = true

func _ready():
	interface.hide()

##Se limita la cantidad de clones
func setCantLimiteClones(numero):
	cantLimite = numero
	setLabelText()

##
func setLabelText():
	$CanvasLayer/Label.text = "Restantes: " + str(cantLimite - clones.size())


func get_input():
	if (estaVivo):
		var right = Input.is_action_pressed('ui_right')
		var left = Input.is_action_pressed('ui_left')
		var jump = Input.is_action_just_pressed('ui_up')

		if right:
			velocity.x += run_speed
			if is_on_floor():
				sprite.play("walk")
			sprite.set_flip_h(false)
		if left:
			velocity.x -= run_speed
			if is_on_floor():
				sprite.play("walk")
			sprite.set_flip_h(true)
		if is_on_floor() and jump:
			velocity.y = jump_speed
			jumping = true
			sprite.play("jump")
		if is_on_floor() and not left and not right and not jump:
			sprite.play("stop")

func desactivar():
	activo = false
	sprite.play("stop")

func activar():
	activo = true

func remove_clon(clon):
	if clon == new_clon:
		new_clon = null
	colors.append(clon.modulate.to_html())
	clones.erase(clon)
	clon.morir()
	setLabelText()
	activar()

func agregarClon():
	if clones.size() > 0 && new_clon != null:
		new_clon.desactivar()
	new_clon = Clon.instance()
	new_clon.cambiarColor(colors.pop_front())
	clones.append(new_clon)
	get_parent().add_child(new_clon)
	new_clon.position = $PosicionClon.global_position
	desactivar()
	new_clon.activar()
	setLabelText()

func remover_clones():
	for clon in get_tree().get_nodes_in_group("clon"):
		clon.desactivar()
		remove_clon(clon)

func _physics_process(delta):
	velocity.x = 0
	var snap = 3

	if activo:
		get_input()

	if velocity.y != 0:
		snap = Vector2(0,0)
		if estaVivo:
			sprite.play("jump")
	elif velocity.x == 0 and estaVivo:
		sprite.play("stop")

# warning-ignore:return_value_discarded
	move_and_slide_with_snap(velocity, Vector2.DOWN * snap, Vector2(0, -1), false)

	if is_on_floor():
		velocity.y = 0
		if jumping:
			jumping = false
			$CPUParticles2D.emitting = true 
	else:
		velocity.y += gravity * delta

	if is_on_ceiling():
		velocity.y = 0 
		

	if Input.is_action_just_pressed("clonar") and clones.size() < cantLimite:
		agregarClon()
	 
	if Input.is_action_just_pressed("interactuar") and clones.size() > 0:
		activar()
		if new_clon != null:
			new_clon.desactivar()
	
	if Input.is_action_just_pressed("reiniciar_clones") and clones.size() > 0:
		remover_clones()
	interfaceTimer.text = "Revivir en: " + str((ceil(get_tree().get_nodes_in_group("time")[0].get_time_left())))



func morir():
	sprite.play("dead")
	estaVivo = false
	remover_clones()
	interface.show()
	playAgain.hide()
	pararMusica()
	$AudioMuerte.play()
	
func win():
	interfaceLabel.text = "YOU WIN!!"
	interface.show()
	desactivar()
	interfaceTimer.hide()
	pararMusica()
	
func pararMusica():
	$AudioFondo.stop()

