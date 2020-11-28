extends Node2D
export  (String, FILE) var next_scene_path: = ""

func _on_TextureButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_scene_path)
	get_node("/root/Global").inicioNivel = false
