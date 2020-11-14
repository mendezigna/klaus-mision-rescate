extends Node2D

onready var boss = $Boss
onready var player = $Player
export var cantDeClones = 3
export var test = false
onready var plataforma1 = $plataformas/plataforma1/Plataforma
var yaSePresentoElNivel = false


func _ready():
	player.setCantLimiteClones(cantDeClones)
	boss.personajePosition(player.position)
	plataforma1.start(300, 0, 0, 0)
	
	if test:
		for light in get_tree().get_nodes_in_group("light"):
			light.enabled = false
			$Background/CanvasModulate.visible = false
			$Background2/CanvasModulate.visible = false
	
	player.desactivar()
	enfocar_al_boss_y_mostrar_el_nivel()
	player.activar()


func enfocar_al_boss_y_mostrar_el_nivel():
	$Camera2D.position =  player.position
	$PresentarElNivel/TiempoDePresentacionDelPersonaje.start()
	


func _on_TiempoDePresentacionDelPersonaje_timeout():
	$Camera2D.position =  boss.position
	$PresentarElNivel/TiempoDePresentacionDelBoss.start()


func _on_TiempoDePresentacionDelBoss_timeout():
	mostrar_el_nivel()


func mostrar_el_nivel():
#	while(true):
#		$Camera2D.position = 
	pass




# warning-ignore:unused_argument
func _physics_process(delta):
	if yaSePresentoElNivel:
		if player.activo:
			$Camera2D.position =  player.position
		elif player.new_clon != null:
			$Camera2D.position =  player.new_clon.position
		boss.personajePosition(player.position)


func _on_game_over():
	$TimerDead.start()
	boss.playerMurio()
	player.morir()

##Cuando el tiempo se termine, reinicia el nivel.
func _on_TimerDead_timeout():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

##Se borra el clon tras su muerte.
func _on_delete_clone(clone):
	player.remove_clon(clone)


func _win_game(body):
	if body.is_in_group("player"):
		player.win()
		$win.play()


func _on_Boton_apretado():
	plataforma1.subir(0.5)

func _on_Boton_suelto():
	plataforma1.bajar(0.5)



