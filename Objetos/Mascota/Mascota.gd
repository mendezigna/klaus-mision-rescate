extends Area2D

var estaSentado = true
var estaCaminando = false
onready var sprite = $Mascota
export var dir = 1
export var velCorrer = 0.7

func _ready():
	sprite.play("quieto")
	sprite.offset.y = -15
	
func correr():
	sprite.play("correr")
	sprite.offset.y = -15
	
func caminar():
	sprite.play("caminar")
	sprite.offset.y = -15
	estaSentado = false

# warning-ignore:unused_argument
func _physics_process(delta):
	if (!estaSentado):
		if (estaCaminando):
			position.x -= 0.4 * dir
		else: 
			position.x -= velCorrer * dir


func rencuentro():
	sprite.play("rencuentro")
	estaSentado = true


func _on_Mascota_body_entered(body):
	if body.is_in_group("player"):
		rencuentro()
