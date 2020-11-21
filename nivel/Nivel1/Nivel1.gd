extends Node2D

onready var player = $Player
export var cantDeClones = 3
onready var plataforma1 = $Plataformas/plataforma1/Plataforma
onready var plataforma2 = $Plataformas/plataforma2/Plataforma
onready var global = get_node("/root/Global")

func _ready():
	if global.inicioNivel:
		$CheckPoint/Position2D.global_position = global.positionCheckPoint
		$CheckPoint/CheckPoint.play($CheckPoint/Position2D.global_position)
	else:
		global.positionCheckPoint = $CheckPoint/Position2D.global_position
	player.global_position = $CheckPoint/Position2D.global_position
	global.inicioNivel = true
	
	
	player.setCantLimiteClones(cantDeClones)
	plataforma1.start(50, 0, 0, 0)
	plataforma2.start(115, 0, 0, 0)
	if !global.musicaActiva:
		global.activarMusica()
	
	if global.test:
		for light in get_tree().get_nodes_in_group("light"):
			light.enabled = false
			$Background/CanvasModulate.visible = false
	
# warning-ignore:unused_argument
func _physics_process(delta):
		if Input.is_action_just_pressed("clonar"):
			$Guia/Guia2.setTexto("Presioná 'SHIFT' para volves a Klaus.")
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
	player.puedeMoverse = false
	player.remove_clon(clone)


func _on_TiempoDeEspera__timeout():
	$Guia/Node2D/Guia.setTexto("Utiliza las teclas 'A' 'W' 'D' para moverte")
