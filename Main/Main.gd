extends Node2D
export (PackedScene) var firstLevel

func _on_Interface_start():
	get_tree().change_scene_to(firstLevel)
