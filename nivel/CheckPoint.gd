extends Area2D

func _ready():
	$AnimatedSprite.hide()

func play(nivelPosition):
	$AnimatedSprite.show()
	$AnimatedSprite.global_position.x = nivelPosition.x
	$AnimatedSprite.global_position.y = nivelPosition.y - 10
	$AnimatedSprite.play("portal")

func _on_CheckPoint_body_entered(body):
	if body.is_in_group("player"):
		get_node("/root/Global").positionCheckPoint = global_position
		get_node("/root/Global").tocoElCheckPoint = true
		$EfectoCheckPoint.play("activo")


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	$AnimatedSprite.hide()
