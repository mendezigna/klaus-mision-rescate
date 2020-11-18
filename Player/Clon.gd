extends KinematicBody2D

var velocity = Vector2()

export var run_speed = 50
export var jump_speed = -50
export var gravity = 100
onready var sprite = $AnimatedSprite
var activo = true
var estaVivo = true
var jumping = false	

func get_input():
	if estaVivo:
		var right = Input.is_action_pressed('ui_right')
		var left = Input.is_action_pressed('ui_left')
		var jump = Input.is_action_just_pressed('ui_up')
		
		if right:
			velocity.x += run_speed
			if is_on_floor():
				sprite.play("walk")
				sprite.offset.y = 0
				sprite.offset.x = 0
			sprite.set_flip_h(false)
		if left:
			velocity.x -= run_speed
			if is_on_floor():
				sprite.play("walk")
				sprite.offset.y = 0
				sprite.offset.x = 0
			sprite.set_flip_h(true)
		if is_on_floor() and jump:
			velocity.y = jump_speed
			sprite.play("jump")
			jumping = true
			if!sprite.flip_h:
				sprite.offset.x = 8
			else:
				sprite.offset.x = -14
			sprite.offset.y = 0
		if is_on_floor() and not left and not right and not jump:
			if!sprite.flip_h:
				sprite.offset.x = 0
			else:
				sprite.offset.x = -6
			sprite.offset.y = 0
			sprite.play("stop")

func morir():
	$Aparicion.show()
	$Aparicion.play("dead")
	sprite.hide()
	estaVivo = false
	$CollisionShape2D.set_deferred("disabled", true)

	$Muerte.start()

func desactivar():
	activo = false
	if!sprite.flip_h:
		sprite.offset.x = 0
	else:
		sprite.offset.x = -6
	sprite.offset.y = 0
	sprite.play("stop")

func activar():
	activo = true
	

func _physics_process(delta):
	velocity.x = 0
	var snap = 3

	if activo:
		get_input()
		if velocity.y != 0:
			snap = Vector2(0,0)

# warning-ignore:return_value_discarded
		if estaVivo:
			move_and_slide_with_snap(velocity, Vector2.DOWN * snap, Vector2(0, -1), false)

	if is_on_floor():
		velocity.y = 0 
		if jumping:
			jumping = false
	else:
		velocity.y += gravity * delta

	if is_on_ceiling():
		velocity.y = 0 
	
	if estaVivo and velocity.y > 0 :
		sprite.play("land")
		if velocity.x > 0 or !sprite.flip_h:
			sprite.offset.x = 0
		elif velocity.x < 0 or sprite.flip_h:
			sprite.offset.x = -6
		sprite.offset.y = -22

func cambiarColor(color):
	modulate = color

func _on_Muerte_timeout():
	queue_free()
	
func _ready():
	$Aparicion.play("aparecer")
	if get_node("/root/Global").test:
		$Light2D.enabled = false


func _on_Aparicion_animation_finished():
	$Aparicion.hide()
