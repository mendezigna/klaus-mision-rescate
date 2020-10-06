extends Area2D

signal hit


func _on_Pinche_body_entered(body):
	emit_signal("hit")
