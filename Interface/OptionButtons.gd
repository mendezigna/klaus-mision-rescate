extends Control
export  (String, FILE) var next_scene_path: = ""  


func _on_ResertButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	get_node("/root/Global").inicioNivel = false
	get_tree().paused = false


func _on_HomeButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(next_scene_path)
	get_node("/root/Global").inicioNivel = false
	get_tree().paused = false

func _on_PauseButton_toggled(button_pressed):
	if (button_pressed):
		$PauseButton/pause.hide()
		$PauseButton/playb.show()
		get_tree().paused = true
	else: 
		$PauseButton/pause.show()
		$PauseButton/playb.hide()
		get_tree().paused = false
