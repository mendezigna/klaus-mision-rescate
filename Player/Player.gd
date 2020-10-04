extends KinematicBody2D

var velocity = Vector2()

export var run_speed = 100
export var jump_speed = -150
export var gravity = 500

func get_input():
	velocity.x = 0
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


func _physics_process(delta):
	velocity.y += gravity * delta
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1), false, 4, PI/4, false)
