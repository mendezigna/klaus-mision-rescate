extends Node2D

onready var player = $Player
export var cantDeClones = 3
export var test = false

func _ready():
	player.setCantLimiteClones(cantDeClones)
	if test:
		for light in get_tree().get_nodes_in_group("light"):
			light.enabled = false
			$Background/CanvasModulate.visible = false
	
# warning-ignore:unused_argument
func _physics_process(delta):
	if player.activo:
		$Camera2D.position =  player.position
	elif player.new_clon != null:
		$Camera2D.position =  player.new_clon.position
		
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
