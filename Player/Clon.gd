extends KinematicBody2D

var velocity = Vector2()

export var run_speed = 50
export var jump_speed = -50
export var gravity = 100
var colors = ["fffb00", "d74b4b", "4f7ddf", "b76fd8"]
var activo = true

func cambiarColor(i):
	modulate = colors[i] 

func get_input():
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

func desactivar():
	activo = false
	$AnimatedSprite.play("stop")
	$Camera2D.current = false

func activar():
	activo = true
	$Camera2D.current = true

func _physics_process(delta):
	velocity.y += gravity * delta
	velocity.x = 0
	if activo:
		get_input()
		velocity = move_and_slide(velocity, Vector2(0, -1), false, 4, PI/4, false)
