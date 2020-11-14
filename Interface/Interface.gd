extends Node2D
signal start

func _on_Button_pressed():
	$StartBtn.hide()
	emit_signal("start")

func _on_CheckButton_pressed():
	get_node("/root/Global").test = !get_node("/root/Global").test
