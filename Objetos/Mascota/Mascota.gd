extends Area2D

var estaSentado = true
var estaCaminando = false

func _ready():
	$Mascota.play("quieto")
	
func correr():
	$Mascota.play("correr")
	$Mascota.offset.y = -15
	
func caminar():
	$Mascota.play("caminar")
	$Mascota.offset.y = -15
	estaSentado = false

func _physics_process(delta):
	if (!estaSentado):
		if (estaCaminando):
			position.x -= 0.2
		else: 
			position.x -= 0.5


func rencuentro():
	$Mascota.play("rencuentro")
	estaSentado = true


func _on_Mascota_body_entered(body):
	rencuentro()
