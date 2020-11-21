extends Node2D
export (PackedScene) var firstLevel
onready var global = get_node("/root/Global")

func _ready():
	
	global.desactivarMusica()
	global.test = false
	global.inicioNivel = false
	global.animacionBossHecha = false
	global.tocoElCheckPoint = false

	$Interface/Background/CanvasModulate.hide()

func _on_Interface_start():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(firstLevel)

