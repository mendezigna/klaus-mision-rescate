extends Node2D

onready var plataforma1 = $plataforma1/Plataforma
onready var plataforma2 = $plataforma2/Plataforma
onready var player = $Player
export var cantDeClones = 3

##Cuando se inicia, se le setea una cantidad limite de clones al jugador.
func _ready():
	player.setCantLimiteClones(cantDeClones)
	
	$PlatBot/Plataforma.start(0, 0, 0, 140)
	#plataforma1.start(50, 0, 0, 0)

##Cuando el boton se apreta, la  plataforma sube.
##Cada boton interactua con su plataforma.
func _on_Boton_apretado():
	plataforma1.subir(0.5)

func _on_Boton_suelto():
	plataforma1.bajar(0.5)

func _on_Boton2_apretado():
	plataforma2.move_and_slide(Vector2(0,-15))

func _on_Boton3_apretado():
	plataforma1.move_and_slide(Vector2(0,-3))

##Cuando se pierde, se inicializa un timer para dar unos segundos antes de arrancar el juego de nuevo.
##Se le informa al jugador que murio.
func _on_game_over():
	$TimerDead.start()
	$Player.morir()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
	get_tree().reload_current_scene()

##Se borra el clon tras su muerte.
func _on_delete_clone(clone):
	$Player.remove_clon(clone)

func _on_Boton4_apretado():
	$PlatBot/Plataforma.derecha(0.5)

func _on_Boton4_suelto():
	$PlatBot/Plataforma.izquierda(0.5)
