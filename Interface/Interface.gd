extends Control

signal start
onready var global = get_node("/root/Global")
func _on_CheckButton_pressed():
	global.test = !global.test


func _on_TextureButton_pressed():
	$TextureButton.hide()
	emit_signal("start")
	global.inicioNivel = false
