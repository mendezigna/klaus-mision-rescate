extends Node2D

onready var player = $Player
export var cantDeClones = 3
onready var plataforma1 = $plataforma1/Plataforma
onready var plataforma2 = $plataforma2/Plataforma


func _ready():
	player.setCantLimiteClones(cantDeClones)
	plataforma1.start(50, 0, 0, 0)
	plataforma2.start(115, 0, 0, 0)
	
##Cuando el boton se apreta, la  plataforma sube.
##Cada boton interactua con su plataforma.
func _on_Boton_apretado():
	plataforma1.subir(0.5)

func _on_Boton_suelto():
	plataforma1.bajar(0.5)

func _on_Boton2_apretado():
	plataforma2.subir(0.5)

func _on_Boton2_suelto():
	plataforma2.bajar(0.5)
##Se le informa al jugador que murio.
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






