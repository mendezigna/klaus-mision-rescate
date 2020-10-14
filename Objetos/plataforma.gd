extends StaticBody2D

var max_top
var max_bottom
var max_left
var max_right


func start(top = 0, bottom = 0, left = 0, right = 0):
	max_top = global_position.y - top
	max_bottom = global_position.y + bottom
	max_left = global_position.x - left
	max_right = global_position.x + right
	
func subir(cant):

	if global_position.y > max_top:
		position.y -= cant

func bajar(cant):
	if global_position.y < max_bottom:
		position.y += cant

func derecha(cant):
	if global_position.x < max_right:
		position.x += cant

func izquierda(cant):
	if global_position.x > max_left:
		position.x -= cant

