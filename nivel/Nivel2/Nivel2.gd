extends Node2D

onready var player = $Player
export var cantDeClones = 3

func _ready():
	player.setCantLimiteClones(cantDeClones)

func _on_game_over():
	$TimerDead.start()
	player.morir()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

##Se borra el clon tras su muerte.
func _on_delete_clone(clone):
	player.remove_clon(clone)
