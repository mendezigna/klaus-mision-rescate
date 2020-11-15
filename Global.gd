extends Node

var test = false
var musicaActiva = false
var animacionBossHecha = false

func desactivarMusica():
	musicaActiva = false
	$AudioStreamPlayer2D.playing = false
	
func activarMusica():
	musicaActiva = true
	$AudioStreamPlayer2D.playing = true
