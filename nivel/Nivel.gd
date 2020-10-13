extends Node2D

onready var plataforma1 = $plataforma1/Plataforma
onready var plataforma2 = $plataforma2/Plataforma
onready var player = $Player
export var cantDeClones = 3

##Cuando se inicia, se le setea una cantidad limite de clones al jugador.
func _ready():
	player.setCantLimiteClones(cantDeClones)

##Cuando el boton se apreta, la  plataforma sube.
##Cada boton interactua con su plataforma.
func _on_Boton_apretado():
	plataforma1.apply_central_impulse(Vector2(0, -3))

func _on_Boton2_apretado():
	plataforma2.apply_central_impulse(Vector2(0, -30))

##Cuando se pierde, se inicializa un timer para dar unos segundos antes de arrancar el juego de nuevo.
##Se le informa al jugador que murio.
func _on_game_over():
	$TimerDead.start()
	$Player.morir()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
	get_tree().reload_current_scene()

##Se borra el clone dado.
func _on_delete_clone(clone):
	$Player.remove_clon(clone)
