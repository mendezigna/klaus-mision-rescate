extends Control

signal start


func _on_CheckButton_pressed():
	get_node("/root/Global").test = !get_node("/root/Global").test


func _on_TextureButton_pressed():
	$TextureButton.hide()
	emit_signal("start")
	get_node("/root/Global").inicioNivel = false
