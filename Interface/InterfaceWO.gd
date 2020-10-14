extends Node2D
export  (String, FILE) var next_scene_path: = ""

func _on_Button_pressed():
	print(next_scene_path)
	get_tree().change_scene(next_scene_path)
