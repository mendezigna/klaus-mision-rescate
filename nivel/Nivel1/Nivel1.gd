extends Node2D

onready var player = $Player
export var cantDeClones = 3
onready var plataforma1 = $Plataformas/plataforma1/Plataforma
onready var plataforma2 = $Plataformas/plataforma2/Plataforma


func _ready():
	player.setCantLimiteClones(cantDeClones)
	plataforma1.start(50, 0, 0, 0)
	plataforma2.start(115, 0, 0, 0)
	
	
# warning-ignore:unused_argument
func _physics_process(delta):
		if Input.is_action_just_pressed("clonar"):
			get_tree().get_nodes_in_group("label")[0].text = "SHIFT: \nvolver a klaus"
		if player.activo:
			$Camera2D.position =  player.position
		elif player.new_clon != null:
			$Camera2D.position =  player.new_clon.position

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






