extends Node2D
export (PackedScene) var firstLevel

func _ready():
	get_node("/root/Global").desactivarMusica()
	$Interface/Background/CanvasModulate.hide()

func _on_Interface_start():
# warning-ignore:return_value_discarded
	get_tree().change_scene_to(firstLevel)

