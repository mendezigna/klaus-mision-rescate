extends Node2D
signal start

func _on_Button_pressed():
	$StartBtn.hide()
	emit_signal("start")
