extends Node2D

onready var player = $Player
export var cantDeClones = 3
onready var plataformaH = $Plataformas/PlataformasMoviles/PlatBot/Plataforma
onready var plataformaV1 = $Plataformas/PlataformasMoviles/PlatBot2/Plataforma
onready var plataformaV2 = $Plataformas/PlataformasMoviles/PlatBot3/Plataforma
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
	plataformaH.start(0, 0, 0, 140)
	plataformaV1.start(95, 0, 0, 0)
	plataformaV2.start(95, 0, 0, 0)
	if !global.musicaActiva:
		global.activarMusica()
	if global.test:
		for light in get_tree().get_nodes_in_group("light"):
			light.enabled = false
			$Background/CanvasModulate.visible = false
			$Background2/CanvasModulate.visible = false


# warning-ignore:unused_argument
func _physics_process(delta):
	if player.activo:
		$Camera2D.position =  player.position
	elif player.new_clon != null:
		$Camera2D.position =  player.new_clon.position

func _on_Boton_apretado():
	plataformaH.derecha(0.5)

func _on_Boton_suelto():
	plataformaH.izquierda(0.5)

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

func _on_BotonV1_apretado():
	plataformaV1.subir(0.5)

func _on_BotonV1_suelto():
	plataformaV1.bajar(0.5)

func _on_BotonV2_apretado():
	plataformaV2.subir(0.5)

func _on_BotonV2_suelto():
	plataformaV2.bajar(0.5)

func _win_game(body):
	if body.is_in_group("player"):
		player.win()
		$win.play()
