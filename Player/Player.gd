extends KinematicBody2D
signal dejoLaPantalla
onready var sprite = $AnimatedSprite

var velocity = Vector2()
##Moviemiento
export var run_speed = 50
export var jump_speed = -50
export var gravity = 100
var dobleSalto = 1

##Crear clones
var Clon = preload("res://Player/clon.tscn")
var new_clon
var clones = []
var cantLimite = 0
var count = 0

##Para cambiar al player de nuevo
var activo = true

##Para saber que esta vivo
var vivo = true

func setCantLimiteClones(numero):
	cantLimite = numero

func get_input():
	if(vivo):
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
		if (dobleSalto > 0) and jump:
			velocity.y = jump_speed
			sprite.play("jump")
			dobleSalto -= 1 
		if is_on_floor():
			dobleSalto = 1
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
	var temp = clon
	get_parent().remove_child(clon)
	temp.queue_free()

func agregarClon():
	if clones.size() > 0:
		new_clon.desactivar()
	new_clon = Clon.instance()
	new_clon.cambiarColor(count%4)
	clones.append(new_clon)
	get_parent().add_child(new_clon)
	print($PosicionClon.global_position)
	new_clon.position = $PosicionClon.global_position
	desactivar()
	new_clon.activar()

func _physics_process(delta):
	velocity.x = 0
	velocity.y += gravity * delta

	if activo:
		get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1), false, 4, PI/4, false)
	
	if Input.is_action_just_pressed("clonar"):
		count +=1
		if clones.size() == cantLimite:
			remove_clon(clones.pop_front())
		agregarClon()
	 

	if Input.is_action_just_pressed("interactuar") and clones.size() > 0:
		activar()
		new_clon.desactivar()

func murio():
	sprite.play("dead")
	vivo = false

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("dejoLaPantalla")
