extends Node2D

onready var player = $Player
export var cantDeClones = 4
onready var global = get_node("/root/Global")
onready var camara = $Camera2D
onready var mascota = $Mascota

func _ready():
	player.setCantLimiteClones(cantDeClones)
	global.desactivarMusica()
	$Player/Perdiste/OptionButtons.hide()
	
	if global.test:
		for light in get_tree().get_nodes_in_group("light"):
			light.enabled = false
			$Background/CanvasModulate.visible = false

# warning-ignore:unused_argument
func _physics_process(delta):
	if player.activo:
		camara.position =  player.position
	elif player.new_clon != null:
		camara.position =  player.new_clon.position

func _on_game_over():
	if !global.tocoElCheckPoint:
		global.inicioNivel = false
	$TimerDead.start()
	player.morir()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

##Se borra el clon tras su muerte.
func _on_delete_clone(clone):
	player.puedeMoverse = false
	player.remove_clon(clone)

func _win_game(body):
	if body.is_in_group("player"):
		player.win()

func _on_colision1_body_entered(body):
	player.remover_clones()
	if body.is_in_group("player"):
		player.puedeComenzarNivel(false)
		mascota.caminar()

func _on_colision2_entered(area):
	mascota.correr()
