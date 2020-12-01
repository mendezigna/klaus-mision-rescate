extends Node2D

onready var player = $Player
export var cantDeClones = 3
onready var global = get_node("/root/Global")
onready var checkpointPosition = $CheckPoint/Position2D
onready var camara = $Camera2D

func _ready():
	if global.inicioNivel:
		checkpointPosition.global_position = global.positionCheckPoint
		$CheckPoint/CheckPoint.play(checkpointPosition.global_position)
	else:
		global.positionCheckPoint = checkpointPosition.global_position
	player.global_position = checkpointPosition.global_position
	global.inicioNivel = true
	
	player.setCantLimiteClones(cantDeClones)
	if !global.musicaActiva:
		global.activarMusica()
	if global.test:
		for light in get_tree().get_nodes_in_group("light"):
			light.enabled = false
			$Background/CanvasModulate.visible = false
	if global.mute:
		for i in get_tree().get_nodes_in_group("musica"):
			i.stream_paused = true
	
# warning-ignore:unused_argument
func _physics_process(delta):
	if player.activo:
		camara.position =  player.position
	elif player.new_clon != null:
		camara.position =  player.new_clon.position
		
func _on_game_over():
	if !global.tocoElCheckPoint:
		global.inicioNivel = false
	if player.estaVivo:
		$TimerDead.start()
		player.morir()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

##Se borra el clon tras su muerte.
func _on_delete_clone(clone):
	if !player.activo:
		player.puedeMoverse = false
	player.remove_clon(clone)

# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_body_entered(viewport, event, shape_idx):
	pass # Replace with function body.



