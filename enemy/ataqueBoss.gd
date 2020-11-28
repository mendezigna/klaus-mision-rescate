extends "res://Objetos/Daño/Daño.gd"

func _ready():
	if get_node("/root/Global").test:
		$Light2D.enabled = false

func start(positionx, positiony):
	global_position = Vector2(positionx, positiony)

# warning-ignore:unused_argument
func _physics_process(delta):
	position.x += 1.1

func _on_Area2D_hit():
	get_parent()._on_game_over()
	
func _on_Area2D_hitClone(clone):
	get_parent()._on_delete_clone(clone)


func _on_Visibility_screen_exited():
	queue_free()


func _on_ataqueBoss_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("clon"):
		$CollisionShape2D.set_deferred("disabled", true)
		$particulas.emitting = true
		$AnimatedSprite.hide()
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
