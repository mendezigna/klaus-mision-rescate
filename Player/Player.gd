extends KinematicBody2D

signal dejoLaPantalla

onready var sprite = $AnimatedSprite

var velocity = Vector2()

export var run_speed = 50
export var jump_speed = -50
export var gravity = 100

var clonado = false
var Clon = preload("res://Player/clon.tscn")
var new_clon
var activo = true
var vivo = true
var dobleSalto = 2

func _ready():
	sprite.play("stop")


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
			dobleSalto = 2
		if is_on_floor() and not left and not right and not jump:
			sprite.play("stop")
		

func desactivar():
	activo = false
	sprite.play("stop")
	$Camera2D.current = false

func activar():
	activo = true
	$Camera2D.current = true

func remove_clon():
	if clonado:
		var temp = new_clon
		get_parent().remove_child(new_clon)
		temp.queue_free()

func _physics_process(delta):
	velocity.x = 0
	velocity.y += gravity * delta

	if activo:
		get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1), false, 4, PI/4, false)
	
	if Input.is_action_just_pressed("clonar"):
		remove_clon()
		new_clon = Clon.instance()
		get_parent().add_child(new_clon)
		new_clon.position = position
		clonado = true
		desactivar()
		new_clon.activar()
		
	if Input.is_action_just_pressed("interactuar") and clonado:
		if activo:
			desactivar()
			new_clon.activar()
		else:
			activar()
			new_clon.desactivar()

func murio():
	sprite.play("dead")
	vivo = false
	


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("dejoLaPantalla")
