extends Area2D

export (PackedScene) var next_level


func _on_Puerta_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to(next_level)
