extends Node2D
export (PackedScene) var firstLevel

func _ready():
	$AudioFondo.playing = true
	

func _on_Interface_start():
	get_tree().change_scene_to(firstLevel)
