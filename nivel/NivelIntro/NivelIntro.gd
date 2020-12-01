extends Node2D
export (PackedScene) var firstLevel
onready var player = $Player
onready var global = get_node("/root/Global")
onready var camara = $Camera1
onready var mascota = $Mascota
var camaraPerro = false
var seFuePogo = false

func _ready():

	global.desactivarMusica()
	player.play("invocar")
	if global.test:
		for light in get_tree().get_nodes_in_group("light"):
			light.enabled = false

# warning-ignore:unused_argument
func _physics_process(delta):
	if !camaraPerro:
		camara.position =  player.position
	else:
		camara.position = mascota.position
	if seFuePogo:
		player.position.x +=1

func _on_Timer_timeout():
	mascota.estaSentado = false
	mascota.correr()
	camaraPerro = true

func _on_VisibilityNotifier2D_screen_exited():
	mascota.hide()
	player.flip_h = false
	player.play("walk")
	$Player/pasos.play()
	camaraPerro = false
	seFuePogo = true
	

func _on_VisibilityNotifier2D2_screen_exited():
	get_tree().change_scene_to(firstLevel)


func _on_Timer2_timeout():
	$Timers/MascotaCorre.start()
	$SonidoCueva.play()

func _on_SonidoCueva_finished():
	$SonidoCueva.playing = false
	print("hola")

