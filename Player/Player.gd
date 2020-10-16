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
			sprite.play("jump")
		if is_on_floor() and not left and not right and not jump:
			sprite.play("stop")

func desactivar():
	activo = false
	sprite.play("stop")
	$Camera2D.current = false

func activar():
	activo = true
	$Camera2D.current = true

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
	new_clon.modulate = colors.pop_front()
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
	velocity.y += gravity * delta

	if activo:
		get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1), false, 4, PI/4, false)
	
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
	$AudioMuerte.play()
	
func win():
	interfaceLabel.text = "YOU WIN!!"
	interface.show()
	desactivar()
	interfaceTimer.hide()
