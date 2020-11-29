extends Control
export  (String, FILE) var next_scene_path: = ""  
onready var global = get_node("/root/Global")

func _ready():
	if(global.mute):
		$MuteButton2.pressed = true

func _on_ResertButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	global.inicioNivel = false
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


func _on_PauseButton2_toggled(button_pressed):
	if(button_pressed):
		global.mute = true
		global.stopMusica()
		$MuteButton2/mute.show()
		$MuteButton2/sonido.hide()
		if global.nivelBoss:
			get_tree().get_nodes_in_group("musicaBoss")[0].stream_paused = true
		
	else:
		global.mute = false
		if global.nivelBoss:
			get_tree().get_nodes_in_group("musicaBoss")[0].stream_paused = false
		else:
			global.playMusica()
		$MuteButton2/mute.hide()
		$MuteButton2/sonido.show()
