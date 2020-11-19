extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
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
		$EfectoCheckPoint.play("activo")


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.stop()
	$AnimatedSprite.hide()
