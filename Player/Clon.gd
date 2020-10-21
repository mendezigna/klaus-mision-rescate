extends KinematicBody2D

var velocity = Vector2()

export var run_speed = 50
export var jump_speed = -50
export var gravity = 100
var activo = true
var estaVivo = true

func get_input():
	if estaVivo:
		var right = Input.is_action_pressed('ui_right')
		var left = Input.is_action_pressed('ui_left')
		var jump = Input.is_action_just_pressed('ui_up')
		
		if right:
			velocity.x += run_speed
			if is_on_floor():
				$AnimatedSprite.play("walk")
			$AnimatedSprite.set_flip_h(false)
		if left:
			velocity.x -= run_speed
			if is_on_floor():
				$AnimatedSprite.play("walk")
			$AnimatedSprite.set_flip_h(true)
		if is_on_floor() and jump:
			velocity.y = jump_speed
			$AnimatedSprite.play("jump")
		if is_on_floor() and not left and not right and not jump:
			$AnimatedSprite.play("stop")

func morir():
	$AnimatedSprite.play("disappear")
	estaVivo = false
	$CollisionShape2D.set_deferred("disabled", true)
	$Muerte.start()

func desactivar():
	activo = false
	$AnimatedSprite.play("stop")

func activar():
	activo = true

func _physics_process(delta):
	velocity.x = 0
	var snap = 3

	if activo:
		get_input()
		if velocity.y != 0:
			snap = Vector2(0,0)
			if estaVivo:
				$AnimatedSprite.play("jump")
		move_and_slide_with_snap(velocity, Vector2.DOWN * snap, Vector2(0, -1), false)

		

	if is_on_floor():
		velocity.y = 0 
	else:
		velocity.y += gravity * delta

	if is_on_ceiling():
		velocity.y = 0 

func _on_Muerte_timeout():
	queue_free()
