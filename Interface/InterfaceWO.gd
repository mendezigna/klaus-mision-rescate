extends Node2D
export  (String, FILE) var next_scene_path: = ""

func _on_TextureButton_pressed():
	get_tree().change_scene(next_scene_path)
