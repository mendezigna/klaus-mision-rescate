extends Control
export  (String, FILE) var next_scene_path: = ""  


func _on_ResertButton_pressed():
	get_tree().reload_current_scene()
	get_node("/root/Global").inicioNivel = false

func _on_HomeButton_pressed():
	get_tree().change_scene(next_scene_path)
	get_node("/root/Global").inicioNivel = false

