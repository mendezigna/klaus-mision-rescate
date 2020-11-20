extends KinematicBody2D

onready var sprite = $AnimatedSprite
onready var interface = $Perdiste/GameOver
onready var interfaceLabel = $Perdiste/GameOver/GameOver
onready var interfaceLabelM = $Perdiste/GameOver/Menu
onready var interfaceTimer = $Perdiste/GameOver/MostrarReloj
onready var playAgain = $Perdiste/GameOver/TextureButton
onready var collision = $CollisionShape2D
onready var orbe0 = $Orbe0
##Moviemiento
var velocity = Vector2()
export var run_speed = 50
export var jump_speed = -50
export var gravity = 98
var puedeMoverse = true

##Crear clones
var Clon = preload("res://Player/clon.tscn")
var colors = ["ff3737", "ff4f7ddf", "00ff00", "ffb76fd8"]
var new_clon
var jumping = false
var clones = []
var cantLimite = 0
var count = 0
var index = 0;

##Para cambiar al player de nuevo
var activo = true

var puedeComenzarNivel = true

##Orbe
var orbes = []
var clonesMuertos = 0
var clonesActivos = 0

##Para saber que esta vivo
var estaVivo = true
var algo
func _ready():
	interface.hide()
	orbes = [ orbe0, $Orbe1, $Orbe2, $Orbe3]

##Se limita la cantidad de clones
func setCantLimiteClones(numero):
	cantLimite = numero
	aparecerTodosLosOrbes()
	$AnimationPlayer.play("OrbAnimation")
	if colors.size() > cantLimite:
		colors.pop_back()

func puedeComenzarNivel(valor):
	puedeComenzarNivel = valor
	if(!valor):
		$AnimatedSprite.play("stop")
		$AnimatedSprite.offset.x = 0
		$AnimatedSprite.offset.y = 0
		

func _physics_process(delta):
	if (puedeComenzarNivel):
		velocity.x = 0
		var snap = 3
		siEstaActivo()
		if estaVivo:
			if velocity.y != 0:
				snap = Vector2(0,0)
				caer()
			elif velocity.x == 0 and sprite.animation != "summon" and sprite.animation != "land":
				parar()
			clonar()
			manejarPlayer()
			reiniciarClones()
		# warning-ignore:return_value_discarded
		move_and_slide_with_snap(velocity, Vector2.DOWN * snap, Vector2(0, -1), false)
		siEstaEnElPiso(delta)
		interfaceTimer.text = "Revivir en: " + str((ceil(get_tree().get_nodes_in_group("time")[0].get_time_left())))

func siEstaActivo():
	if activo:
		get_input()

func siEstaEnElPiso(delta):
	if is_on_floor():
		velocity.y = 0
		if jumping and estaVivo:
			sprite.play("land")
			sprite.offset.x = 0
			sprite.offset.y = 0
			jumping = false
			$CPUParticles2D.emitting = true 
	else:
		velocity.y += gravity * delta

func clonar():
	if Input.is_action_just_pressed("clonar") and clones.size() < cantLimite and is_on_floor():
		agregarClon()
		sprite.play("summon")

func manejarPlayer():
	if Input.is_action_just_pressed("interactuar") and clones.size() > 0:
		activar()
		if new_clon != null:
			new_clon.desactivar()

func reiniciarClones():
	if Input.is_action_just_pressed("reiniciar_clones") and clones.size() > 0:
		remover_clones()

func parar():
	sprite.play("stop")
	sprite.offset.x = 0
	sprite.offset.y = 0

func caer():
	if velocity.y > 0 :
		sprite.play("falling")
		if velocity.x > 0 or !sprite.flip_h:
			sprite.offset.x = -2
		elif velocity.x < 0 or sprite.flip_h:
			sprite.offset.x = 2
		sprite.offset.y = 3.5

func seApretoUnaTecla():
	return Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_up")

func get_input():
	if(!puedeMoverse and seApretoUnaTecla()):
		puedeMoverse = true
	if (estaVivo and puedeMoverse):
		var right = Input.is_action_pressed('ui_right')
		var left = Input.is_action_pressed('ui_left')
		var jump = Input.is_action_just_pressed('ui_up')
		
		if right:
			velocity.x += run_speed
			if is_on_floor() and sprite.animation != "land" and sprite.animation != "summon":
				sprite.play("walk")
				sprite.offset.x = -3
				sprite.offset.y = 0
			sprite.set_flip_h(false)
		if left:
			velocity.x -= run_speed
			if is_on_floor() and sprite.animation != "land" and sprite.animation != "summon":
				sprite.play("walk")
				sprite.offset.x = 3
				sprite.offset.y = 0
			sprite.set_flip_h(true)
		if is_on_floor() and jump:
			velocity.y = jump_speed
			jumping = true
			sprite.play("jump")
			sprite.offset.x = 0
			sprite.offset.y = 3
		if is_on_floor() and not left and not right and not jump and sprite.animation != "land" and sprite.animation != "summon":
			sprite.play("stop")
			sprite.offset.x = 0
			sprite.offset.y = 0

func agregarClon():
	if clones.size() > 0 && new_clon != null:
		new_clon.desactivar()
	new_clon = Clon.instance()
	new_clon.cambiarColor(colors.pop_front())
	orbesSegunColorDesaparecer(new_clon)
	##orbes[clones.size()].hide() 
	clones.append(new_clon)
	get_parent().add_child(new_clon)
	new_clon.position = $PosicionClon.global_position
	desactivar()
	new_clon.activar()
	
func orbesSegunColorDesaparecer(clon1):
	if (clon1.modulate.to_html() == "ffff3737"):
		$Orbe0.hide()
	elif  clon1.modulate.to_html() == "ff4f7ddf":
		$Orbe1.hide()
	elif clon1.modulate.to_html() == "ff00ff00":
		$Orbe2.hide()
	else:
		$Orbe3.hide()
		
func desactivar():
	activo = false
	if sprite.animation != "land" and sprite.animation != "summon":
		sprite.play("stop")
		sprite.offset.x = 0
		sprite.offset.y = 0

func remover_clones():
	for clon in get_tree().get_nodes_in_group("clon"):
		clon.desactivar()
		remove_clon(clon)
		aparecerTodosLosOrbes()

func aparecerTodosLosOrbes():
	clonesMuertos = 0
	clonesActivos = 0
	for num in range(cantLimite):
		orbes[num].play("default")
		orbes[num].show()
		
func remove_clon(clon):
	if clon.estaVivo:
		if clon == new_clon:
			new_clon = null
			activar()
		print(clon.modulate)
		colors.append(clon.modulate.to_html())
		orbesSegunColorAparecer(clon)
		clones.erase(clon)
		##orbes[clones.size()].show()
		clon.morir()

func orbesSegunColorAparecer(clon1):
	if (clon1.modulate.to_html() == "ffff3737"):
		$Orbe0.show()
	elif  clon1.modulate.to_html() == "ff4f7ddf":
		$Orbe1.show()
	elif clon1.modulate.to_html() == "ff00ff00":
		$Orbe2.show()
	else:
		$Orbe3.show()
func activar():
	activo = true

func morir():
	if estaVivo:
		sprite.play("dead")
		estaVivo = false
		apagarTodosLosOrbes()
		remover_clones()
		interface.show()
		interfaceLabelM.hide()
		playAgain.hide()
		pararMusica()
		$AudioMuerte.play()

func apagarTodosLosOrbes():
	for orbe in orbes:
		orbe.hide()

func win():
	interfaceLabel.text = "Ganaste!!"
	interface.show()
	desactivar()
	interfaceTimer.hide()
	pararMusica()
	
func pararMusica():
	get_node("/root/Global").desactivarMusica()

func _on_AnimatedSprite_animation_finished():
	if sprite.animation != "dead" and sprite.animation != "walk" and sprite.animation != "jump" and sprite.animation != "falling":
		sprite.play("stop")
		sprite.offset.x = 0
		sprite.offset.y = 0
	sprite.stop()


