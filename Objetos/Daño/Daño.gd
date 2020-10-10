extends Area2D

signal hit
signal hitClone

func _on_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("hit")
	if body.is_in_group("clon"):
		emit_signal("hitClone")
		
